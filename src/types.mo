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
import StableBuffer "mo:stablebuffer_1_3_0/StableBuffer";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Map "mo:map9/Map";
import Set "mo:map9/Set";
import Text "mo:base/Text";
import Blob "mo:base/Blob";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Nat16 "mo:base/Nat16";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Principal "mo:base/Principal";
import Int "mo:base/Int";
import Int8 "mo:base/Int8";
import Int16 "mo:base/Int16";
import Int32 "mo:base/Int32";
import Int64 "mo:base/Int64";
import Float "mo:base/Float";


module {
  /// A collection of `Property`.
  public type Properties = Map.Map<Text, Property>;

  /// Specifies a single unstable property.
  public type Property = {name : Text; value : Candy; immutable : Bool};

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
    #Set    : CandyShared;
    #Lock    : CandyShared;
    #Next   : [UpdateShared];
  };

  ////////////////////////////////////
  //
  // The the following stable types were copied from departurelabs' property.mo.  They work as a plug and play
  // here with CandyShared.
  //
  // https://github.com/DepartureLabsIC/non-fungible-token/blob/main/src/property.mo
  //
  // The following section is issued under the MIT License Copyright (c) 2021 Departure Labs:
  ///////////////////////////////////

  /// Specifies a single property.
  public type PropertyShared = {name : Text; value : CandyShared; immutable : Bool};

  /// A collection of `PropertyShared`.
  public type PropertiesShared = [PropertyShared];

  /// Specifies an error which occurred during an operation on a `PropertyShared`.
  public type PropertySharedError = {
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
    #Set    : Candy;
    #Lock    : Candy;
    #Next   : [Update];
  };

  ///////////////////////////////////
  //
  // End departurelabs' property.mo types
  //
  // Code below resumes the Copyright ARAMAKME
  //
  ///////////////////////////////////

  /// The Stable CandyShared.
  public type CandyShared = {
    #Int : Int;
    #Int8: Int8;
    #Int16: Int16;
    #Int32: Int32;
    #Int64: Int64;
    #Ints: [Int];
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
    #Option : ?CandyShared;
    #Array :  [CandyShared];
    #Nats: [Nat];
    #Floats: [Float]; 
    #Bytes : [Nat8];
    #ValueMap : [(CandyShared, CandyShared)];
    #Map : [(Text, CandyShared)];
    #Set : [CandyShared];
  };

  public type ValueShared = {
    #Int : Int;
    #Nat : Nat;
    #Text : Text;
    #Blob : Blob;
    #Array :  [ValueShared];
    #Map : [(Text, ValueShared)];
  };

  /// The Shared CandyShared.
  public type Candy = {
    #Int :  Int;
    #Int8: Int8;
    #Int16: Int16;
    #Int32: Int32;
    #Int64: Int64;
    #Ints: StableBuffer.StableBuffer<Int>;
    #Nat : Nat;
    #Nat8 : Nat8;
    #Nat16 : Nat16;
    #Nat32 : Nat32;
    #Nat64 : Nat64;
    #Float : Float;
    #Text : Text;
    #Bool : Bool;
    #Blob : Blob;
    #Class : Map.Map<Text, Property>;
    #Principal : Principal;
    #Floats : StableBuffer.StableBuffer<Float>;
    #Nats: StableBuffer.StableBuffer<Nat>; 
    #Array : StableBuffer.StableBuffer<Candy>;
    #Option : ?Candy;
    #Bytes : StableBuffer.StableBuffer<Nat8>; 
    #ValueMap : Map.Map<Candy, Candy>;
    #Map : Map.Map<Text, Candy>;
    #Set : Set.Set<Candy>;
  };

  /// Note: A `DataChunk` should be no larger than 2MB so that it can be shipped to other canisters.
  public type DataChunk = Candy;
  public type DataZone = StableBuffer.StableBuffer<DataChunk>;

  /// Workspaces are valueble when using orthogonal persistance to keep track of data in a format 
  /// that is easily transmitable across the wire given IC restrictions
  public type Workspace = StableBuffer.StableBuffer<DataZone>;

  public type AddressedChunk = (Nat, Nat, CandyShared);
  public type AddressedChunkArray = [AddressedChunk];
  public type AddressedChunkBuffer = StableBuffer.StableBuffer<AddressedChunk>;

  /// Convert a `Candy` to `CandyShared`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let unstable: Candy = #Principal(Principal.fromText("abc"));
  /// let shareCandy = Types.shareCandy(unstable);
  /// ```
  public func shareCandy(item : Candy) : CandyShared{
    switch(item){
      case(#Int(val)){ #Int(val)};
      case(#Int8(val)){ #Int8(val)};
      case(#Int16(val)){ #Int16(val)};
      case(#Int32(val)){ #Int32(val)};
      case(#Int64(val)){ #Int64(val)};
      case(#Ints(val)){ #Ints(StableBuffer.toArray(val))};
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
          Iter.toArray<PropertyShared>(Iter.map<Property, PropertyShared>(Map.vals<Text, Property>(val), func(x : Property){shareProperty(x)}))
        );
      };
      case(#Principal(val)){ #Principal(val)};
      case(#Array(val)){ #Array(shareCandyArray(StableBuffer.toArray(val)))};
      case(#Option(val)){
        switch(val){
          case(null){ #Option(null)};
          case(?val){#Option(?shareCandy(val))};
        };
      };
      case(#Bytes(val)){ #Bytes(StableBuffer.toArray<Nat8>(val))};
      case(#Floats(val)){#Floats(StableBuffer.toArray(val))};
      case(#Nats(val)){#Nats(StableBuffer.toArray(val))};
      case(#ValueMap(val)){
        let entries = Map.entries<Candy, Candy>(val);
        let stableEntries = Iter.map<(Candy, Candy), (CandyShared, CandyShared)>(
          entries,
          func (x : (Candy, Candy)){
            (shareCandy(x.0), shareCandy(x.1))
          });
      
        #ValueMap(Iter.toArray<(CandyShared,CandyShared)>(stableEntries));
      };
      case(#Map(val)){
        let entries = Map.entries<Text, Candy>(val);
        let stableEntries = Iter.map<(Text, Candy), (Text, CandyShared)>(
          entries,
          func (x : (Text, Candy)){
            (x.0, shareCandy(x.1))
          });
      
        #Map(Iter.toArray<(Text,CandyShared)>(stableEntries));
      };
      case(#Set(val)){
        let entries = Set.keys<Candy>(val);
        let stableEntries = Iter.map<(Candy), (CandyShared)>(
          entries,
          func (x : (Candy)){
            (shareCandy(x))
          });
        #Set(Iter.toArray<(CandyShared)>(stableEntries));
      };
    }
  };

  /// Convert a `CandyShared` to `Candy`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let stable: CandyShared = #Principal(Principal.fromText("abc"));
  /// let unsharedValue = Types.unshare(unstable);
  /// ```
  public func unshare(item : CandyShared) : Candy{
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
            Map.fromIter<Text, Property>(Iter.map<PropertyShared, (Text, Property)>(val.vals(), 
              func(x : PropertyShared) : (Text, Property){
                  (x.name, {name = x.name; value = unshare(x.value); immutable = x.immutable})
            }), Map.thash)
          );
        };
        case(#Principal(val)){#Principal(val)};
        case(#Array(val)){#Array(toBuffer<Candy>(unshareArray(val)))};
        case(#Option(val)){
          switch(val){
            case(null){ #Option(null)};
            case(?val){#Option(?unshare(val))};
          };
        };
        case(#Bytes(val)){#Bytes(toBuffer<Nat8>(val))};
        case(#Floats(val)){#Floats(toBuffer<Float>(val))};
        case(#Nats(val)){#Nats(toBuffer<Nat>(val))};
        case(#Ints(val)){#Ints(toBuffer<Int>(val))};
        case(#ValueMap(val)){
          //let entries = Map.entries<CandyShared, CandyShared>(val);
          let unstableEntries = Iter.map<(CandyShared, CandyShared), (Candy, Candy)>(
            val.vals(),
            func (x : (CandyShared, CandyShared)){
              (unshare(x.0), unshare(x.1))
            });
        
          #ValueMap(Map.fromIter<Candy, Candy>(unstableEntries, candyMapHashTool));
        };
        case(#Map(val)){
          //let entries = Map.entries<CandyShared, CandyShared>(val);
          let unstableEntries = Iter.map<(Text, CandyShared), (Text, Candy)>(
            val.vals(),
            func (x : (Text, CandyShared)){
              (x.0, unshare(x.1))
            });
        
          #Map(Map.fromIter<Text, Candy>(unstableEntries, Map.thash));
        };
        case(#Set(val)){
          //let entries = Set.keys<Candy>(val);
          let unstableEntries = Iter.map<(CandyShared), (Candy)>(
            val.vals(),
            func (x : (CandyShared)){
              (unshare(x))
            });
          #Set(Set.fromIter<(Candy)>(unstableEntries, candyMapHashTool));
        };
      }
  };

  /// Convert a `Property` to `PropertyShared`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let unstable: Property = {
  ///    name = "name";
  ///    value = #Principal(Principal.fromText("abc"));
  ///    immutable = false;
  ///  };
  /// let stablePropertyShared = Types.shareProperty(unstable);
  /// ```
  public func shareProperty(item : Property) : PropertyShared{
    return {
      name = item.name;
      value = shareCandy(item.value);
      immutable = item.immutable;
    }
  };

  /// Convert a `PropertyShared` to `Property`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let stablePropertyShared: PropertyShared = {
  ///    name = "name";
  ///    value = #Principal(Principal.fromText("abc"));
  ///    immutable = true;
  ///  };
  /// let unstablePropertyShared = Types.unshareProperty(stablePropertyShared);
  /// ```
  public func unshareProperty(item : PropertyShared) : Property {
    return {
      name = item.name;
      value = unshare(item.value);
      immutable = item.immutable;
    }
  };

  /// Convert a `[Candy]` to `[CandyShared]`.
  ///
  /// Example:
  /// ```motoko include=import
  ///  let array: [Candy] = [#Principal(Principal.fromText("abc")), #Int(1)];
  ///  let arrayStable = Types.shareCandyArray(array);
  /// ```
  public func shareCandyArray(items : [Candy]) : [CandyShared]{
    let finalItems = Buffer.Buffer<CandyShared>(items.size());
    for(thisItem in items.vals()){
      finalItems.add(shareCandy(thisItem));
    };
    return Buffer.toArray(finalItems);
  };

  /// Convert a `[CandyShared]` to `[Candy]`.
  ///
  /// Example:
  /// ```motoko include=import
  ///  let arrayStable: [CandyShared] = [#Principal(Principal.fromText("abc")), #Int(1)];
  ///  let array = Types.unshareArray(arrayStable);
  /// ```
  public func unshareArray(items : [CandyShared]) : [Candy]{
    
    let finalItems = Buffer.Buffer<Candy>(items.size());
    for(thisItem in items.vals()){
      finalItems.add(unshare(thisItem));
    };
    
    return Buffer.toArray(finalItems);
  };

  /// Convert a `DataZone` to `[CandyShared]`.
  ///
  /// Example:
  /// ```motoko include=import
  ///  let dataZone = Types.toBuffer<DataChunk>([#Int32(5), #Int(1)]);
  ///  let sharedValues = Types.shareCandyBuffer(dataZone);
  /// ```
  public func shareCandyBuffer(items : DataZone) : [CandyShared]{

    let finalItems = Buffer.Buffer<CandyShared>(StableBuffer.size(items));
    for(thisItem in StableBuffer.vals(items)){
      finalItems.add(shareCandy(thisItem));
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

  /// Get the hash of the `CandyShared`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let x: CandyShared = #Principal(Principal.fromText("abc"));
  /// let h = Types.hash(x);
  /// ```
  public func hash(x :Candy) : Nat32 {
    
    let thisHash = switch(x){
        case(#Int(val)) Map.ihash.0(val);
        case(#Int8(val)) Map.i8hash.0(val);
        case(#Int16(val)) Map.i16hash.0(val);
        case(#Int32(val)) Map.i32hash.0(val);
        case(#Int64(val)) Map.i64hash.0(val);
        case(#Nat(val)) Map.nhash.0(val);
        case(#Nat8(val)) Map.n8hash.0(val);
        case(#Nat16(val)) Map.n16hash.0(val);
        case(#Nat32(val)) Map.n32hash.0(val);
        case(#Nat64(val)) Map.n64hash.0(val);
        case(#Float(val)) Map.thash.0(Float.format(#exact, Float.nearest(val * 100000000) / 100000000));
        case(#Text(val)) Map.thash.0(val);
        case(#Bool(val)) Map.lhash.0(val);
        case(#Blob(val)) Map.bhash.0(val);
        case(#Class(val)){
          var accumulator = 0 : Nat32;
          for(thisItem in Map.vals(val)){
            accumulator +%= Map.thash.0(thisItem.name);
            accumulator +%= hash(thisItem.value);
            accumulator +%= Map.lhash.0(thisItem.immutable);
          };
          accumulator;
        };
        case(#Principal(val)) Map.phash.0(val);
        case(#Array(val)){ 
          var accumulator = 0 : Nat32;
          for(thisItem in StableBuffer.vals(val)){
            let ahash = hash(thisItem);
            accumulator := (accumulator *% 3) +% ahash;
          };
          accumulator;
        };
        
        case(#Option(val)){
          var result : Nat32 = 0;
          switch(val){
            case(null){ 
              result  -%= 1 : Nat32;
              return result;
            };
            case(?val){hash(val)};
          };
         
        };
        case(#Bytes(val)) Map.bhash.0(Blob.fromArray(StableBuffer.toArray<Nat8>(val)));
        case(#Floats(val)){ //arrays must be in the same order so we add index
          var accumulator = 0 : Nat32;
          for(thisItem in StableBuffer.vals(val)){
            let ahash = hash(#Float(thisItem));
            accumulator := (accumulator *% 3) +% ahash;
          };
          accumulator;
        };
        case(#Nats(val)){
          var accumulator = 0 : Nat32;
          for(thisItem in StableBuffer.vals(val)){
            let ahash = hash(#Nat(thisItem));
            accumulator := (accumulator *% 3) +% ahash;
          };
          accumulator;
        };
        case(#Ints(val)){
          var accumulator = 0 : Nat32;
          for(thisItem in StableBuffer.vals(val)){
            let ahash = hash(#Int(thisItem));
            accumulator := (accumulator *% 3) +% ahash;
          };
          accumulator;
        };
        case(#ValueMap(val)){
          //this map ignores insertion order
          var accumulator = 0 : Nat32;
          for(thisItem in Map.entries(val)){
            accumulator +%= hash(thisItem.0);
            accumulator +%= hash(thisItem.1);
          };
          accumulator;
        };
        case(#Map(val)){
          //this map ignores insertion order
          var accumulator = 0 : Nat32;
          for(thisItem in Map.entries(val)){
            accumulator +%=  Map.thash.0(thisItem.0);
            accumulator +%= hash(thisItem.1);
          };
          accumulator;
        };
        case(#Set(val)){
          //this set ignores insertion order

          var accumulator = 0 : Nat32;
          for(thisItem in Set.keys(val)){
            accumulator +%= hash(thisItem);
          };
          accumulator;
        };
      };
  };

  private func nat32ToBytes(x : Nat32) : [Nat8] {
    
    [ Nat8.fromNat(Nat32.toNat((x >> 24) & (255))),
    Nat8.fromNat(Nat32.toNat((x >> 16) & (255))),
    Nat8.fromNat(Nat32.toNat((x >> 8) & (255))),
    Nat8.fromNat(Nat32.toNat((x & 255))) ];
  };


  
  


  /// Checks the two `CandyShared` params for equality.
  ///
  /// Example:
  /// ```motoko include=import
  /// let x: CandyShared = #Int(1);
  /// let y: CandyShared = #Int(2);
  /// let z: CandyShared = #Int(1);
  /// let x_y = Types.eq(x, y); // false
  /// let x_z = Types.eq(x, z); // true
  /// ```
  public func eq(x :Candy, y: Candy) : Bool {

    let thisCandyMapTool = (hash, eq);

    switch(x, y){
      case(#Int(x),#Int(y)) Int.equal(x,y);
      case(#Int8(x),#Int8(y)) Int8.equal(x,y);
      case(#Int16(x),#Int16(y)) Int16.equal(x,y);
      case(#Int32(x),#Int32(y)) Int32.equal(x,y);
      case(#Int64(x),#Int64(y)) Int64.equal(x,y);
      case(#Nat(x),#Nat(y)) Nat.equal(x,y);
      case(#Nat8(x),#Nat8(y))Nat8.equal(x,y);
      case(#Nat16(x),#Nat16(y)) Nat16.equal(x,y);
      case(#Nat32(x),#Nat32(y)) Nat32.equal(x,y);
      case(#Nat64(x), #Nat64(y)) Nat64.equal(x,y);
      case(#Float(x),#Float(y)){
        (Float.nearest(x * 100000000) / 100000000) == (Float.nearest(y * 100000000) / 100000000)
      };
      case(#Text(x),#Text(y)) Text.equal(x,y);
      case(#Bool(x),#Bool(y)) x == y;
      case(#Blob(x),#Blob(y)) Blob.equal(x,y);
      case(#Class(x),#Class(y)){
        if(Map.size(x) != Map.size(y)){
          return false;
        } else{
          for(thisItem in Map.vals(x)){
            switch(Map.get(y, Map.thash, thisItem.name)){
              case(null){
                return false;
              };
              case(?val){
                if(val.immutable != thisItem.immutable or eq(val.value, thisItem.value) == false){
                  return false;
                }
              }
            };
          };
          return true;
        }
      };
      case(#Principal(x), #Principal(y)) Principal.equal(x,y);
      case(#Array(x), #Array(y)){ 
        
        if(StableBuffer.size(x) != StableBuffer.size(y)) return false;

        var tracker = 0;
        for(thisItem in StableBuffer.vals(x)){
          if(eq(StableBuffer.get(y, tracker), thisItem) == false) return false;
          tracker += 1;
        };
        return true;
      };
      
      case(#Option(x), #Option(y)){
        switch(x,y){
          case(null, null){
            return true;
          };
          case(?x, ?y){
            return eq(x,y);
          };
          case(_,_){
            return false;
          };
        }
      };
      case(#Bytes(x), #Bytes(y)) {
        if(StableBuffer.size(x) != StableBuffer.size(y)){
          return false;
        };
        let itery = StableBuffer.vals(y);

        for (thisx in StableBuffer.vals(x)) {
          let ?thisy = itery.next() else return false;
          if(thisx != thisy) return false;
        };

        return true;
      };
      case(#Floats(x), #Floats(y)){ //arrays must be in the same order so we add index
        
        if(StableBuffer.size(x) != StableBuffer.size(y)) return false;

        var tracker = 0;
        for(thisItem in StableBuffer.vals(x)){
          if((Float.nearest(thisItem * 100000000) / 100000000) != (Float.nearest(StableBuffer.get(y, tracker) * 100000000) / 100000000)) return false;
          tracker += 1;
        };
        return true;
      };
      case(#Nats(x), #Nats(y)){
        if(StableBuffer.size(x) != StableBuffer.size(y)) return false;

        var tracker = 0;
        for(thisItem in StableBuffer.vals(x)){
          if(Nat.equal(StableBuffer.get(y, tracker), thisItem) == false) return false;
          tracker +=1;
        };
        return true;
      };
      case(#Ints(x), #Ints(y)){
        if(StableBuffer.size(x) != StableBuffer.size(y)) return false;

        var tracker = 0;
        for(thisItem in StableBuffer.vals(x)){
          if(Int.equal(StableBuffer.get(y, tracker), thisItem) == false) return false;
          tracker +=1;
        };
        return true;
      };
      case(#ValueMap(x), #ValueMap(y)){
        //this map ignores insertion order
       
        if(Map.size(x) != Map.size(y)) return false;

        for(thisItem in Map.entries(x)){

          switch(Map.get(y, thisCandyMapTool, thisItem.0)){
        
              case(null){
                return false;
              };
              case(?val){
                if(eq(val, thisItem.1) == false){
                  return false;
                };
              }
            };
        };
        return true;
      };
      case(#Map(x), #Map(y)){
        //this map ignores insertion order
       
        if(Map.size(x) != Map.size(y)) return false;

        for(thisItem in Map.entries(x)){
          switch(Map.get(y, Map.thash, thisItem.0)){
        
              case(null){
                return false;
              };
              case(?val){
                if(eq(val, thisItem.1) == false){
                  return false;
                };
              }
            };
        };
        return true;
      };
      case(#Set(x), #Set(y)){
       //this set takes insertion order into account
       if(Set.size(x) != Set.size(y)) return false;

         for(thisItem in Set.keys(x)){

           if(Set.has(y, thisCandyMapTool, thisItem) == false) return false;
        };

        return true;
      };
      case(_,_){
        false;
      };
    };
  };

  public let candyMapHashTool = (hash, eq);

  /// Get the hash of the `Candy`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let x: Candy = #Principal(Principal.fromText("abc"));
  /// let h = Types.hashShared(x);  
  /// ```
  public func hashShared(x :CandyShared) : Nat32 {

    let thisHash = switch(x){
        case(#Int(val)) Map.ihash.0(val);
        case(#Int8(val)) Map.i8hash.0(val);
        case(#Int16(val)) Map.i16hash.0(val);
        case(#Int32(val)) Map.i32hash.0(val);
        case(#Int64(val)) Map.i64hash.0(val);
        case(#Nat(val)) Map.nhash.0(val);
        case(#Nat8(val)) Map.n8hash.0(val);
        case(#Nat16(val)) Map.n16hash.0(val);
        case(#Nat32(val)) Map.n32hash.0(val);
        case(#Nat64(val)) Map.n64hash.0(val);
        case(#Float(val)) Map.thash.0(Float.format(#exact, Float.nearest(val * 100000000)/ 100000000));
        case(#Text(val)) Map.thash.0(val);
        case(#Bool(val)) Map.lhash.0(val);
        case(#Blob(val)) Map.bhash.0(val);
        case(#Class(val)){
          var accumulator = 0 : Nat32;
          for(thisItem in val.vals()){
            accumulator +%= Map.thash.0(thisItem.name);
            accumulator +%= hashShared(thisItem.value);
            accumulator +%= Map.lhash.0(thisItem.immutable);
          };
          accumulator;
        };
        case(#Principal(val)) Map.phash.0(val);
        
        case(#Array(val)){ //arrays must be in the same order so we add index
          
          var accumulator = 0 : Nat32;
          for(thisItem in val.vals()){
            let ahash = hashShared(thisItem);
            accumulator := (accumulator *% 3) +% ahash;
          };
          accumulator;
        };
        case(#Option(val)){
          var result : Nat32 = 0;
          switch(val){
            case(null){ 
              result  -%= 1 : Nat32;
              return result;
            };
            case(?val){hashShared(val)};
          };
         
        };
        case(#Bytes(val)) Map.bhash.0(Blob.fromArray(val));
        case(#Floats(val)){ //arrays must be in the same order so we add index
          
          var accumulator = 0 : Nat32;
          for(thisItem in val.vals()){
            let ahash = hashShared(#Float(thisItem));
            accumulator := (accumulator *% 3) +% ahash;
          };
          accumulator;
        };
        case(#Nats(val)){
          var accumulator = 0 : Nat32;
          for(thisItem in val.vals()){
            let ahash =hashShared(#Nat(thisItem));
            accumulator := (accumulator *% 3) +% ahash;
          };
          accumulator;
        };
        case(#Ints(val)){
          var accumulator = 0 : Nat32;
          for(thisItem in val.vals()){
            let ahash =hashShared(#Int(thisItem));
            accumulator := (accumulator *% 3) +% ahash;
          };
          accumulator;
        };
        case(#ValueMap(val)){
          //this map takes insertion order into account
          var accumulator = 0 : Nat32;
          for(thisItem in val.vals()){
            accumulator +%= hashShared(thisItem.0);
            accumulator +%= hashShared(thisItem.1);
          };
          accumulator;
        };
        case(#Map(val)){
          //this map takes insertion order into account
          var accumulator = 0 : Nat32;
          for(thisItem in val.vals()){
            accumulator +%= Map.thash.0(thisItem.0);
            accumulator +%= hashShared(thisItem.1);
          };
          accumulator;
        };
        case(#Set(val)){
          //this set takes insertion order into account
         var accumulator = 0 : Nat32;
          for(thisItem in val.vals()){
            accumulator +%= hashShared(thisItem);
          };
          accumulator;
        };
      };
  };

  /// Checks the two `CandyShared` params for equality.
  ///
  /// Example:
  /// ```motoko include=import
  /// let x: Candy = #Int(1);
  /// let y: Candy = #Int(2);
  /// let z: Candy = #Int(1);
  /// let x_y = Types.eq(x, y); // false
  /// let x_z = Types.eq(x, z); // true
  /// ```
  public func eqShared(x :CandyShared, y: CandyShared) : Bool {
    switch(x, y){
      case(#Int(x),#Int(y)) Int.equal(x,y);
      case(#Int8(x),#Int8(y)) Int8.equal(x,y);
      case(#Int16(x),#Int16(y)) Int16.equal(x,y);
      case(#Int32(x),#Int32(y)) Int32.equal(x,y);
      case(#Int64(x),#Int64(y)) Int64.equal(x,y);
      case(#Nat(x),#Nat(y)) Nat.equal(x,y);
      case(#Nat8(x),#Nat8(y))Nat8.equal(x,y);
      case(#Nat16(x),#Nat16(y)) Nat16.equal(x,y);
      case(#Nat32(x),#Nat32(y)) Nat32.equal(x,y);
      case(#Nat64(x), #Nat64(y)) Nat64.equal(x,y);
      case(#Float(x),#Float(y)){
        Float.nearest(x * 100000000)/ 100000000 == Float.nearest(y * 100000000)/ 100000000
      };
      case(#Text(x),#Text(y)) Text.equal(x,y);
      case(#Bool(x),#Bool(y)) x == y;
      case(#Blob(x),#Blob(y)) Blob.equal(x,y);
      case(#Class(x),#Class(y)){
        if(x.size() != y.size()){
          return false;
        } else{
          var tracker = 0;
          for(thisItem in x.vals()){
            if(y[tracker].name != thisItem.name or eqShared(y[tracker].value, thisItem.value) == false or y[tracker].immutable != thisItem.immutable) return false;
            tracker += 1;
          };
          return true;
        }
      };
      case(#Principal(x), #Principal(y)) Principal.equal(x,y);
      case(#Array(x), #Array(y)){ 
        
        if(x.size() != y.size()) return false;

        var tracker = 0;
        for(thisItem in x.vals()){
          if(eqShared(y[tracker], thisItem) == false) return false;
          tracker += 1;
        };
        return true;
      };
      
      case(#Option(x), #Option(y)){
        switch(x,y){
          case(null, null){
            return true;
          };
          case(?x, ?y){
            return eqShared(x,y);
          };
          case(_,_){
            return false;
          };
        }
      };
      case(#Bytes(x), #Bytes(y)) {
        if(x.size() != y.size()){
          return false;
        };
        let itery = y.vals();

        for (thisx in x.vals()) {
          let ?thisy = itery.next() else return false;
          if(thisx != thisy) return false;
        };

        return true;
      };
      case(#Floats(x), #Floats(y)){ //arrays must be in the same order so we add index
        
        if(x.size() != y.size()) return false;

        var tracker = 0;
        for(thisItem in x.vals()){
          if(Float.nearest(thisItem * 100000000)/ 100000000 != Float.nearest(y[tracker] * 100000000)/ 100000000) return false;
          tracker += 1;
        };
        return true;
      };
      case(#Nats(x), #Nats(y)){
        if(x.size() != y.size()) return false;

        var tracker = 0;
        for(thisItem in x.vals()){
          if(Nat.equal(y[tracker], thisItem) == false) return false;
          tracker += 1;
        };
        return true;
      };
      case(#Ints(x), #Ints(y)){
        if(x.size() != y.size()) return false;

        var tracker = 0;
        for(thisItem in x.vals()){
          if(Int.equal(y[tracker], thisItem) == false) return false;
          tracker += 1;
        };
        return true;
      };
      case(#ValueMap(x), #ValueMap(y)){
        //this map IGNORES insertion order 
       
        if(x.size() != y.size()) return false;

        let yit = Iter.sort<(CandyShared, CandyShared)>(y.vals(), func(x, y){Nat32.compare(hashShared(x.0), hashShared(y.0))});

        for(thisItem in Iter.sort<(CandyShared, CandyShared)>(x.vals(), func(x, y){Nat32.compare(hashShared(x.0), hashShared(y.0))})){
          switch(yit.next()){
            case(null) return false;
            case(?val){
               if(eqShared(val.0, thisItem.0) == false){
                   return false;
                };
                if(eqShared(val.1, thisItem.1) == false){
                  return false;
                };
            };
          };
        };
        return true;
      };
      case(#Map(x), #Map(y)){
        //this map IGNORES insertion order 
       
        if(x.size() != y.size()) return false;

        let yit = Iter.sort<(Text, CandyShared)>(y.vals(), func(x, y){Nat32.compare(Text.hash(x.0), Text.hash(y.0))});

        for(thisItem in Iter.sort<(Text, CandyShared)>(x.vals(), func(x, y){Nat32.compare(Text.hash(x.0), Text.hash(y.0))})){
          switch(yit.next()){
            case(null) return false;
            case(?val){
               if(Text.equal(val.0, thisItem.0) == false){
                   return false;
                };
                if(eqShared(val.1, thisItem.1) == false){
                  return false;
                };
            };
          };
        };
        return true;
      };
      case(#Set(x), #Set(y)){
       //this set takes insertion order into account
       let yit = Iter.sort<CandyShared>(y.vals(), func(x, y){Nat32.compare(hashShared(x), hashShared(y))});

        for(thisItem in Iter.sort<CandyShared>(x.vals(), func(x, y){Nat32.compare(hashShared(x), hashShared(y))})){
          switch(yit.next()){
            case(null) return false;
            case(?val){
               if(eqShared(val, thisItem) == false){
                   return false;
                };
            };
          };
        };
        return true;
      };
      case(_,_){
        false;
      };
    };
  };

  public let candySharedMapHashTool = (hashShared, eqShared);

  

}