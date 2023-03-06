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
import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Array "mo:base/Array";
import Result "mo:base/Result";
import Types "types";

module {

  type PropertiesUnstable = Types.PropertiesUnstable;
  type Query = Types.Query;
  type PropertyError = Types.PropertyError;
  type UpdateUnstable = Types.UpdateUnstable;
  type Property = Types.Property;
  type PropertyUnstable = Types.PropertyUnstable;
  type CandyValue = Types.CandyValue;
  type Properties = Types.Properties;
  type Update = Types.Update;

  private func toPropertyUnstableMap(ps : PropertiesUnstable) : HashMap.HashMap<Text,PropertyUnstable> {
    let m = HashMap.HashMap<Text,PropertyUnstable>(ps.size(), Text.equal, Text.hash);
    for (property in ps.vals()) m.put(property.name, property);
    m;
  };

  private func fromPropertyUnstableMap(m : HashMap.HashMap<Text,PropertyUnstable>) : PropertiesUnstable {
    var ps : Buffer.Buffer<PropertyUnstable> = Buffer.Buffer<PropertyUnstable>(m.size());
    for ((_, p) in m.entries()) ps.add(p);
    ps.toArray();
  };

  /// Get a subset of fields from the `PropertiesUnstable` based on the given query.
  ///
  /// Example:
  /// ```motoko include=import
  /// let properties: PropertiesUnstable = [
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
  /// let subset_result = Properties.getPropertiesUnstable(properties, qs);
  /// ```
  /// Note: Ignores unknown properties.
  public func getPropertiesUnstable(properties : PropertiesUnstable, qs : [Query]) : Result.Result<PropertiesUnstable, PropertyError> {    
    let m = toPropertyUnstableMap(properties);
    var ps : Buffer.Buffer<PropertyUnstable> = Buffer.Buffer<PropertyUnstable>(m.size());
    for (q in qs.vals()) {
      switch (m.get(q.name)) {
        case (null) return #err(#NotFound); // Query contained an unknown property.
        case (? p)  {
          switch (p.value) {
            case (#Class(c)) {
              if (q.next.size() == 0) {
                // Return every sub-attribute attribute.
                ps.add(p);
              } else {
                let sps = switch (getPropertiesUnstable(c, q.next)) {
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
    #ok(ps.toArray());
  };

  /// Updates the given properties based on the given update query.
  ///
  /// Example:
  /// ```motoko include=import
  /// let properties: PropertiesUnstable = [
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
  /// let updated_properties = Properties.updatePropertiesUnstable(properties, us);
  /// ```
  /// Note:
  /// - Creates unknown properties.
  /// - Returns error if the query tries to update an immutable property.
  public func updatePropertiesUnstable(properties : PropertiesUnstable, us : [UpdateUnstable]) : Result.Result<PropertiesUnstable, PropertyError> {
    let m = toPropertyUnstableMap(properties);
    for (u in us.vals()) {
      switch (m.get(u.name)) {
        case (null) {
          // Update contained an unknown property, so it gets created.
          switch (u.mode) {
              case (#Next(sus)) {
                let sps = switch(updatePropertiesUnstable([], sus)) {
                    case (#err(e)) return #err(e);
                    case (#ok(v)) v;
                };
                
                m.put(u.name, {
                  name      = u.name;
                  value     = #Class(sps);
                  immutable = false;
                });
              };
              case (#Set(v)) {
                m.put(u.name, {
                  name      = u.name;
                  value     = v;
                  immutable = false;
                });
              };
              case (#Lock(v)) {
                m.put(u.name, {
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
                  let sps = switch(updatePropertiesUnstable(c, sus)) {
                    case (#err(e)) return #err(e);
                    case (#ok(v)) v;
                  };
                  
                  m.put(u.name, {
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
              m.put(u.name, {
                  name      = p.name;
                  value     = v;
                  immutable = false;
              });
            };
            case (#Lock(v)) {
              m.put(u.name, {
                  name      = p.name;
                  value     = v;
                  immutable = true;
              });
            };
          };
        };
      };
    };
      
    #ok(fromPropertyUnstableMap(m));
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
  /// let prop = Properties.getClassProperty(c, "class_field1");
  /// ```
  /// Note: Returns null if:
  /// - The underlying value isn't a #Class.
  /// - The property with the given name wasn't found inside the class.
  public func getClassProperty(val: CandyValue, name : Text) : ?Property{   
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
  // here with CandyValue and CandyValueUnstable.
  //
  // https://github.com/DepartureLabsIC/non-fungible-token/blob/main/src/property.mo
  //
  // The following lines are issued under the MIT License Copyright (c) 2021 Departure Labs:
  //
  ///////////////////////////////////

  private func toPropertyMap(ps : Properties) : HashMap.HashMap<Text,Property> {
    let m = HashMap.HashMap<Text,Property>(ps.size(), Text.equal, Text.hash);
    for (property in ps.vals()) {
      m.put(property.name, property);
    };
    m;
  };

  private func fromPropertyMap(m : HashMap.HashMap<Text,Property>) : Properties { 
    var ps : Buffer.Buffer<Property> = Buffer.Buffer(m.size());
    for ((_, p) in m.entries()) {
      ps.add(p);
    };
    ps.toArray();
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
  public func getProperties(properties : Properties, qs : [Query]) : Result.Result<Properties, PropertyError> {
    let m = toPropertyMap(properties);
    var ps : Buffer.Buffer<Property> = Buffer.Buffer<Property>(m.size());
    for (q in qs.vals()) {
      switch (m.get(q.name)) {
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
    #ok(ps.toArray());
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
  public func updateProperties(properties : Properties, us : [Update]) : Result.Result<Properties, PropertyError> {
    let m = toPropertyMap(properties);
    for (u in us.vals()) {
      switch (m.get(u.name)) {
        case (null) {
          // Update contained an unknown property, so it gets created.
          switch (u.mode) {
            case (#Next(sus)) {
              let sps = switch(updateProperties([], sus)) {
                case (#err(e)) return #err(e);
                case (#ok(v)) v;
              };
              
              m.put(u.name, {
                name      = u.name;
                value     = #Class(sps);
                immutable = false;
              });
            };
            case (#Set(v)) {
              m.put(u.name, {
                  name      = u.name;
                  value     = v;
                  immutable = false;
              });
            };
            case (#Lock(v)) {
              m.put(u.name, {
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
                  
                  m.put(u.name, {
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
              m.put(u.name, {
                name      = p.name;
                value     = v;
                immutable = false;
              });
            };
            case (#Lock(v)) {
              m.put(u.name, {
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

  ////////////////////////////////////
  //
  // End code from Departure labs property.mo
  //
  ///////////////////////////////////

}
