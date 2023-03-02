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
  /// A collection of `PropertyUnstable`.
  public type PropertiesUnstable = [PropertyUnstable];

  /// Specifies a single unstable property.
  public type PropertyUnstable = {name : Text; value : CandyValueUnstable; immutable : Bool};

  /// Specifies the unstable properties that should be updated to a certain value.
  public type UpdateRequestUnstable = {
    id     : Text;
    update : [UpdateUnstable];
  };

  /// Update information for a single property. 
  public type UpdateUnstable = {
    name : Text;
    mode : UpdateModeUnstable;
  };

  /// Mode for the update operation.
  public type UpdateModeUnstable = {
    #Set    : CandyValueUnstable;
    #Lock    : CandyValueUnstable;
    #Next   : [UpdateUnstable];
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

  // The Stable CandyValue.
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

  // The Unstable CandyValue.
  public type CandyValueUnstable = {
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
    #Class : [PropertyUnstable];
    #Principal : Principal;
    #Floats : StableBuffer.StableBuffer<Float>;
    #Nats: StableBuffer.StableBuffer<Nat>; 
    #Array : StableBuffer.StableBuffer<CandyValueUnstable>;
    #Option : ?CandyValueUnstable;
    #Bytes : StableBuffer.StableBuffer<Nat8>; 
    #Map : Map.Map<CandyValueUnstable, CandyValueUnstable>;
    #Set : Set.Set<CandyValueUnstable>;
  };

  // A `DataChunk` should be no larger than 2MB so that it can be shipped to other canisters.
  public type DataChunk = CandyValueUnstable;
  public type DataZone = StableBuffer.StableBuffer<DataChunk>;
  public type Workspace = StableBuffer.StableBuffer<DataZone>;

  public type AddressedChunk = (Nat, Nat, CandyValue);
  public type AddressedChunkArray = [AddressedChunk];
  public type AddressedChunkBuffer = StableBuffer.StableBuffer<AddressedChunk>;

  /// Convert a `CandyValueUnstable` to `CandyValue`.
  ///
  /// ```motoko include=import
  /// let unstable: CandyValueUnstable = #Principal(Principal.fromText("abc"));
  /// let stableValue = stabalizeValue(unstable);
  /// ```
  public func stabalizeValue(item : CandyValueUnstable) : CandyValue{
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
              stabalizeProperty(val[idx]);
          }));
      };
      case(#Principal(val)){ #Principal(val)};
      case(#Array(val)){ #Array(stabalizeValueArray(StableBuffer.toArray(val)))};
      case(#Option(val)){
        switch(val){
          case(null){ #Option(null)};
          case(?val){#Option(?stabalizeValue(val))};
        };
      };
      case(#Bytes(val)){ #Bytes(StableBuffer.toArray<Nat8>(val))};
      case(#Floats(val)){#Floats(StableBuffer.toArray(val))};
      case(#Nats(val)){#Nats(StableBuffer.toArray(val))};
      case(#Map(val)){
        let entries = Map.entries<CandyValueUnstable, CandyValueUnstable>(val);
        let stableEntries = Iter.map<(CandyValueUnstable, CandyValueUnstable), (CandyValue, CandyValue)>(
          entries,
          func (x : (CandyValueUnstable, CandyValueUnstable)){
            (stabalizeValue(x.0), stabalizeValue(x.1))
          });
      
        #Map(Iter.toArray<(CandyValue,CandyValue)>(stableEntries));
      };
      case(#Set(val)){
        let entries = Set.keys<CandyValueUnstable>(val);
        let stableEntries = Iter.map<(CandyValueUnstable), (CandyValue)>(
          entries,
          func (x : (CandyValueUnstable)){
            (stabalizeValue(x))
          });
        #Set(Iter.toArray<(CandyValue)>(stableEntries));
      };
    }
  };

  /// Convert a `CandyValue` to `CandyValueUnstable`.
  ///
  /// ```motoko include=import
  /// let stable: CandyValue = #Principal(Principal.fromText("abc"));
  /// let unstableValue = destabalizeValue(unstable);
  /// ```
  public func destabalizeValue(item : CandyValue) : CandyValueUnstable{
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
            Array.tabulate<PropertyUnstable>(val.size(), func(idx){
                destabalizeProperty(val[idx]);
            }));
        };
        case(#Principal(val)){#Principal(val)};
        case(#Array(val)){#Array(toBuffer<CandyValueUnstable>(destabalizeValueArray(val)))};
        case(#Option(val)){
          switch(val){
            case(null){ #Option(null)};
            case(?val){#Option(?destabalizeValue(val))};
          };
        };
        case(#Bytes(val)){#Bytes(toBuffer<Nat8>(val))};
        case(#Floats(val)){#Floats(toBuffer<Float>(val))};
        case(#Nats(val)){#Nats(toBuffer<Nat>(val))};
        case(#Map(val)){
          //let entries = Map.entries<CandyValue, CandyValue>(val);
          let unstableEntries = Iter.map<(CandyValue, CandyValue), (CandyValueUnstable, CandyValueUnstable)>(
            val.vals(),
            func (x : (CandyValue, CandyValue)){
              (destabalizeValue(x.0), destabalizeValue(x.1))
            });
        
          #Map(Map.fromIter<CandyValueUnstable, CandyValueUnstable>(unstableEntries, candyValueUnstableMapHashTool));
        };
        case(#Set(val)){
          //let entries = Set.keys<CandyValueUnstable>(val);
          let unstableEntries = Iter.map<(CandyValue), (CandyValueUnstable)>(
            val.vals(),
            func (x : (CandyValue)){
              (destabalizeValue(x))
            });
          #Set(Set.fromIter<(CandyValueUnstable)>(unstableEntries, candyValueUnstableMapHashTool));
        };
      }
  };

  /// Convert a `PropertyUnstable` to `Property`.
  ///
  /// ```motoko include=import
  /// let unstable: PropertyUnstable = {
  ///    name = "name";
  ///    value = #Principal(Principal.fromText("abc"));
  ///    immutable = false;
  ///  };
  /// let stableProperty = stabalizeProperty(unstable);
  /// ```
  public func stabalizeProperty(item : PropertyUnstable) : Property{
    return {
      name = item.name;
      value = stabalizeValue(item.value);
      immutable = item.immutable;
    }
  };

  /// Convert a `Property` to `PropertyUnstable`.
  ///
  /// ```motoko include=import
  /// let stableProperty: Property = {
  ///    name = "name";
  ///    value = #Principal(Principal.fromText("abc"));
  ///    immutable = true;
  ///  };
  /// let unstableProperty = destabalizeProperty(stableProperty);
  /// ```
  public func destabalizeProperty(item : Property) : PropertyUnstable{
    return {
      name = item.name;
      value = destabalizeValue(item.value);
      immutable = item.immutable;
    }
  };

  /// Convert a `[CandyValueUnstable]` to `[CandyValue]`.
  ///
  /// ```motoko include=import
  ///  let array: [CandyValueUnstable] = [#Principal(Principal.fromText("abc")), #Int(1)];
  ///  let arrayStable = stabalizeValueArray(array);
  /// ```
  public func stabalizeValueArray(items : [CandyValueUnstable]) : [CandyValue]{

    let finalItems = Buffer.Buffer<CandyValue>(items.size());
    for(thisItem in items.vals()){
      finalItems.add(stabalizeValue(thisItem));
    };
    
    return finalItems.toArray();
  };

  /// Convert a `[CandyValue]` to `[CandyValueUnstable]`.
  ///
  /// ```motoko include=import
  ///  let arrayStable: [CandyValue] = [#Principal(Principal.fromText("abc")), #Int(1)];
  ///  let array = destabalizeValueArray(arrayStable);
  /// ```
  public func destabalizeValueArray(items : [CandyValue]) : [CandyValueUnstable]{
    
    let finalItems = Buffer.Buffer<CandyValueUnstable>(items.size());
    for(thisItem in items.vals()){
      finalItems.add(destabalizeValue(thisItem));
    };
    
    return finalItems.toArray();
  };

  /// Convert a `DataZone` to `[CandyValue]`.
  ///
  /// ```motoko include=import
  /// let array = Array.init<Nat>(4, 2);
  /// ```
  public func stabalizeValueBuffer(items : DataZone) : [CandyValue]{
      
    let finalItems = Buffer.Buffer<CandyValue>(StableBuffer.size(items));
    for(thisItem in StableBuffer.vals(items)){
      finalItems.add(stabalizeValue(thisItem));
    };
    
    return finalItems.toArray();
  };

  /// Create a `Buffer` from [T] where T can be of any type.
  ///
  /// ```motoko include=import
  /// let array = Array.init<Nat>(4, 2);
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
  /// ```motoko include=import
  /// let array = Array.init<Nat>(4, 2);
  /// ```
  public func hash(x :CandyValue) : Nat {
    Nat32.toNat(Blob.hash(to_candid(x)));
  };

  /// Checks the two `CandyValue` params for equality.
  ///
  /// ```motoko include=import
  /// let array = Array.init<Nat>(4, 2);
  /// ```
  public func eq(x :CandyValue, y: CandyValue) : Bool {
    Blob.equal(to_candid(x), to_candid(y));
  };

  /// Get the hash of the `CandyValueUnstable`.
  ///
  /// ```motoko include=import
  /// let array = Array.init<Nat>(4, 2);
  /// ```
  public func hashUnstable(x :CandyValueUnstable) : Nat {
    Nat32.toNat(Blob.hash(to_candid(stabalizeValue(x))));
  };

  /// Checks the two `CandyValue` params for equality.
  ///
  /// ```motoko include=import
  /// let array = Array.init<Nat>(4, 2);
  /// ```
  public func eqUnstable(x :CandyValueUnstable, y: CandyValueUnstable) : Bool {
    Blob.equal(to_candid(stabalizeValue(x)), to_candid(stabalizeValue(y)));
  };

  public let candyValuyMapHashTool = (hash, eq);
  public let candyValueUnstableMapHashTool = (hashUnstable, eqUnstable);

}