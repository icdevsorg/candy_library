///////////////////////////////
//
// ©2021 @aramakme
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
///////////////////////////////

/// Properties for the candy library.
///
/// This module contains the properties and class functions for updating and 
/// manipulating classes.

import Buffer "mo:base/Buffer";
import Map "mo:map9/Map";
import Text "mo:base/Text";
import Array "mo:base/Array";
import Result "mo:base/Result";
import Iter "mo:base/Iter";
import Types "types";

module {

  type PropertiesShared = Types.PropertiesShared;
  type Query = Types.Query;
  type PropertySharedError = Types.PropertySharedError;
  type UpdateShared = Types.UpdateShared;
  type PropertyShared = Types.PropertyShared;
  type Property = Types.Property;
  type CandyShared = Types.CandyShared;
  type Properties = Types.Properties;
  type Update = Types.Update;

  private func toPropertyMap(ps : PropertiesShared) : Map.Map<Text, PropertyShared> {
    let m = Map.fromIter<Text,PropertyShared>(Iter.map<PropertyShared, (Text,PropertyShared)>(ps.vals(), func(x){
      (x.name, x)
    }), Map.thash);
   
    m;
  };

  private func fromPropertyMap(m : Map.Map<Text,PropertyShared>) : PropertiesShared {
    Iter.toArray<PropertyShared>(Map.vals<Text, PropertyShared>(m));
  };

  /// Get a subset of fields from the `PropertiesShared` based on the given query.
  ///
  /// Example:
  /// ```motoko include=import
  /// let properties: PropertiesShared = [
  ///   {
  ///    name = "prop1";
  ///    value = #Principal(Principal.fromText("abc"));
  ///    immutable = false;
  ///   },
  ///   {
  ///    name = "prop2";
  ///    value = #Nat8(44);
  ///    immutable = true;
  ///   },
  ///   {
  ///    name = "prop3";
  ///    value = #Class(
  ///     {
  ///       name = "class_field1";
  ///       value = #Nat(222);
  ///       immutable = false;
  ///     },
  ///     {
  ///       name = "class_field2";
  ///       value = #Text("sample");
  ///       immutable = true;
  ///     }
  ///    );
  ///    immutable = false;
  ///   }
  /// ];
  /// let qs = [
  ///  {
  ///    name = "prop2"
  ///  },
  ///  {
  ///    name = "prop3";
  ///    next = [
  ///      {
  ///        name = "class_field2";
  ///      }
  ///    ];
  ///  }
  /// ];
  /// // Will return prop2 and the class_field2 from prop3.
  /// let subset_result = Properties.getPropertiesShared(properties, qs);
  /// ```
  /// Note: Ignores unknown properties.
  public func getPropertiesShared(properties : PropertiesShared, qs : [Query]) : Result.Result<PropertiesShared, PropertySharedError> {    
    let m = toPropertyMap(properties);
    var ps : Buffer.Buffer<PropertyShared> = Buffer.Buffer<PropertyShared>(Map.size(m));
    for (q in qs.vals()) {
      switch (Map.get(m, Map.thash, q.name)) {
        case (null) return #err(#NotFound); // Query contained an unknown property.
        case (? p)  {
          switch (p.value) {
            case (#Class(c)) {
              if (q.next.size() == 0) {
                // Return every sub-attribute attribute.
                ps.add(p);
              } else {
                let sps = switch (getPropertiesShared(c, q.next)) {
                  case (#err(e)) return #err(e);
                  case (#ok(v)) v;
                };
                
                ps.add({
                    name      = p.name;
                    value     = #Class(sps);
                    immutable = p.immutable;
                });
              };
            };
            case (other) {
              // Not possible to get sub-attribute of a non-class property.
              if (q.next.size() != 0) return #err(#NotFound);
              ps.add(p);
            };
          }
        };
      };
    };
    #ok(Buffer.toArray(ps));
  };

  /// Updates the given properties based on the given update query.
  ///
  /// Example:
  /// ```motoko include=import
  /// let properties: PropertiesShared = [
  ///   {
  ///    name = "prop1";
  ///    value = #Principal(Principal.fromText("abc"));
  ///    immutable = true;
  ///   },
  ///   {
  ///    name = "prop2";
  ///    value = #Nat8(44);
  ///    immutable = false;
  ///   },
  ///   {
  ///    name = "prop3";
  ///    value = #Class(
  ///     {
  ///       name = "class_field1";
  ///       value = #Nat(222);
  ///       immutable = false;
  ///     },
  ///     {
  ///       name = "class_field2";
  ///       value = #Text("sample");
  ///       immutable = true;
  ///     }
  ///    );
  ///    immutable = false;
  ///   }
  /// ];
  /// let us = [
  ///  {
  ///    name = "prop1",
  ///    mode = #Set(#Nat8(66))
  ///  },
  ///  {
  ///    name = "prop3";
  ///    mode = #Next([
  ///     {
  ///       name = "class_field1";
  ///       mode = #Lock(#Nat(333)); 
  ///     }
  ///    ])
  ///  }
  /// ];
  /// // Will update prop1 and the class_field1 from prop3 to new values.
  /// let updated_properties = Properties.updatePropertiesShared(properties, us);
  /// ```
  /// Note:
  /// - Creates unknown properties.
  /// - Returns error if the query tries to update an immutable property.
  public func updatePropertiesShared(properties : PropertiesShared, us : [UpdateShared]) : Result.Result<PropertiesShared, PropertySharedError> {
    let m = toPropertyMap(properties);
    for (u in us.vals()) {
      switch (Map.get(m, Map.thash, u.name)) {
        case (null) {
          // Update contained an unknown property, so it gets created.
          switch (u.mode) {
              case (#Next(sus)) {
                let sps = switch(updatePropertiesShared([], sus)) {
                    case (#err(e)) return #err(e);
                    case (#ok(v)) v;
                };
                
                ignore Map.put(m, Map.thash, u.name, {
                  name      = u.name;
                  value     = #Class(sps);
                  immutable = false;
                });
              };
              case (#Set(v)) {
                ignore Map.put(m, Map.thash, u.name, {
                  name      = u.name;
                  value     = v;
                  immutable = false;
                });
              };
              case (#Lock(v)) {
                ignore Map.put(m, Map.thash, u.name, {
                  name      = u.name;
                  value     = v;
                  immutable = true;
                });
              };
          };
        };
        case (? p)  {
          // Can not update immutable property.
          if (p.immutable) {
              return #err(#Immutable);
          };
          switch (u.mode) {
            case (#Next(sus)) {
              switch (p.value) {
                case (#Class(c)) {
                  let sps = switch(updatePropertiesShared(c, sus)) {
                    case (#err(e)) return #err(e);
                    case (#ok(v)) v;
                  };
                  
                  ignore Map.put(m, Map.thash, u.name, {
                    name      = p.name;
                    value     = #Class(sps);
                    immutable = false;
                  });
                };
                case (other)  return #err(#NotFound); // Not possible to update sub-attribute of a non-class property.
              };
              return #err(#NotFound);
            };
            case (#Set(v)) {
              ignore Map.put(m, Map.thash, u.name, {
                  name      = p.name;
                  value     = v;
                  immutable = false;
              });
            };
            case (#Lock(v)) {
              ignore Map.put(m, Map.thash, u.name, {
                  name      = p.name;
                  value     = v;
                  immutable = true;
              });
            };
          };
        };
      };
    };
      
    #ok(fromPropertyMap(m));
  };

  /// Updates the given properties based on the given update query.
  ///
  /// Example:
  /// ```motoko include=import
  /// let c  = #Class(
  ///  {
  ///    name = "class_field1";
  ///    value = #Nat(222);
  ///    immutable = false;
  ///  },
  ///  {
  ///    name = "class_field2";
  ///    value = #Text("sample");
  ///    immutable = true;
  ///  }
  /// );
  /// let prop = Properties.getClassPropertyShared(c, "class_field1");
  /// ```
  /// Note: Returns null if:
  /// - The underlying value isn't a #Class.
  /// - The property with the given name wasn't found inside the class.
  public func getClassPropertyShared(val: CandyShared, name : Text) : ?PropertyShared{   
    switch(val){
      case(#Class(val)){
        for(thisItem in val.vals()){
          if(thisItem.name == name){
              return ?thisItem;
          };
        };
        
        return null;

      };
      case(_){
        //assert(false);
        //unreachable
        return null;
      }
    };
  };

  ////////////////////////////////////
  //
  // The following functions were copied from departurelabs' property.mo.  They work as a plug and play
  // here with CandyShared and Candy.
  //
  // https://github.com/DepartureLabsIC/non-fungible-token/blob/main/src/property.mo
  //
  // The following lines are issued under the MIT License Copyright (c) 2021 Departure Labs:
  //
  ///////////////////////////////////

  private func toPropertySharedMap(ps : Properties) : Map.Map<Text, PropertyShared> {
    let m = Map.new<Text, PropertyShared>();
    for (property in Map.vals<Text, Property>(ps)) {
      ignore Map.put(m, Map.thash, property.name, Types.shareProperty(property));
    };
    m;
  };

  private func fromPropertySharedMap(m : Map.Map<Text, PropertyShared>) : Properties { 
    Map.fromIter<Text, Property>(Iter.map<PropertyShared, (Text, Property)>(Map.vals(m), func(x){(x.name, Types.unshareProperty(x))}), Map.thash);
  };

  /// Get a subset of fields from the `Properties` based on the given query.
  ///
  /// Example:
  /// ```motoko include=import
  /// let properties: Properties = [
  ///   {
  ///    name = "prop1";
  ///    value = #Principal(Principal.fromText("abc"));
  ///    immutable = false;
  ///   },
  ///   {
  ///    name = "prop2";
  ///    value = #Nat8(44);
  ///    immutable = true;
  ///   },
  ///   {
  ///    name = "prop3";
  ///    value = #Class(
  ///     {
  ///       name = "class_field1";
  ///       value = #Nat(222);
  ///       immutable = false;
  ///     },
  ///     {
  ///       name = "class_field2";
  ///       value = #Text("sample");
  ///       immutable = true;
  ///     }
  ///    );
  ///    immutable = false;
  ///   }
  /// ];
  /// let qs = [
  ///  {
  ///    name = "prop2"
  ///  },
  ///  {
  ///    name = "prop3";
  ///    next = [
  ///      {
  ///        name = "class_field2";
  ///      }
  ///    ];
  ///  }
  /// ];
  /// // Will return prop2 and the class_field2 from prop3.
  /// let subset_result = Properties.getProperties(properties, qs);
  /// ```
  /// Note: Ignores unknown properties.
  public func getProperties(properties : Properties, qs : [Query]) : Result.Result<Properties, PropertySharedError> {
    let m = properties;
    var ps : Buffer.Buffer<Property> = Buffer.Buffer<Property>(1);
    for (q in qs.vals()) {
      switch (Map.get(m, Map.thash, q.name)) {
        case (null) {
          // Query contained an unknown property.
          //return #err(#NotFound);
          //for now, ignore unfound properteis
        };
        case (? p)  {
          switch (p.value) {
            case (#Class(c)) {
              if (q.next.size() == 0) {
                // Return every sub-attribute attribute.
                ps.add(p);
              } else {
                let sps = switch (getProperties(c, q.next)) {
                  case (#err(e)) return #err(e);
                  case (#ok(v)) v;
                };
                
                ps.add({
                  name      = p.name;
                  value     = #Class(sps);
                  immutable = p.immutable;
                });
              };
            };
            case (other) {
              // Not possible to get sub-attribute of a non-class property.
              if (q.next.size() != 0) return #err(#NotFound);
              ps.add(p);
            };
          }
        };
      };
    };
    #ok(Map.fromIter<Text, Property>(
      Iter.map<Property, (Text, Property)>(ps.vals(), 
      func(x){(x.name, x)}
      ), Map.thash
    ));
  };

  /// Updates the given properties based on the given update query.
  ///
  /// Example:
  /// ```motoko include=import
  /// let properties: Properties = [
  ///   {
  ///    name = "prop1";
  ///    value = #Principal(Principal.fromText("abc"));
  ///    immutable = true;
  ///   },
  ///   {
  ///    name = "prop2";
  ///    value = #Nat8(44);
  ///    immutable = false;
  ///   },
  ///   {
  ///    name = "prop3";
  ///    value = #Class(
  ///     {
  ///       name = "class_field1";
  ///       value = #Nat(222);
  ///       immutable = false;
  ///     },
  ///     {
  ///       name = "class_field2";
  ///       value = #Text("sample");
  ///       immutable = true;
  ///     }
  ///    );
  ///    immutable = false;
  ///   }
  /// ];
  /// let us = [
  ///  {
  ///    name = "prop1",
  ///    mode = #Set(#Nat8(66))
  ///  },
  ///  {
  ///    name = "prop3";
  ///    mode = #Next([
  ///     {
  ///       name = "class_field1";
  ///       mode = #Lock(#Nat(333)); 
  ///     }
  ///    ])
  ///  }
  /// ];
  /// // Will update prop1 and the class_field1 from prop3 to new values.
  /// let updated_properties = Properties.updateProperties(properties, us);
  /// ```
  /// Note: 
  /// - Creates unknown properties.
  /// - Returns error if the query tries to update an immutable property.
  public func updateProperties(properties : Properties, us : [Update]) : Result.Result<Properties, PropertySharedError> {
    let m = properties;
    for (u in us.vals()) {
      switch (Map.get(m, Map.thash, u.name)) {
        case (null) {
          // Update contained an unknown property, so it gets created.
          switch (u.mode) {
            case (#Next(sus)) {
              let sps = switch(updateProperties(Map.new<Text,Property>(), sus)) {
                case (#err(e)) return #err(e);
                case (#ok(v)) v;
              };
              
              ignore Map.put(m, Map.thash, u.name, {
                name      = u.name;
                value     = #Class(sps);
                immutable = false;
              });
            };
            case (#Set(v)) {
              ignore Map.put(m, Map.thash, u.name, {
                  name      = u.name;
                  value     = v;
                  immutable = false;
              });
            };
            case (#Lock(v)) {
              ignore Map.put(m, Map.thash, u.name, {
                name      = u.name;
                value     = v;
                immutable = true;
              });
            };
          };
        };
        case (? p)  {
          // Can not update immutable property.
          if (p.immutable) return #err(#Immutable);

          switch (u.mode) {
            case (#Next(sus)) {
              switch (p.value) {
                case (#Class(c)) {
                  let sps = switch(updateProperties(c, sus)) {
                    case (#err(e)) return #err(e);
                    case (#ok(v)) v;
                  };
                  
                  ignore Map.put(m, Map.thash, u.name, {
                    name      = p.name;
                    value     = #Class(sps);
                    immutable = false;
                  });
                };
                case (other) return #err(#NotFound); // Not possible to update sub-attribute of a non-class property.
              };
              return #err(#NotFound);
            };
            case (#Set(v)) {
              ignore Map.put(m, Map.thash, u.name, {
                name      = p.name;
                value     = v;
                immutable = false;
              });
            };
            case (#Lock(v)) {
              ignore Map.put(m, Map.thash, u.name, {
                name      = p.name;
                value     = v;
                immutable = true;
              });
            };
          };
        };
      };
    };
    
    #ok(m);
  };

  ////////////////////////////////////
  //
  // End code from Departure labs property.mo
  //
  ///////////////////////////////////

}
