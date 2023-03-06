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

/// Types for the candy library.
///
/// This module contains the types that denote candy values, properties 
/// and workspace.
/// It also contains a few converstion functions to serialize/deserialize
/// & stabilize/destabilize candy values.

import Buffer "mo:base/Buffer";
import StableBuffer "mo:stable_buffer/StableBuffer";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Map "mo:Map/Map";
import Set "mo:Map/Set";
import Blob "mo:base/Blob";
import Nat32 "mo:base/Nat32";
import Principal "mo:base/Principal";
import Int "mo:base/Int";


module {
  /// A collection of `PropertyShared`.
  public type PropertiesShared = [PropertyShared];

  /// Specifies a single unstable property.
  public type PropertyShared = {name : Text; value : CandyValueShared; immutable : Bool};

  /// Specifies the unstable properties that should be updated to a certain value.
  public type UpdateRequestShared = {
    id     : Text;
    update : [UpdateShared];
  };

  /// Update information for a single property. 
  public type UpdateShared = {
    name : Text;
    mode : UpdateModeShared;
  };

  /// Mode for the update operation.
  public type UpdateModeShared = {
    #Set    : CandyValueShared;
    #Lock    : CandyValueShared;
    #Next   : [UpdateShared];
  };

  ////////////////////////////////////
  //
  // The the following stable types were copied from departurelabs' property.mo.  They work as a plug and play
  // here with CandyValue.
  //
  // https://github.com/DepartureLabsIC/non-fungible-token/blob/main/src/property.mo
  //
  // The following section is issued under the MIT License Copyright (c) 2021 Departure Labs:
  ///////////////////////////////////

  /// Specifies a single property.
  public type Property = {name : Text; value : CandyValue; immutable : Bool};

  /// A collection of `Property`.
  public type Properties = [Property];

  /// Specifies an error which occurred during an operation on a `Property`.
  public type PropertyError = {
    #Unauthorized;
    #NotFound;
    #InvalidRequest;
    #AuthorizedPrincipalLimitReached : Nat;
    #Immutable;
  };

  /// Specifies the properties that should be queried.
  public type Query = {
    name : Text;    // Target property name.
    next : [Query]; // Optional sub-properties in the case of a class value.
  };

  /// Mode for the query operation.
  public type QueryMode = {
    #All;            // Returns all properties.
    #Some : [Query]; // Returns a select set of properties based on the name.
  };

  /// Specifies the properties that should be updated to a certain value.
  public type UpdateRequest = {
    id     : Text;
    update : [Update];
  };

  /// Update information for a single property. 
  public type Update = {
    name : Text;
    mode : UpdateMode;
  };

  /// Mode for the update operation.
  public type UpdateMode = {
    #Set    : CandyValue;
    #Lock    : CandyValue;
    #Next   : [Update];
  };

  ///////////////////////////////////
  //
  // End departurelabs' property.mo types
  //
  // Code below resumes the Copyright ARAMAKME
  //
  ///////////////////////////////////

  /// The Stable CandyValue.
  public type CandyValue = {
    #Int : Int;
    #Int8: Int8;
    #Int16: Int16;
    #Int32: Int32;
    #Int64: Int64;
    #Nat : Nat;
    #Nat8 : Nat8;
    #Nat16 : Nat16;
    #Nat32 : Nat32;
    #Nat64 : Nat64;
    #Float : Float;
    #Text : Text;
    #Bool : Bool;
    #Blob : Blob;
    #Class : [Property];
    #Principal : Principal;
    #Option : ?CandyValue;
    #Array :  [CandyValue];
    #Nats: [Nat];
    #Floats: [Float]; 
    #Bytes : [Nat8];
    #Map : [(CandyValue, CandyValue)];
    #Set : [CandyValue];
  };

  /// The Shared CandyValue.
  public type CandyValueShared = {
    #Int :  Int;
    #Int8: Int8;
    #Int16: Int16;
    #Int32: Int32;
    #Int64: Int64;
    #Nat : Nat;
    #Nat8 : Nat8;
    #Nat16 : Nat16;
    #Nat32 : Nat32;
    #Nat64 : Nat64;
    #Float : Float;
    #Text : Text;
    #Bool : Bool;
    #Blob : Blob;
    #Class : [PropertyShared];
    #Principal : Principal;
    #Floats : StableBuffer.StableBuffer<Float>;
    #Nats: StableBuffer.StableBuffer<Nat>; 
    #Array : StableBuffer.StableBuffer<CandyValueShared>;
    #Option : ?CandyValueShared;
    #Bytes : StableBuffer.StableBuffer<Nat8>; 
    #Map : Map.Map<CandyValueShared, CandyValueShared>;
    #Set : Set.Set<CandyValueShared>;
  };

  /// Note: A `DataChunk` should be no larger than 2MB so that it can be shipped to other canisters.
  public type DataChunk = CandyValueShared;
  public type DataZone = StableBuffer.StableBuffer<DataChunk>;

  /// Workspaces are valueble when using orthogonal persistance to keep track of data in a format 
  /// that is easily transmitable across the wire given IC restrictions
  public type Workspace = StableBuffer.StableBuffer<DataZone>;

  public type AddressedChunk = (Nat, Nat, CandyValue);
  public type AddressedChunkArray = [AddressedChunk];
  public type AddressedChunkBuffer = StableBuffer.StableBuffer<AddressedChunk>;

  /// Convert a `CandyValueShared` to `CandyValue`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let unstable: CandyValueShared = #Principal(Principal.fromText("abc"));
  /// let stableValue = Types.shareValue(unstable);
  /// ```
  public func shareValue(item : CandyValueShared) : CandyValue{
    switch(item){
      case(#Int(val)){ #Int(val)};
      case(#Int8(val)){ #Int8(val)};
      case(#Int16(val)){ #Int16(val)};
      case(#Int32(val)){ #Int32(val)};
      case(#Int64(val)){ #Int64(val)};
      case(#Nat(val)){ #Nat(val)};
      case(#Nat8(val)){ #Nat8(val)};
      case(#Nat16(val)){ #Nat16(val)};
      case(#Nat32(val)){ #Nat32(val)};
      case(#Nat64(val)){ #Nat64(val)};
      case(#Float(val)){ #Float(val)};
      case(#Text(val)){ #Text(val)};
      case(#Bool(val)){ #Bool(val)};
      case(#Blob(val)){ #Blob(val)};
      case(#Class(val)){
        #Class(
          Array.tabulate<Property>(val.size(), func(idx){
              shareProperty(val[idx]);
          }));
      };
      case(#Principal(val)){ #Principal(val)};
      case(#Array(val)){ #Array(shareValueArray(StableBuffer.toArray(val)))};
      case(#Option(val)){
        switch(val){
          case(null){ #Option(null)};
          case(?val){#Option(?shareValue(val))};
        };
      };
      case(#Bytes(val)){ #Bytes(StableBuffer.toArray<Nat8>(val))};
      case(#Floats(val)){#Floats(StableBuffer.toArray(val))};
      case(#Nats(val)){#Nats(StableBuffer.toArray(val))};
      case(#Map(val)){
        let entries = Map.entries<CandyValueShared, CandyValueShared>(val);
        let stableEntries = Iter.map<(CandyValueShared, CandyValueShared), (CandyValue, CandyValue)>(
          entries,
          func (x : (CandyValueShared, CandyValueShared)){
            (shareValue(x.0), shareValue(x.1))
          });
      
        #Map(Iter.toArray<(CandyValue,CandyValue)>(stableEntries));
      };
      case(#Set(val)){
        let entries = Set.keys<CandyValueShared>(val);
        let stableEntries = Iter.map<(CandyValueShared), (CandyValue)>(
          entries,
          func (x : (CandyValueShared)){
            (shareValue(x))
          });
        #Set(Iter.toArray<(CandyValue)>(stableEntries));
      };
    }
  };

  /// Convert a `CandyValue` to `CandyValueShared`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let stable: CandyValue = #Principal(Principal.fromText("abc"));
  /// let unstableValue = Types.unshareValue(unstable);
  /// ```
  public func unshareValue(item : CandyValue) : CandyValueShared{
      switch(item){
        case(#Int(val)){ #Int(val)};
        case(#Int8(val)){ #Int8(val)};
        case(#Int16(val)){ #Int16(val)};
        case(#Int32(val)){ #Int32(val)};
        case(#Int64(val)){ #Int64(val)};
        case(#Nat(val)){ #Nat(val)};
        case(#Nat8(val)){ #Nat8(val)};
        case(#Nat16(val)){ #Nat16(val)};
        case(#Nat32(val)){ #Nat32(val)};
        case(#Nat64(val)){ #Nat64(val)};
        case(#Float(val)){ #Float(val)};
        case(#Text(val)){ #Text(val)};
        case(#Bool(val)){ #Bool(val)};
        case(#Blob(val)){ #Blob(val)};
        case(#Class(val)){
          #Class(
            Array.tabulate<PropertyShared>(val.size(), func(idx){
                unshareProperty(val[idx]);
            }));
        };
        case(#Principal(val)){#Principal(val)};
        case(#Array(val)){#Array(toBuffer<CandyValueShared>(unshareValueArray(val)))};
        case(#Option(val)){
          switch(val){
            case(null){ #Option(null)};
            case(?val){#Option(?unshareValue(val))};
          };
        };
        case(#Bytes(val)){#Bytes(toBuffer<Nat8>(val))};
        case(#Floats(val)){#Floats(toBuffer<Float>(val))};
        case(#Nats(val)){#Nats(toBuffer<Nat>(val))};
        case(#Map(val)){
          //let entries = Map.entries<CandyValue, CandyValue>(val);
          let unstableEntries = Iter.map<(CandyValue, CandyValue), (CandyValueShared, CandyValueShared)>(
            val.vals(),
            func (x : (CandyValue, CandyValue)){
              (unshareValue(x.0), unshareValue(x.1))
            });
        
          #Map(Map.fromIter<CandyValueShared, CandyValueShared>(unstableEntries, candyValueSharedMapHashTool));
        };
        case(#Set(val)){
          //let entries = Set.keys<CandyValueShared>(val);
          let unstableEntries = Iter.map<(CandyValue), (CandyValueShared)>(
            val.vals(),
            func (x : (CandyValue)){
              (unshareValue(x))
            });
          #Set(Set.fromIter<(CandyValueShared)>(unstableEntries, candyValueSharedMapHashTool));
        };
      }
  };

  /// Convert a `PropertyShared` to `Property`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let unstable: PropertyShared = {
  ///    name = "name";
  ///    value = #Principal(Principal.fromText("abc"));
  ///    immutable = false;
  ///  };
  /// let stableProperty = Types.shareProperty(unstable);
  /// ```
  public func shareProperty(item : PropertyShared) : Property{
    return {
      name = item.name;
      value = shareValue(item.value);
      immutable = item.immutable;
    }
  };

  /// Convert a `Property` to `PropertyShared`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let stableProperty: Property = {
  ///    name = "name";
  ///    value = #Principal(Principal.fromText("abc"));
  ///    immutable = true;
  ///  };
  /// let unstableProperty = Types.unshareProperty(stableProperty);
  /// ```
  public func unshareProperty(item : Property) : PropertyShared{
    return {
      name = item.name;
      value = unshareValue(item.value);
      immutable = item.immutable;
    }
  };

  /// Convert a `[CandyValueShared]` to `[CandyValue]`.
  ///
  /// Example:
  /// ```motoko include=import
  ///  let array: [CandyValueShared] = [#Principal(Principal.fromText("abc")), #Int(1)];
  ///  let arrayStable = Types.shareValueArray(array);
  /// ```
  public func shareValueArray(items : [CandyValueShared]) : [CandyValue]{

    let finalItems = Buffer.Buffer<CandyValue>(items.size());
    for(thisItem in items.vals()){
      finalItems.add(shareValue(thisItem));
    };
    
    return Buffer.toArray(finalItems);
  };

  /// Convert a `[CandyValue]` to `[CandyValueShared]`.
  ///
  /// Example:
  /// ```motoko include=import
  ///  let arrayStable: [CandyValue] = [#Principal(Principal.fromText("abc")), #Int(1)];
  ///  let array = Types.unshareValueArray(arrayStable);
  /// ```
  public func unshareValueArray(items : [CandyValue]) : [CandyValueShared]{
    
    let finalItems = Buffer.Buffer<CandyValueShared>(items.size());
    for(thisItem in items.vals()){
      finalItems.add(unshareValue(thisItem));
    };
    
    return Buffer.toArray(finalItems);
  };

  /// Convert a `DataZone` to `[CandyValue]`.
  ///
  /// Example:
  /// ```motoko include=import
  ///  let dataZone = Types.toBuffer<DataChunk>([#Int32(5), #Int(1)]);
  ///  let sharedValues = Types.shareValueBuffer(dataZone);
  /// ```
  public func shareValueBuffer(items : DataZone) : [CandyValue]{

    let finalItems = Buffer.Buffer<CandyValue>(StableBuffer.size(items));
    for(thisItem in StableBuffer.vals(items)){
      finalItems.add(shareValue(thisItem));
    };
    
    return Buffer.toArray(finalItems);
  };

  /// Create a `Buffer` from [T] where T can be of any type.
  ///
  /// Example:
  /// ```motoko include=import
  ///  let array = [1, 2, 3];
  ///  let buf = Types.toBuffer<Nat>(array);  
  /// ```
  public func toBuffer<T>(x :[T]) : StableBuffer.StableBuffer<T>{
    let thisBuffer = StableBuffer.initPresized<T>(x.size());
    for(thisItem in x.vals()){
      StableBuffer.add(thisBuffer,thisItem);
    };
    return thisBuffer;
  };

  /// Get the hash of the `CandyValue`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let x: CandyValue = #Principal(Principal.fromText("abc"));
  /// let h = Types.hash(x);
  /// ```
  public func hash(x :CandyValue) : Nat {
    Nat32.toNat(Blob.hash(to_candid(x)));
  };

  /// Checks the two `CandyValue` params for equality.
  ///
  /// Example:
  /// ```motoko include=import
  /// let x: CandyValue = #Int(1);
  /// let y: CandyValue = #Int(2);
  /// let z: CandyValue = #Int(1);
  /// let x_y = Types.eq(x, y); // false
  /// let x_z = Types.eq(x, z); // true
  /// ```
  public func eq(x :CandyValue, y: CandyValue) : Bool {
    Blob.equal(to_candid(x), to_candid(y));
  };

  /// Get the hash of the `CandyValueShared`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let x: CandyValueShared = #Principal(Principal.fromText("abc"));
  /// let h = Types.hashShared(x);  
  /// ```
  public func hashShared(x :CandyValueShared) : Nat {
    Nat32.toNat(Blob.hash(to_candid(shareValue(x))));
  };

  /// Checks the two `CandyValue` params for equality.
  ///
  /// Example:
  /// ```motoko include=import
  /// let x: CandyValueShared = #Int(1);
  /// let y: CandyValueShared = #Int(2);
  /// let z: CandyValueShared = #Int(1);
  /// let x_y = Types.eq(x, y); // false
  /// let x_z = Types.eq(x, z); // true
  /// ```
  public func eqShared(x :CandyValueShared, y: CandyValueShared) : Bool {
    Blob.equal(to_candid(shareValue(x)), to_candid(shareValue(y)));
  };

  public let candyValuyMapHashTool = (hash, eq);
  public let candyValueSharedMapHashTool = (hashShared, eqShared);

}