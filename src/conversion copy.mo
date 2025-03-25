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

/// Conversion utilities for the candy library.
///
/// This module contains the conversion functions to convert values to & from 
/// candy values.

import Buffer "mo:base/Buffer";
import Blob "mo:base/Blob";
import Char "mo:base/Char";
import Iter "mo:base/Iter";
import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Nat16 "mo:base/Nat16";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Nat8 "mo:base/Nat8";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Int8 "mo:base/Int8";
import Int16 "mo:base/Int16";
import Int32 "mo:base/Int32";
import Int64 "mo:base/Int64";
import Bool "mo:base/Bool";
import Principal "mo:base/Principal";
import Prelude "mo:base/Prelude";
import List "mo:base/List";
import Types "types";
import Hex "mo:encoding_0_4_1/Hex";
import Properties "properties";
import StableBuffer "mo:stablebuffer_1_3_0/StableBuffer";
import Map "mo:map9/Map";
import Set "mo:map9/Set";


module {

  type CandyShared = Types.CandyShared;
  type Candy = Types.Candy;
  type ValueShared = Types.ValueShared;
  type DataZone = Types.DataZone;
  type PropertyShared = Types.PropertyShared;
  type Property = Types.Property;
  type StableBuffer<T> = StableBuffer.StableBuffer<T>;

  //todo: generic accesors

  /// Convert a `Candy` to `Nat`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int16(15);
  /// let converted_value = Conversion.candyToNat(value);
  /// ```
  /// Note: Throws if the underlying value overflows or is negative.
  public func candyToNat(val : Candy) : Nat {
    switch(val){
    case(#Nat(val)){ val};
    case(#Nat8(val)){ Nat8.toNat(val)};
    case(#Nat16(val)){ Nat16.toNat(val)};
    case(#Nat32(val)){ Nat32.toNat(val)};
    case(#Nat64(val)){ Nat64.toNat(val)};
    case(#Float(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat(#Int(Float.toInt(Float.nearest(val))))};
    case(#Int(val)){
      if(val < 0){assert false;};//will throw on negative
      
      Int.abs(val)};
    case(#Int8(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
    case(#Int16(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
    case(#Int32(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
    case(#Int64(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
    case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `Candy` to `Nat8`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToNat8(value);
  /// ```
  /// Note: Throws if the underlying value overflows or is negative.
  public func candyToNat8(val : Candy) : Nat8 {
    switch(val){
    case(#Nat8(val)){ val};
    case(#Nat(val)){ Nat8.fromNat(val)};//will throw on overflow
    case(#Nat16(val)){ Nat8.fromNat(Nat16.toNat(val))};//will throw on overflow
    case(#Nat32(val)){ Nat8.fromNat(Nat32.toNat(val))};//will throw on overflow
    case(#Nat64(val)){ Nat8.fromNat(Nat64.toNat(val))};//will throw on overflow
    case(#Float(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat8(#Int(Float.toInt(Float.nearest(val))))};
    case(#Int(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat8(#Nat(Int.abs(val)))};
    case(#Int8(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat8(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
    case(#Int16(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat8(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
    case(#Int32(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat8(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
    case(#Int64(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat8(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
    case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `Candy` to `Nat16`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToNat16(value);
  /// ```
  /// Note: Throws if the underlying value overflows or is negative.
  public func candyToNat16(val : Candy) : Nat16 {
    switch(val){
    case(#Nat16(val)){ val};
    case(#Nat8(val)){Nat16.fromNat(Nat8.toNat(val))};
    case(#Nat(val)){Nat16.fromNat(val)};//will throw on overflow
    case(#Nat32(val)){Nat16.fromNat(Nat32.toNat(val))};//will throw on overflow
    case(#Nat64(val)){Nat16.fromNat(Nat64.toNat(val))};//will throw on overflow
    case(#Float(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat16(#Int(Float.toInt(Float.nearest(val))))};
    case(#Int(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat16(#Nat(Int.abs(val)))};
    case(#Int8(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat16(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
    case(#Int16(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat16(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
    case(#Int32(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat16(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
    case(#Int64(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat16(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
    case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `Candy` to `Nat32`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToNat32(value);
  /// ```
  /// Note: Throws if the underlying value overflows or is negative.
  public func candyToNat32(val : Candy) : Nat32 {
    switch(val){
    case(#Nat32(val)){ val};
    case(#Nat16(val)){ Nat32.fromNat(Nat16.toNat(val))};
    case(#Nat8(val)){ Nat32.fromNat(Nat8.toNat(val))};
    case(#Nat(val)){ Nat32.fromNat(val)};//will throw on overflow
    case(#Float(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat32(#Int(Float.toInt(Float.nearest(val))))};
    case(#Int(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat32(#Nat(Int.abs(val)))};
    case(#Int8(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat32(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
    case(#Int16(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat32(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
    case(#Int32(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat32(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
    case(#Int64(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat32(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
    case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `Candy` to `Nat64`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToNat64(value);
  /// ```
  /// Note: Throws if the underlying value overflows or is negative.
  public func candyToNat64(val : Candy) : Nat64 {
    switch(val){
    case(#Nat64(val)){ val};
    case(#Nat32(val)){ Nat64.fromNat(Nat32.toNat(val))};
    case(#Nat16(val)){ Nat64.fromNat(Nat16.toNat(val))};
    case(#Nat8(val)){ Nat64.fromNat(Nat8.toNat(val))};
    case(#Nat(val)){ Nat64.fromNat(val)};
    case(#Float(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat64(#Int(Float.toInt(Float.nearest(val))))};
    case(#Int(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat64(#Nat(Int.abs(val)))};
    case(#Int8(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat64(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
    case(#Int16(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat64(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
    case(#Int32(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat64(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
    case(#Int64(val)){
      if(val < 0){assert false;};//will throw on negative
      candyToNat64(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
    case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `Candy` to `Int`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToInt(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func candyToInt(val : Candy) : Int {
    switch(val){
      case(#Int(val)){ val};
      case(#Int8(val)){ Int8.toInt(val)};
      case(#Int16(val)){ Int16.toInt(val)};
      case(#Int32(val)){ Int32.toInt(val)};
      case(#Int64(val)){ Int64.toInt(val)};
      case(#Nat(val)){ val};
      case(#Nat8(val)){ Nat8.toNat(val)};
      case(#Nat16(val)){ Nat16.toNat(val)};
      case(#Nat32(val)){ Nat32.toNat(val)};
      case(#Nat64(val)){Nat64.toNat(val)};
      case(#Float(val)){ Float.toInt(Float.nearest(val))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `Candy` to `Int8`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToInt8(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func candyToInt8(val : Candy) : Int8 {
    switch(val){
      case(#Int8(val)){val};
      case(#Int(val)){ Int8.fromInt(val)};//will throw on overflow
      case(#Int16(val)){ Int8.fromInt(Int16.toInt(val))};//will throw on overflow
      case(#Int32(val)){ Int8.fromInt(Int32.toInt(val))};//will throw on overflow
      case(#Int64(val)){ Int8.fromInt(Int64.toInt(val))};//will throw on overflow
      case(#Nat8(val)){ Int8.fromNat8(val)};
      case(#Nat(val)){Int8.fromNat8(candyToNat8(#Nat(val)))};//will throw on overflow
      case(#Nat16(val)){Int8.fromNat8(candyToNat8(#Nat16(val)))};//will throw on overflow
      case(#Nat32(val)){Int8.fromNat8(candyToNat8(#Nat32(val)))};//will throw on overflow
      case(#Nat64(val)){Int8.fromNat8(candyToNat8(#Nat64(val)))};//will throw on overflow
      case(#Float(val)){ Int8.fromInt(Float.toInt(Float.nearest(val)))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `Candy` to `Int16`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToInt16(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func candyToInt16(val : Candy) : Int16 {
    switch(val){
      case(#Int16(val)){ val};
      case(#Int8(val)){ Int16.fromInt(Int8.toInt(val))};
      case(#Int(val)){ Int16.fromInt(val)};//will throw on overflow
      case(#Int32(val)){ Int16.fromInt(Int32.toInt(val))};//will throw on overflow
      case(#Int64(val)){ Int16.fromInt(Int64.toInt(val))};//will throw on overflow
      case(#Nat8(val)){Int16.fromNat16(candyToNat16(#Nat8(val)))};
      case(#Nat(val)){Int16.fromNat16(candyToNat16(#Nat(val)))};//will throw on overflow
      case(#Nat16(val)){ Int16.fromNat16(val)};
      case(#Nat32(val)){Int16.fromNat16(candyToNat16(#Nat32(val)))};//will throw on overflow
      case(#Nat64(val)){Int16.fromNat16(candyToNat16(#Nat64(val)))};//will throw on overflow
      case(#Float(val)){ Int16.fromInt(Float.toInt(Float.nearest(val)))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `Candy` to `Int32`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToInt32(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func candyToInt32(val : Candy) : Int32 {
    switch(val){
      case(#Int32(val)){val};
      case(#Int16(val)){Int32.fromInt(Int16.toInt(val))};
      case(#Int8(val)){Int32.fromInt(Int8.toInt(val))};
      case(#Int(val)){Int32.fromInt(val)};//will throw on overflow
      case(#Nat8(val)){Int32.fromNat32(candyToNat32(#Nat8(val)))};
      case(#Nat(val)){Int32.fromNat32(candyToNat32(#Nat(val)))};//will throw on overflow
      case(#Nat16(val)){Int32.fromNat32(candyToNat32(#Nat16(val)))};
      case(#Nat32(val)){Int32.fromNat32(val)};
      case(#Nat64(val)){Int32.fromNat32(candyToNat32(#Nat64(val)))};//will throw on overflow
      case(#Float(val)){Int32.fromInt(Float.toInt(Float.nearest(val)))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `Candy` to `Int64`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToInt64(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func candyToInt64(val : Candy) : Int64 {
    switch(val){
      case(#Int64(val)){ val};
      case(#Int32(val)){ Int64.fromInt(Int32.toInt(val))};
      case(#Int16(val)){ Int64.fromInt(Int16.toInt(val))};
      case(#Int8(val)){ Int64.fromInt(Int8.toInt(val))};
      case(#Int(val)){ Int64.fromInt(val)};//will throw on overflow
      case(#Nat8(val)){Int64.fromNat64(candyToNat64(#Nat8(val)))};
      case(#Nat(val)){Int64.fromNat64(candyToNat64(#Nat(val)))};//will throw on overflow
      case(#Nat16(val)){Int64.fromNat64(candyToNat64(#Nat16(val)))};
      case(#Nat32(val)){Int64.fromNat64(candyToNat64(#Nat32(val)))};//will throw on overflow
      case(#Nat64(val)){ Int64.fromNat64(val)};
      case(#Float(val)){ Float.toInt64(Float.nearest(val))};
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `Candy` to `Float`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int16(2);
  /// let converted_value = Conversion.candyToFloat(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func candyToFloat(val : Candy) : Float {
    switch(val){
      case(#Float(val)){ val};
      case(#Int64(val)){ Float.fromInt64(val)};
      case(#Int32(val)){candyToFloat(#Int(Int32.toInt(val)))};
      case(#Int16(val)){candyToFloat(#Int(Int16.toInt(val)))};
      case(#Int8(val)){candyToFloat(#Int(Int8.toInt(val)))};
      case(#Int(val)){ Float.fromInt(val)};
      case(#Nat8(val)){candyToFloat(#Int(Nat8.toNat(val)))};
      case(#Nat(val)){candyToFloat(#Int(val))};//will throw on overflow
      case(#Nat16(val)){candyToFloat(#Int(Nat16.toNat(val)))};
      case(#Nat32(val)){candyToFloat(#Int(Nat32.toNat(val)))};//will throw on overflow
      case(#Nat64(val)){candyToFloat(#Int(Nat64.toNat(val)))};
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `Candy` to `Text`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToText(value);
  /// ```
  public func candyToText(val : Candy) : Text {
    switch(val){
      case(#Text(val)){ val};
      case(#Nat64(val)){ Nat64.toText(val)};
      case(#Nat32(val)){ Nat32.toText(val)};
      case(#Nat16(val)){ Nat16.toText(val)};
      case(#Nat8(val)){ Nat8.toText(val)};
      case(#Nat(val)){ Nat.toText(val)};
      case(#Int64(val)){ Int64.toText(val)};
      case(#Int32(val)){ Int32.toText(val)};
      case(#Int16(val)){ Int16.toText(val)};
      case(#Int8(val)){ Int8.toText(val)};
      case(#Int(val)){ Int.toText(val)};
      case(#Bool(val)){ Bool.toText(val)};
      case(#Float(val)){ Float.format(#exact, val)};
      case(#Option(val)){
        switch(val){
          case(null){ "null"};
          case(?val){candyToText(val)};
        };
      };
      //blob
      case(#Blob(val)){
          return Hex.encode(Blob.toArray(val));
      };
      //class
      case(#Class(val)){ //this is currently not parseable and should probably just be used for debuging. It would be nice to output candid.

        var t = "{";
        for(thisItem in Map.entries(val)){
          t := t # thisItem.1.name # ":" # (if(thisItem.1.immutable == false){"var "}else{""}) # candyToText(thisItem.1.value) # "; ";
        };
        
        return Text.trimEnd(t, #text(" ")) # "}";


      };
      //principal
      case(#Principal(val)){ Principal.toText(val)};
      //array
      case(#Array(val)){
      
          var t = "[";
          for(thisItem in StableBuffer.vals(val)){
            t := t # "{" # candyToText(thisItem) # "} ";
          };
          
          return Text.trimEnd(t, #text(" ")) # "]";
      
      };
      //floats
      case(#Floats(val)){
        
          var t = "[";
          for(thisItem in StableBuffer.vals(val)){
            t := t # Float.format(#exact, thisItem) # " ";
          };
          
          return Text.trimEnd(t, #text(" ")) # "]";

      };
      //floats
      case(#Nats(val)){
        
          var t = "[";
          for(thisItem in StableBuffer.vals(val)){
            t := t # Nat.toText(thisItem) # " ";
          };
          
          return Text.trimEnd(t, #text(" ")) # "]";

      };
      //floats
      case(#Ints(val)){
        
          var t = "[";
          for(thisItem in StableBuffer.vals(val)){
            t := t # Int.toText(thisItem) # " ";
          };
          
          return Text.trimEnd(t, #text(" ")) # "]";

      };
      //bytes
      case(#Bytes(val)){
       
        return Hex.encode(StableBuffer.toArray(val));
         
      };
      case(#Set(val)){ //this is currently not parseable and should probably just be used for debuging. It would be nice to output candid.

         var t = "[";
          for(thisItem in Set.keys(val)){
            t := t # "{" # candyToText(thisItem) # "} ";
          };
          
          return Text.trimEnd(t, #text(" ")) # "]";


      };
      case(#Map(val)){ //this is currently not parseable and should probably just be used for debuging. It would be nice to output candid.

        var t = "{";
        for(thisItem in Map.entries(val)){
          t := t # thisItem.0 # ":" # candyToText(thisItem.1) # "; ";
        };
        
        return Text.trimEnd(t, #text(" ")) # "}";


      };
      case(#ValueMap(val)){ //this is currently not parseable and should probably just be used for debuging. It would be nice to output candid.

        var t = "{";
        for(thisItem in Map.entries(val)){
          t := t # candyToText(thisItem.0) # ":" # candyToText(thisItem.1) # "; ";
        };
        
        return Text.trimEnd(t, #text(" ")) # "}";


      };
      //case(_){assert(false);/*unreachable*/"";};
    };
  };

  /// Convert a `Candy` to `Principal`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Principal(Principal.fromText("abc"));
  /// let converted_value = Conversion.candyToPrincipal(value);
  /// ```
  /// Note: Throws if the underlying value is not a `#Principal`.
  public func candyToPrincipal(val : Candy) : Principal {
    switch(val){
      case(#Principal(val)){val};
      case(_){assert(false);/*unreachable*/Principal.fromText("");};
    };
  };

  /// Convert a `Candy` to `Bool`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Bool(false);
  /// let converted_value = Conversion.candyToPBool(value);
  /// ```
  /// Note: Throws if the underlying value is not a `#Bool`.
  public func candyToBool(val : Candy) : Bool {
    
    switch(val){
      case(#Bool(val)){val};
      case(_){assert(false);/*unreachable*/false;};
    };
  };

  /// Convert a `Candy` to `Blob`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Principal(Principal.fromText("abc"));
  /// let converted_value = Conversion.candyToBlob(value);
  /// ```
  public func candyToBlob(val : Candy) : Blob {

    switch(val){
      case(#Blob(val)){val};
      case(#Bytes(val)){Blob.fromArray(StableBuffer.toArray(val))};
      case(#Text(val)){
          Blob.fromArray(textToBytes(val))
      };
      case(#Int(val)){
          Blob.fromArray(intToBytes(val))
      };
      case(#Nat(val)){
          Blob.fromArray(natToBytes(val))
      };
      case(#Nat8(val)){
          
          Blob.fromArray([val])
      };
      case(#Nat16(val)){
          Blob.fromArray(nat16ToBytes(val))
      };
      case(#Nat32(val)){
          Blob.fromArray(nat32ToBytes(val))
      };
      case(#Nat64(val)){
          Blob.fromArray(nat64ToBytes(val))
      };
      case(#Principal(val)){
          Principal.toBlob(val);
      };
      //todo: could add all conversions here
      case(_){assert(false);/*unreachable*/"\00";};
    };
  };

  /// Convert a `Candy` to `[Candy]`
  ///
  /// The conversion is done by getting the array of candy values of the #Array.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Array([1, 2, 3]);
  /// let converted_value = Conversion.candyToValueArray(value);
  /// ```
  /// Note: Throws if the underlying value is not an `#Array`.
  public func candyToValueArray(val : Candy) : [Candy] {
    switch(val){
      case(#Array(val)){StableBuffer.toArray(val)};
      //todo: could add all conversions here
      case(_){assert(false);/*unreachable*/[];};
    };
  };

  /// Convert a `Candy` to Bytes(`[Nat8]`)
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Principal(Principal.fromText("abc"));
  /// let value_as_bytes = Conversion.candyToBytes(value);
  /// ```
  public func candyToBytes(val : Candy) : [Nat8]{
    switch(val){
      case(#Int(val)){intToBytes(val)};
      case(#Int8(val)){candyToBytes(#Int(candyToInt(#Int8(val))))};
      case(#Int16(val)){candyToBytes(#Int(candyToInt(#Int16(val))))};
      case(#Int32(val)){candyToBytes(#Int(candyToInt(#Int32(val))))};
      case(#Int64(val)){candyToBytes(#Int(candyToInt(#Int64(val))))};
      case(#Nat(val)){natToBytes(val)};
      case(#Nat8(val)){ [val]};
      case(#Nat16(val)){nat16ToBytes(val)};
      case(#Nat32(val)){nat32ToBytes(val)};
      case(#Nat64(val)){nat64ToBytes(val)};
      case(#Float(val)){Prelude.nyi()};
      case(#Text(val)){textToBytes(val)};
      case(#Bool(val)){boolToBytes(val)};
      case(#Blob(val)){ Blob.toArray(val)};
      case(#Class(val)){Prelude.nyi()};
      case(#Principal(val)){principalToBytes(val)};
      case(#Option(val)){Prelude.nyi()};
      case(#Array(val)){Prelude.nyi()};
      case(#Bytes(val)){StableBuffer.toArray(val)};
      case(#Floats(val)){Prelude.nyi()};
      case(#Nats(val)){Prelude.nyi()};
      case(#Ints(val)){Prelude.nyi()};
      case(#ValueMap(val)){Prelude.nyi()};
      case(#Map(val)){Prelude.nyi()};
      case(#Set(val)){Prelude.nyi()};
    }
  };

  /// Convert a `Candy` to `Buffer<Nat8>`
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Principal(Principal.fromText("abc"));
  /// let value_as_buffer = Conversion.candyToBytesBuffer(value);
  /// ```
  ///
  /// Note: Throws if the underlying value isn't convertible.
  public func candyToBytesBuffer(val : Candy) : Buffer.Buffer<Nat8>{
    switch (val){
      case(#Bytes(val)){Buffer.fromArray(StableBuffer.toArray(val))};
      case(_){
          toBuffer<Nat8>(candyToBytes(val));//may throw for uncovertable types
      };
    };
  };

  /// Convert a `Candy` to `Buffer<Float>`
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Nat(102);
  /// let value_as_floats_buffer = Conversion.candyToFloatsBuffer(value);
  /// ```
  /// Note: Throws if the underlying value isn't convertible.
  public func candyToFloatsBuffer(val : Candy) : Buffer.Buffer<Float>{
    switch (val){
      case(#Floats(val)){
        stableBufferToBuffer(val);
      };
      case(_){
        toBuffer([candyToFloat(val)]); //may throw for unconvertable types
      };
    };
  };

  /// Convert a `Candy` to `Buffer<Nat>`
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Nat(102);
  /// let value_as_nats_buffer = Conversion.candyToNatsBuffer(value);
  /// ```
  /// Note: Throws if the underlying value isn't convertible.
  public func candyToNatsBuffer(val : Candy) : Buffer.Buffer<Nat>{
    switch (val){
      case(#Nats(val)){
        stableBufferToBuffer(val);
      };
      case(_){
          toBuffer([candyToNat(val)]); //may throw for unconvertable types
      };
    };
  };

  /// Convert a `Candy` to `Map<Text, Candy>`
  ///
  /// Example:
  /// ```motoko include=import
  /// let map = Map.new<text,Candy>();
  /// Map.put<Text, Candy>(map, thash, "akey", #Text("value"));
  /// let value: Candy = #Map(map);
  /// let value_as_nats_buffer = Conversion.candyToMap(value);
  /// ```
  /// Note: Throws if the underlying value isn't convertible.
  public func candyToMap(val : Candy) : Map.Map<Text, Candy>{
    switch (val){
      case(#Map(val)){
        return val;
      };
      case(_){
          Prelude.nyi(); //will throw for unconvertable types
      };
    };
  };

  /// Example:
  /// ```motoko include=import
  /// let map = Map.new<text,Candy>();
  /// Map.put<candy, Candy>(map, candyHashTool, #Text("akey"), #Text("value"));
  /// let value: Candy = #ValueMapMap(map);
  /// let value_as_nats_buffer = Conversion.candyToValueMap(value);
  /// ```
  /// Note: Throws if the underlying value isn't convertible.
  public func candyToValueMap(val : Candy) : Map.Map<Candy, Candy>{
    switch (val){
      case(#ValueMap(val)){
        return val;
      };
      case(_){
          Prelude.nyi(); //will throw for unconvertable types
      };
    };
  };

  /// Example:
  /// ```motoko include=import
  /// let map = Set.new<Candy>();
  /// Set.put<Candy>(map, candyHashTool, #Text("akey"));
  /// let value: Candy = #Set(map);
  /// let value_as_nats_buffer = Conversion.candyToSet(value);
  /// ```
  /// Note: Throws if the underlying value isn't convertible.
  public func candyToSet(val : Candy) : Set.Set<Candy>{
    switch (val){
      case(#Set(val)){
        return val;
      };
      case(_){
          Prelude.nyi(); //will throw for unconvertable types
      };
    };
  };
  
  /// Convert a `Candy` to `Map<Text, Property>`
  ///
  /// Example:
  /// ```motoko include=import
  /// let map = Map.new<text,Candy>();
  /// Map.put<Text, Property>(map, thash, "akey", {name="test";value=#Text("value"); immutable=true;);
  /// let value: Candy = #Class(map);
  /// let value_as_nats_buffer = Conversion.candyToPropertyMap(value);
  /// ```
  /// Note: Throws if the underlying value isn't convertible.
  public func candyToPropertyMap(val : Candy) : Map.Map<Text, Property>{
    switch (val){
      case(#Class(val)){
        return val;
      };
      case(_){
          Prelude.nyi(); //will throw for unconvertable types
      };
    };
  };

  /// Convert a `CandyShared` to `Nat`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Int16(15);
  /// let converted_value = Conversion.candySharedToNat(value);
  /// ```
  /// Note: Throws if the underlying value overflows or is negative.
  public func candySharedToNat(val : CandyShared) : Nat {

    switch(val){
      case(#Nat(val)){ val};
      case(#Nat8(val)){ Nat8.toNat(val)};
      case(#Nat16(val)){ Nat16.toNat(val)};
      case(#Nat32(val)){Nat32.toNat(val)};
      case(#Nat64(val)){ Nat64.toNat(val)};
      case(#Float(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat(#Int(Float.toInt(Float.nearest(val))))};
      case(#Int(val)){
          if(val < 0){assert false;};//will throw on negative
          
          Int.abs(val)};
      case(#Int8(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
      case(#Int16(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
      case(#Int32(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
      case(#Int64(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyShared` to `Nat8`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Int8(15);
  /// let converted_value = Conversion.candySharedToNat8(value);
  /// ```
  /// Note: Throws if the underlying value overflows or is negative.
  public func candySharedToNat8(val : CandyShared) : Nat8 {

    switch(val){
      case(#Nat8(val)){ val};
      case(#Nat(val)){ Nat8.fromNat(val)};//will throw on overflow
      case(#Nat16(val)){ Nat8.fromNat(Nat16.toNat(val))};//will throw on overflow
      case(#Nat32(val)){ Nat8.fromNat(Nat32.toNat(val))};//will throw on overflow
      case(#Nat64(val)){ Nat8.fromNat(Nat64.toNat(val))};//will throw on overflow
      case(#Float(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat8(#Int(Float.toInt(Float.nearest(val))))};
      case(#Int(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat8(#Nat(Int.abs(val)))};
      case(#Int8(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat8(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
      case(#Int16(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat8(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
      case(#Int32(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat8(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
      case(#Int64(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat8(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyShared` to `Nat16`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Int16(15);
  /// let converted_value = Conversion.candySharedToNat16(value);
  /// ```
  /// Note: Throws if the underlying value overflows or is negative.
  public func candySharedToNat16(val : CandyShared) : Nat16 {

    switch(val){
      case(#Nat16(val)){ val};
      case(#Nat8(val)){ Nat16.fromNat(Nat8.toNat(val))};
      case(#Nat(val)){ Nat16.fromNat(val)};//will throw on overflow
      case(#Nat32(val)){ Nat16.fromNat(Nat32.toNat(val))};//will throw on overflow
      case(#Nat64(val)){ Nat16.fromNat(Nat64.toNat(val))};//will throw on overflow
      case(#Float(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat16(#Int(Float.toInt(Float.nearest(val))))};
      case(#Int(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat16(#Nat(Int.abs(val)))};
      case(#Int8(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat16(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
      case(#Int16(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat16(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
      case(#Int32(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat16(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
      case(#Int64(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat16(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyShared` to `Nat32`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Int32(15);
  /// let converted_value = Conversion.candySharedToNat(value);
  /// ```
  /// Note: Throws if the underlying value overflows or is negative.
  public func candySharedToNat32(val : CandyShared) : Nat32 {

    switch(val){
      case(#Nat32(val)){val};
      case(#Nat16(val)){Nat32.fromNat(Nat16.toNat(val))};
      case(#Nat8(val)){ Nat32.fromNat(Nat8.toNat(val))};
      case(#Nat(val)){ Nat32.fromNat(val)};//will throw on overflow
      case(#Float(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat32(#Int(Float.toInt(Float.nearest(val))))};
      case(#Int(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat32(#Nat(Int.abs(val)))};
      case(#Int8(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat32(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
      case(#Int16(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat32(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
      case(#Int32(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat32(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
      case(#Int64(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat32(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyShared` to `Nat64`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Int16(15);
  /// let converted_value = Conversion.candySharedToNat64(value);
  /// ```
  /// Note: Throws if the underlying value is negative.
  public func candySharedToNat64(val : CandyShared) : Nat64 {

    switch(val){
      case(#Nat64(val)){ val};
      case(#Nat32(val)){ Nat64.fromNat(Nat32.toNat(val))};
      case(#Nat16(val)){ Nat64.fromNat(Nat16.toNat(val))};
      case(#Nat8(val)){ Nat64.fromNat(Nat8.toNat(val))};
      case(#Nat(val)){ Nat64.fromNat(val)};
      case(#Float(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat64(#Int(Float.toInt(Float.nearest(val))))};
      case(#Int(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat64(#Nat(Int.abs(val)))};
      case(#Int8(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat64(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
      case(#Int16(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat64(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
      case(#Int32(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat64(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
      case(#Int64(val)){
          if(val < 0){assert false;};//will throw on negative
          candySharedToNat64(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyShared` to `Int`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Int16(15);
  /// let converted_value = Conversion.candySharedToInt(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func candySharedToInt(val : CandyShared) : Int {
    switch(val){
      case(#Int(val)){val};
      case(#Int8(val)){ Int8.toInt(val)};
      case(#Int16(val)){ Int16.toInt(val)};
      case(#Int32(val)){ Int32.toInt(val)};
      case(#Int64(val)){ Int64.toInt(val)};
      case(#Nat(val)){ val};
      case(#Nat8(val)){Nat8.toNat(val)};
      case(#Nat16(val)){Nat16.toNat(val)};
      case(#Nat32(val)){Nat32.toNat(val)};
      case(#Nat64(val)){Nat64.toNat(val)};
      case(#Float(val)){Float.toInt(Float.nearest(val))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyShared` to `Int8`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Nat8(11);
  /// let converted_value = Conversion.candySharedToInt8(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func candySharedToInt8(val : CandyShared) : Int8 {
    switch(val){
      case(#Int8(val)){ val};
      case(#Int(val)){ Int8.fromInt(val)};//will throw on overflow
      case(#Int16(val)){ Int8.fromInt(Int16.toInt(val))};//will throw on overflow
      case(#Int32(val)){ Int8.fromInt(Int32.toInt(val))};//will throw on overflow
      case(#Int64(val)){ Int8.fromInt(Int64.toInt(val))};//will throw on overflow
      case(#Nat8(val)){ Int8.fromNat8(val)};
      case(#Nat(val)){Int8.fromNat8(candySharedToNat8(#Nat(val)))};//will throw on overflow
      case(#Nat16(val)){Int8.fromNat8(candySharedToNat8(#Nat16(val)))};//will throw on overflow
      case(#Nat32(val)){Int8.fromNat8(candySharedToNat8(#Nat32(val)))};//will throw on overflow
      case(#Nat64(val)){Int8.fromNat8(candySharedToNat8(#Nat64(val)))};//will throw on overflow
      case(#Float(val)){ Int8.fromInt(Float.toInt(Float.nearest(val)))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyShared` to `Int16`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Float(10);
  /// let converted_value = Conversion.candySharedToInt16(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func candySharedToInt16(val : CandyShared) : Int16 {
    switch(val){
      case(#Int16(val)){ val};
      case(#Int8(val)){ Int16.fromInt(Int8.toInt(val))};
      case(#Int(val)){ Int16.fromInt(val)};//will throw on overflow
      case(#Int32(val)){ Int16.fromInt(Int32.toInt(val))};//will throw on overflow
      case(#Int64(val)){ Int16.fromInt(Int64.toInt(val))};//will throw on overflow
      case(#Nat8(val)){Int16.fromNat16(candySharedToNat16(#Nat8(val)))};
      case(#Nat(val)){Int16.fromNat16(candySharedToNat16(#Nat(val)))};//will throw on overflow
      case(#Nat16(val)){ Int16.fromNat16(val)};
      case(#Nat32(val)){Int16.fromNat16(candySharedToNat16(#Nat32(val)))};//will throw on overflow
      case(#Nat64(val)){Int16.fromNat16(candySharedToNat16(#Nat64(val)))};//will throw on overflow
      case(#Float(val)){ Int16.fromInt(Float.toInt(Float.nearest(val)))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyShared` to `Int32`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Nat32(1111);
  /// let converted_value = Conversion.candySharedToInt32(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func candySharedToInt32(val : CandyShared) : Int32 {
    switch(val){
      case(#Int32(val)){ val};
      case(#Int16(val)){ Int32.fromInt(Int16.toInt(val))};
      case(#Int8(val)){ Int32.fromInt(Int8.toInt(val))};
      case(#Int(val)){ Int32.fromInt(val)};//will throw on overflow
      case(#Nat8(val)){Int32.fromNat32(candySharedToNat32(#Nat8(val)))};
      case(#Nat(val)){Int32.fromNat32(candySharedToNat32(#Nat(val)))};//will throw on overflow
      case(#Nat16(val)){Int32.fromNat32(candySharedToNat32(#Nat16(val)))};
      case(#Nat32(val)){ Int32.fromNat32(val)};
      case(#Nat64(val)){Int32.fromNat32(candySharedToNat32(#Nat64(val)))};//will throw on overflow
      case(#Float(val)){ Int32.fromInt(Float.toInt(Float.nearest(val)))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyShared` to `Int64`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Nat64(12345);
  /// let converted_value = Conversion.candySharedToInt64(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func candySharedToInt64(val : CandyShared) : Int64 {
    switch(val){
      case(#Int64(val)){ val};
      case(#Int32(val)){ Int64.fromInt(Int32.toInt(val))};
      case(#Int16(val)){ Int64.fromInt(Int16.toInt(val))};
      case(#Int8(val)){ Int64.fromInt(Int8.toInt(val))};
      case(#Int(val)){ Int64.fromInt(val)};//will throw on overflow
      case(#Nat8(val)){Int64.fromNat64(candySharedToNat64(#Nat8(val)))};
      case(#Nat(val)){Int64.fromNat64(candySharedToNat64(#Nat(val)))};//will throw on overflow
      case(#Nat16(val)){Int64.fromNat64(candySharedToNat64(#Nat16(val)))};
      case(#Nat32(val)){Int64.fromNat64(candySharedToNat64(#Nat32(val)))};//will throw on overflow
      case(#Nat64(val)){ Int64.fromNat64(val)};
      case(#Float(val)){ Float.toInt64(Float.nearest(val))};
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyShared` to `Float`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Int16(11);
  /// let converted_value = Conversion.candySharedToFloat(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func candySharedToFloat(val : CandyShared) : Float {
    switch(val){
      case(#Float(val)){ val};
      case(#Int64(val)){ Float.fromInt64(val)};
      case(#Int32(val)){candySharedToFloat(#Int(Int32.toInt(val)))};
      case(#Int16(val)){candySharedToFloat(#Int(Int16.toInt(val)))};
      case(#Int8(val)){candySharedToFloat(#Int(Int8.toInt(val)))};
      case(#Int(val)){ Float.fromInt(val)};
      case(#Nat8(val)){candySharedToFloat(#Int(Nat8.toNat(val)))};
      case(#Nat(val)){candySharedToFloat(#Int(val))};//will throw on overflow
      case(#Nat16(val)){candySharedToFloat(#Int(Nat16.toNat(val)))};
      case(#Nat32(val)){candySharedToFloat(#Int(Nat32.toNat(val)))};//will throw on overflow
      case(#Nat64(val)){candySharedToFloat(#Int(Nat64.toNat(val)))};
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyShared` to `Text`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Float(11);
  /// let converted_value = Conversion.candySharedToText(value);
  /// ```
  public func candySharedToText(val : CandyShared) : Text {
    switch(val){
      case(#Text(val)){ val};
      case(#Nat64(val)){ Nat64.toText(val)};
      case(#Nat32(val)){ Nat32.toText(val)};
      case(#Nat16(val)){ Nat16.toText(val)};
      case(#Nat8(val)){ Nat8.toText(val)};
      case(#Nat(val)){ Nat.toText(val)};
      case(#Int64(val)){ Int64.toText(val)};
      case(#Int32(val)){ Int32.toText(val)};
      case(#Int16(val)){ Int16.toText(val)};
      case(#Int8(val)){ Int8.toText(val)};
      case(#Int(val)){ Int.toText(val)};
      case(#Bool(val)){ Bool.toText(val)};
      case(#Float(val)){ Float.format(#exact, val)};
      case(#Option(val)){
          switch(val){
              case(null){ "null"};
              case(?val){candySharedToText(val)};
          };
      };
      //blob
      case(#Blob(val)){
          return Hex.encode(Blob.toArray(val));
      };
      //class
      case(#Class(val)){ //this is currently not parseable and should probably just be used for debuging. It would be nice to output candid.

          var t = "{";
          for(thisItem in val.vals()){
              t := t # thisItem.name # ": " # (if(thisItem.immutable == false){"var "}else{""}) # candySharedToText(thisItem.value) # "; ";
          };
          
          return Text.trimEnd(t, #text(" ")) # "}";


      };
      //principal
      case(#Principal(val)){ Principal.toText(val)};
      //array
      case(#Array(val)){

        var t = "[";
        for(thisItem in val.vals()){
            t := t # "{" # candySharedToText(thisItem) # "} ";
        };
        
        return Text.trimEnd(t, #text(" ")) # "]";
              
      };
      //floats
      case(#Floats(val)){
          
        var t = "[";
        for(thisItem in val.vals()){
            t := t # Float.format(#exact, thisItem) # " ";
        };
        
        return Text.trimEnd(t, #text(" ")) # "]";
             
      };
      //Nats
      case(#Nats(val)){
          
        var t = "[";
        for(thisItem in val.vals()){
            t := t # Nat.toText(thisItem) # " ";
        };
        
        return Text.trimEnd(t, #text(" ")) # "]";
             
      };
      //Ints
      case(#Ints(val)){
          
        var t = "[";
        for(thisItem in val.vals()){
            t := t # Int.toText(thisItem) # " ";
        };
        
        return Text.trimEnd(t, #text(" ")) # "]";
             
      };
      //bytes
      case(#Bytes(val)){
         
        return Hex.encode(val);
            
      };
      case(#Set(val)){ //this is currently not parseable and should probably just be used for debuging. It would be nice to output candid.

          var t = "[";
        for(thisItem in val.vals()){
            t := t # "{" # candySharedToText(thisItem) # "} ";
        };
        
        return Text.trimEnd(t, #text(" ")) # "]";


      };
      case(#Map(val)){ //this is currently not parseable and should probably just be used for debuging. It would be nice to output candid.

          var t = "{";
          for(thisItem in val.vals()){
              t := t # thisItem.0 # ": " # candySharedToText(thisItem.1) # "; ";
          };
          
          return Text.trimEnd(t, #text(" ")) # "}";


      };
      case(#ValueMap(val)){ //this is currently not parseable and should probably just be used for debuging. It would be nice to output candid.

          var t = "{";
          for(thisItem in val.vals()){
              t := t # candySharedToText(thisItem.0) # ": " # candySharedToText(thisItem.1) # "; ";
          };
          
          return Text.trimEnd(t, #text(" ")) # "}";


      };
      //case(_){assert(false);/*unreachable*/"";};
    };
  };

  /// Convert a `CandyShared` to `Principal`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Principal(Principal.fromText("abc"));
  /// let converted_value = Conversion.candySharedToPrincipal(value);
  /// ```
  /// Note: Throws if the underlying value is not a `#Principal`.
  public func candySharedToPrincipal(val : CandyShared) : Principal {
    switch(val){
      case(#Principal(val)){ val};
      case(_){assert(false);/*unreachable*/Principal.fromText("");};
    };
  };

  /// Convert a `CandyShared` to `Principal`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Bool(true);
  /// let converted_value = Conversion.candySharedToPrincipal(value);
  /// ```
  /// Note: Throws if the underlying value is not a `#Bool`.
  public func candySharedToBool(val : CandyShared) : Bool {
    switch(val){
      case(#Bool(val)){ val};
      case(_){assert(false);/*unreachable*/false;};
    };
  };

  /// Convert a `CandyShared` to `Blob`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Principal(Principal.fromText("abc"));
  /// let converted_value = Conversion.candySharedToBlob(value);
  /// ```
  public func candySharedToBlob(val : CandyShared) : Blob {
    switch(val){
      case(#Blob(val)){ val};
      case(#Bytes(val)){
          Blob.fromArray(val);
      };
        case(#Text(val)){
          Blob.fromArray(textToBytes(val))
      };
      case(#Int(val)){
          Blob.fromArray(intToBytes(val))
      };
      case(#Nat(val)){
          Blob.fromArray(natToBytes(val))
      };
      case(#Nat8(val)){
          
          Blob.fromArray([val])
      };
      case(#Nat16(val)){
          Blob.fromArray(nat16ToBytes(val))
      };
      case(#Nat32(val)){
          Blob.fromArray(nat32ToBytes(val))
      };
      case(#Nat64(val)){
          Blob.fromArray(nat64ToBytes(val))
      };
      case(#Principal(val)){
          
          Principal.toBlob(val);
      };
      //todo: could add all conversions here
      case(_){assert(false);/*unreachable*/"\00";};
    };
  };

  /// Convert a `CandyShared` to `[CandyShared]`
  ///
  /// The conversion is done by getting the array of candy values of the #Array.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Array([1, 2, 3]);
  /// let converted_value = Conversion.candySharedToValueArray(value);
  /// ```
  /// Note: Throws if the underlying value is not an `#Array`.
  public func candySharedToValueArray(val : CandyShared) : [CandyShared] {
    switch(val){
      case(#Array(val)){val};
      //todo: could add all conversions here
      case(_){assert(false);/*unreachable*/[];};
    };
  };

  /// Convert a `CandyShared` to Bytes(`[Nat8]`)
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Principal(Principal.fromText("abc"));
  /// let value_as_bytes = Conversion.candySharedToBytes(value);
  /// ```
  public func candySharedToBytes(val : CandyShared) : [Nat8]{
    switch(val){
      case(#Int(val)){intToBytes(val)};
      case(#Int8(val)){candySharedToBytes(#Int(candySharedToInt(#Int8(val))))};
      case(#Int16(val)){candySharedToBytes(#Int(candySharedToInt(#Int16(val))))};
      case(#Int32(val)){candySharedToBytes(#Int(candySharedToInt(#Int32(val))))};
      case(#Int64(val)){candySharedToBytes(#Int(candySharedToInt(#Int64(val))))};
      case(#Nat(val)){ natToBytes(val)};
      case(#Nat8(val)){ [val]};
      case(#Nat16(val)){nat16ToBytes(val)};
      case(#Nat32(val)){nat32ToBytes(val)};
      case(#Nat64(val)){nat64ToBytes(val)};
      case(#Float(val)){Prelude.nyi()};
      case(#Text(val)){textToBytes(val)};
      case(#Bool(val)){boolToBytes(val)};
      case(#Blob(val)){ Blob.toArray(val)};
      case(#Class(val)){Prelude.nyi()};
      case(#Principal(val)){principalToBytes(val)};
      case(#Option(val)){Prelude.nyi()};
      case(#Array(val)){Prelude.nyi()};
      case(#Bytes(val)){val};
      case(#Floats(val)){Prelude.nyi()};
      case(#Nats(val)){Prelude.nyi()};
      case(#Ints(val)){Prelude.nyi()};
      case(#ValueMap(val)){Prelude.nyi()};
      case(#Map(val)){Prelude.nyi()};
      case(#Set(val)){Prelude.nyi()};
    }
  };

  /// Convert a `CandyShared` to `Buffer<Nat8>`
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Principal(Principal.fromText("abc"));
  /// let value_as_buffer = Conversion.candySharedToBytes(value);
  /// ```
  ///
  /// Note: Throws if the underlying value isn't convertible.
  public func candySharedToBytesBuffer(val : CandyShared) : Buffer.Buffer<Nat8>{
    switch (val){
      case(#Bytes(val)){toBuffer(val)};
      case(_){
          toBuffer<Nat8>(candySharedToBytes(val));//may throw for uncovertable types
      };
    };
  };

  /// Convert a `CandyShared` to `Buffer<Float>`
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Nat(102);
  /// let value_as_floats_buffer = Conversion.candySharedToFloatsBuffer(value);
  /// ```
  /// Note: Throws if the underlying value isn't convertible.
  public func candySharedToFloatsBuffer(val : CandyShared) : Buffer.Buffer<Float>{
    switch (val){
      case(#Floats(val)){
        toBuffer(val);
      };
      case(_){
          toBuffer([candySharedToFloat(val)]); //may throw for unconvertable types
      };
    };
  };

  /// Convert a `CandyShared` to `Buffer<Nat>`
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Nat(102);
  /// let value_as_nats_buffer = Conversion.candySharedToNatsBuffer(value);
  /// ```
  /// Note: Throws if the underlying value isn't convertible.
  public func candySharedToNatsBuffer(val : CandyShared) : Buffer.Buffer<Nat>{
    switch (val){
      case(#Nats(val)){
        toBuffer(val);
      };
      case(_){
          toBuffer([candySharedToNat(val)]); //may throw for unconvertable types
      };
    };
  };

  /// Convert a `CandyShared` to `Buffer<Int>`
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Int(102);
  /// let value_as_nats_buffer = Conversion.candySharedToIntsBuffer(value);
  /// ```
  /// Note: Throws if the underlying value isn't convertible.
  public func candySharedToIntsBuffer(val : CandyShared) : Buffer.Buffer<Int>{
    switch (val){
      case(#Ints(val)){
        toBuffer(val);
      };
      case(_){
          toBuffer([candySharedToInt(val)]); //may throw for unconvertable types
      };
    };
  };

  //////////////////////////////////////////////////////////////////////
  // The following functions easily creates a buffer from an arry of any type
  //////////////////////////////////////////////////////////////////////

  /// Create a `Buffer` from [T] where T can be of any type.
  ///
  /// Example:
  /// ```motoko include=import
  ///  let array = [1, 2, 3];
  ///  let buf = Conversion.toBuffer<Nat>(array);
  /// ```
  public func toBuffer<T>(x :[T]) : Buffer.Buffer<T>{
    let thisBuffer = Buffer.Buffer<T>(x.size());
    for(thisItem in x.vals()){
      thisBuffer.add(thisItem);
    };
    return thisBuffer;
  };

  /// Create a `Buffer<T>` from `StableBuffer<T>` where T can be of any type.
  ///
  /// Example:
  /// ```motoko include=import
  /// let stable_buff = StableBuffer.fromArray([1, 2, 3]);
  /// let buff = Conversion.stableBufferToBuffer(stable_buff);
  /// ```
  public func stableBufferToBuffer<T>(x : StableBuffer<T>) : Buffer.Buffer<T>{
    let thisBuffer = Buffer.Buffer<T>(StableBuffer.size(x));
    for(thisItem in StableBuffer.vals(x)){
      thisBuffer.add(thisItem);
    };
    return thisBuffer;
  };

  //////////////////////////////////////////////////////////////////////
  // The following functions convert standard types to Byte arrays
  // From there you can easily get to blobs if necessary with the Blob package
  //////////////////////////////////////////////////////////////////////

  /// Convert a `Nat` to Bytes(`[Nat8]`)
  ///
  /// Example:
  /// ```motoko include=import
  ///  let value: Nat = 150;
  ///  let bytes = Conversion.natToBytes(value);
  /// ```
  public func natToBytes(n : Nat) : [Nat8] {
    var a : Nat8 = 0;
    var b : Nat = n;
    var bytes = List.nil<Nat8>();
    var test = true;
    while test {
      a := Nat8.fromNat(b % 256);
      b := b / 256;
      bytes := List.push<Nat8>(a, bytes);
      test := b > 0;
    };
    List.toArray<Nat8>(bytes);
  };

  /// Convert a `Nat64` to Bytes(`[Nat8]`)
  ///
  /// Example:
  /// ```motoko include=import
  ///  let value: Nat64 = 150;
  ///  let bytes = Conversion.nat64ToBytes(value);
  /// ```
  public func nat64ToBytes(x : Nat64) : [Nat8] {
    [ Nat8.fromNat(Nat64.toNat((x >> 56) & (255))),
    Nat8.fromNat(Nat64.toNat((x >> 48) & (255))),
    Nat8.fromNat(Nat64.toNat((x >> 40) & (255))),
    Nat8.fromNat(Nat64.toNat((x >> 32) & (255))),
    Nat8.fromNat(Nat64.toNat((x >> 24) & (255))),
    Nat8.fromNat(Nat64.toNat((x >> 16) & (255))),
    Nat8.fromNat(Nat64.toNat((x >> 8) & (255))),
    Nat8.fromNat(Nat64.toNat((x & 255))) ];
  };

  /// Convert a `Nat32` to Bytes(`[Nat8]`)
  ///
  /// Example:
  /// ```motoko include=import
  ///  let value: Nat32 = 150;
  ///  let bytes = Conversion.nat32ToBytes(value);
  /// ```
  public func nat32ToBytes(x : Nat32) : [Nat8] {
    [ Nat8.fromNat(Nat32.toNat((x >> 24) & (255))),
    Nat8.fromNat(Nat32.toNat((x >> 16) & (255))),
    Nat8.fromNat(Nat32.toNat((x >> 8) & (255))),
    Nat8.fromNat(Nat32.toNat((x & 255))) ];
  };

  /// Convert a `Nat16` to Bytes(`[Nat8]`)
  ///
  /// Example:
  /// ```motoko include=import
  ///  let value: Nat16 = 150;
  ///  let bytes = Conversion.nat16ToBytes(value);
  /// ```
  public func nat16ToBytes(x : Nat16) : [Nat8] {
    [ Nat8.fromNat(Nat16.toNat((x >> 8) & (255))),
    Nat8.fromNat(Nat16.toNat((x & 255))) ];
  };

  /// Convert Bytes(`[Nat8]`) to `Nat16`
  ///
  /// Example:
  /// ```motoko include=import
  ///  let bytes: [Nat8] = [1, 2, 3, 4];
  ///  let value = Conversion.bytesToNat16(bytes);
  /// ```
  public func bytesToNat16(bytes: [Nat8]) : Nat16{
    (Nat16.fromNat(Nat8.toNat(bytes[0])) << 8) +
    (Nat16.fromNat(Nat8.toNat(bytes[1])));
  };

  /// Convert Bytes(`[Nat8]`) to `Nat32`
  ///
  /// Example:
  /// ```motoko include=import
  ///  let bytes: [Nat8] = [1, 2, 3, 4];
  ///  let value = Conversion.bytesToNat32(bytes);
  /// ```
  public func bytesToNat32(bytes: [Nat8]) : Nat32{
    (Nat32.fromNat(Nat8.toNat(bytes[0])) << 24) +
    (Nat32.fromNat(Nat8.toNat(bytes[1])) << 16) +
    (Nat32.fromNat(Nat8.toNat(bytes[2])) << 8) +
    (Nat32.fromNat(Nat8.toNat(bytes[3])));
  };

  /// Convert Bytes(`[Nat8]`) to `Nat64`
  ///
  /// Example:
  /// ```motoko include=import
  ///  let bytes: [Nat8] = [1, 2, 3, 4];
  ///  let value = Conversion.bytesToNat64(bytes);
  /// ```
  public func bytesToNat64(bytes: [Nat8]) : Nat64{
    
    (Nat64.fromNat(Nat8.toNat(bytes[0])) << 56) +
    (Nat64.fromNat(Nat8.toNat(bytes[1])) << 48) +
    (Nat64.fromNat(Nat8.toNat(bytes[2])) << 40) +
    (Nat64.fromNat(Nat8.toNat(bytes[3])) << 32) +
    (Nat64.fromNat(Nat8.toNat(bytes[4])) << 24) +
    (Nat64.fromNat(Nat8.toNat(bytes[5])) << 16) +
    (Nat64.fromNat(Nat8.toNat(bytes[6])) << 8) +
    (Nat64.fromNat(Nat8.toNat(bytes[7])));
  };

  /// Convert Bytes(`[Nat8]`) to `Nat`
  ///
  /// Example:
  /// ```motoko include=import
  ///  let bytes: [Nat8] = [1, 2, 3, 4];
  ///  let value = Conversion.bytesToNat(bytes);
  /// ```
  public func bytesToNat(bytes : [Nat8]) : Nat {
    var n : Nat = 0;
    var i = 0;
    Array.foldRight<Nat8, ()>(bytes, (), func (byte, _) {
      n += Nat8.toNat(byte) * 256 ** i;
      i += 1;
      return;
    });
    return n;
  };

  /// Convert `Text` to `Buffer<Nat8>`
  ///
  /// Example:
  /// ```motoko include=import
  ///  let t = "sample_text";
  ///  let buf = Conversion.textToByteBuffer(t);
  /// ```
  public func textToByteBuffer(_text : Text) : Buffer.Buffer<Nat8>{
    let result : Buffer.Buffer<Nat8> = Buffer.Buffer<Nat8>((_text.size() * 4) +4);
    for(thisChar in _text.chars()){
      for(thisByte in nat32ToBytes(Char.toNat32(thisChar)).vals()){
          result.add(thisByte);
      };
    };
    return result;
  };

  /// Convert `Text` to Bytes(`[Nat8]`)
  ///
  /// Example:
  /// ```motoko include=import
  ///  let t = "sample_text";
  ///  let bytes = Conversion.textToBytes(t);
  /// ```
  public func textToBytes(_text : Text) : [Nat8]{
    return Buffer.toArray(textToByteBuffer(_text));
  };

  /// Encode `Text` to a giant int(`?Nat`)
  ///
  /// Example:
  /// ```motoko include=import
  ///  let t = "sample_text";
  ///  let encoded_t = Conversion.encodeTextAsNat(t);
  /// ```
  public func encodeTextAsNat(phrase : Text) : ?Nat {
    var theSum : Nat = 0;
    Iter.iterate(Text.toIter(phrase), func (x : Char, n : Nat){
      //todo: check for digits
      theSum := theSum + ((Nat32.toNat(Char.toNat32(x)) - 48) * 10 **  (phrase.size()-n-1));
    });
    return ?theSum;
  };

  /// Convert `Text` to a `?Nat`
  ///
  /// Example:
  /// ```motoko include=import
  ///  let t = "100";
  ///  let t_as_nat = Conversion.textToNat(t); // 100
  /// ```
  ///
  /// Note: Returns `null` if the text is empty.
  public func textToNat( txt : Text) : ?Nat {
    if(txt.size() > 0){
      let chars = txt.chars();
      var num : Nat = 0;
      for (v in chars){
          let charToNum = Nat32.toNat(Char.toNat32(v)-48);
          if(charToNum >= 0 and charToNum <= 9){
              num := num * 10 +  charToNum; 
          } else {
              return null;
          };         
      };
      ?num;
    }else {
      return null;
    };
  };

  /// Convert `Property` to a `Text`
  ///
  /// Example:
  /// ```motoko include=import
  /// let prop: Property = {
  ///    name = "name";
  ///    value = #Principal(Principal.fromText("abc"));
  ///    immutable = true;
  /// };
  /// let prop_as_text = Conversion.propertyToText(t);
  /// ```
  public func propertyToText(a: Types.Property):Text{candyToText(a.value)};

  /// Convert `PropertyShared` to a `Text`
  ///
  /// Example:
  /// ```motoko include=import
  /// let prop: PropertyShared = {
  ///    name = "name";
  ///    value = #Principal(Principal.fromText("abc"));
  ///    immutable = true;
  /// };
  /// let prop_as_text = Conversion.propertyToText(t);
  /// ```
  public func propertySharedToText(a: Types.PropertyShared):Text{candySharedToText(a.value)};

  /// Convert `Candy` to `Properties`
  ///
  /// Example:
  /// ```motoko include=import
  ///  let val: Candy = #Class([
  ///    {
  ///      name = "prop1";
  ///      value = #Principal(Principal.fromText("abc"));
  ///      immutable = true;
  ///    },
  ///    {
  ///      name = "prop2";
  ///      value = #Principal(Principal.fromText("abc"));
  ///      immutable = false;
  ///    }
  ///  ]);
  ///  let props = Conversion.candyToProperties(val);
  /// ```
  /// Note: throws if the underlying value is not `#Class`.
  public func candyToProperties(val : Candy) : Types.Properties {
    switch(val){
      case(#Class(val)){
        Map.fromIter<Text, Property>(
          Map.entries(val)
        , Map.thash)};
      case(_){assert(false);/*unreachable*/Map.new<Text, Property>();};
    };
  };
  
  /// Convert `Candy` to `Properties`
  ///
  /// Example:
  /// ```motoko include=import
  ///  let val: Candy = #Class([
  ///    {
  ///      name = "prop1";
  ///      value = #Principal(Principal.fromText("abc"));
  ///      immutable = true;
  ///    },
  ///    {
  ///      name = "prop2";
  ///      value = #Principal(Principal.fromText("abc"));
  ///      immutable = false;
  ///    }
  ///  ]);
  ///  let props = Conversion.candyToProperties(val);
  /// ```
  /// Note: throws if the underlying value is not `#Class`.
  public func candySharedToProperties(val : CandyShared) : Types.PropertiesShared {
    switch(val){
      case(#Class(val)){
        val;
      };
      case(_){assert(false);/*unreachable*/[];};
    };
  };

  /// Convert `[Nat8]` to a `Text`
  ///
  /// Example:
  /// ```motoko include=import
  /// let bytes: [Nat8] = [140, 145, 190, 192];
  /// let bytes_as_text = Conversion.bytesToText(bytes);
  /// ```
  public func bytesToText(_bytes : [Nat8]) : Text{
    var result : Text = "";
    var aChar : [var Nat8] = [var 0, 0, 0, 0];

    for(thisChar in Iter.range(0,_bytes.size())){
      if(thisChar > 0 and thisChar % 4 == 0){
          aChar[0] := _bytes[thisChar-4];
          aChar[1] := _bytes[thisChar-3];
          aChar[2] := _bytes[thisChar-2];
          aChar[3] := _bytes[thisChar-1];
          result := result # Char.toText(Char.fromNat32(bytesToNat32(Array.freeze<Nat8>(aChar))));
      };
    };
    return result;
  };

  /// Convert `Principal` to Bytes(`[Nat8]`)
  ///
  /// Example:
  /// ```motoko include=import
  /// let p = Principal.fromText("xyz");
  /// let principal_as_bytes = Conversion.principalToBytes(p);
  /// ```
  public func principalToBytes(_principal: Principal) : [Nat8]{
    return Blob.toArray(Principal.toBlob(_principal));
  };

  /// Convert Bytes(`[Nat8]`) to `Principal`
  ///
  /// Example:
  /// ```motoko include=import
  /// let bytes: [Nat8] = [140, 145, 190, 192];
  /// let p = Conversion.bytesToPrincipal(bytes);
  /// ```
  public func bytesToPrincipal(_bytes: [Nat8]) : Principal{
    return Principal.fromBlob(Blob.fromArray(_bytes));
  };

  /// Convert `Principal` to Bytes(`[Nat8]`)
  ///
  /// Example:
  /// ```motoko include=import
  /// let b = false;
  /// let bool_as_bytes = Conversion.boolToBytes(b);
  /// ```
  public func boolToBytes(_bool : Bool) : [Nat8]{
    if(_bool == true){
      return [1:Nat8];
    } else {
      return [0:Nat8];
    };
  };

  /// Convert Bytes(`[Nat8]`) to `Bool`
  ///
  /// Example:
  /// ```motoko include=import
  /// let bytes: [Nat8] = [1:Nat8];
  /// let b = Conversion.bytesToBool(bytes); // true
  /// ```
  public func bytesToBool(_bytes : [Nat8]) : Bool{
    if(_bytes[0] == 0){
      return false;
    } else {
      return true;
    };
  };

  /// Convert `Int` to Bytes(`[Nat8]`)
  ///
  /// Example:
  /// ```motoko include=import
  /// let i = 266;
  /// let int_as_bytes = Conversion.intToBytes(b); // [0, 2, 10]
  /// ```
  public func intToBytes(n : Int) : [Nat8]{
    var a : Nat8 = 0;
    var c : Nat8 = if(n < 0){1}else{0};
    var b : Nat = Int.abs(n);
    var bytes = List.nil<Nat8>();
    var test = true;
    while test {
      a := Nat8.fromNat(b % 128);
      b := b / 128;
      bytes := List.push<Nat8>(a, bytes);
      test := b > 0;
    };
    let result = toBuffer<Nat8>([c]);
    result.append(toBuffer<Nat8>(List.toArray<Nat8>(bytes)));
    Buffer.toArray(result);
    //Array.append<Nat8>([c],List.toArray<Nat8>(bytes));
  };

  /// Convert Bytes(`[Nat8]`) to `Int`
  ///
  /// Example:
  /// ```motoko include=import
  /// let bytes: [Nat8] = [0, 2, 10];
  /// let b = Conversion.bytesToBool(bytes); // 266
  /// ```
  public func bytesToInt(_bytes : [Nat8]) : Int{
    var n : Int = 0;
    var i = 0;
    let natBytes = Array.tabulate<Nat8>(_bytes.size() - 2, func(idx){_bytes[idx+1]});

    Array.foldRight<Nat8, ()>(natBytes, (), func (byte, _) {
      n += Nat8.toNat(byte) * 128 ** i;
      i += 1;
      return;
    });
    if(_bytes[0]==1){
      n *= -1;
    };
    return n;
  };

  
  /// Unwrap an Option value.
  ///
  /// If the underlying value is a #Option(T), T is returned,
  /// Otherwise, the parameter is returned as it is.
  ///
  /// Example:
  /// ```motoko include=import
  /// let val: Candy = #Option(?#Principal(Principal.fromText("xyz")));
  /// let unwrapped_val = Conversion.unwrapOptionCandy(val);
  /// ```
  public func unwrapOptionCandy(val : Candy): Candy{
    switch(val){
      case(#Option(val)){
          switch(val){
              case(null){
                  return #Option(null);
              };
              case(?val){
                  return val;
              }
          };
      };
      case(_){val};
    };
  };

  /// Unwrap an Option value.
  ///
  /// If the underlying value is a #Option(T), T is returned,
  /// Otherwise, the parameter is returned as it is.
  ///
  /// Example:
  /// ```motoko include=import
  /// let val: CandyShared = #Option(?#Principal(Principal.fromText("xyz")));
  /// let unwrapped_val = Conversion.unwrapOptionCandy(val);
  /// ```
  public func unwrapOptionCandyShared(val : CandyShared): CandyShared{
    switch(val){
      case(#Option(val)){
          switch(val){
              case(null){
                  return #Option(null);
              };
              case(?val){
                  return val;
              }
          };
      };
      case(_){val};
    };
  };

  ///converts a candyshared value to the reduced set of ValueShared used in many places like ICRC3.  Some types not recoverable
  public func CandySharedToValue(x: CandyShared) : ValueShared {
    switch(x){
      case(#Text(x)) #Text(x);
      case(#Map(x)) {
        let buf = Buffer.Buffer<(Text, ValueShared)>(1);
        for(thisItem in x.vals()){
          buf.add((thisItem.0, CandySharedToValue(thisItem.1)));
        };
        #Map(Buffer.toArray(buf));
      };
      case(#Class(x)) {
        let buf = Buffer.Buffer<(Text, ValueShared)>(1);
        for(thisItem in x.vals()){
          buf.add((thisItem.name, CandySharedToValue(thisItem.value)));
        };
        #Map(Buffer.toArray(buf));
      };
      case(#Int(x)) #Int(x);
      case(#Int8(x)) #Int(Int8.toInt(x));
      case(#Int16(x)) #Int(Int16.toInt(x));
      case(#Int32(x)) #Int(Int32.toInt(x));
      case(#Int64(x)) #Int(Int64.toInt(x));
      case(#Ints(x)){
         #Array(Array.map<Int,ValueShared>(x, func(x: Int) : ValueShared { #Int(x)}));
      };
      case(#Nat(x)) #Nat(x);
      case(#Nat8(x)) #Nat(Nat8.toNat(x));
      case(#Nat16(x)) #Nat(Nat16.toNat(x));
      case(#Nat32(x)) #Nat(Nat32.toNat(x));
      case(#Nat64(x)) #Nat(Nat64.toNat(x));
      case(#Nats(x)){
         #Array(Array.map<Nat,ValueShared>(x, func(x: Nat) : ValueShared { #Nat(x)}));
      };
      case(#Bytes(x)){
         #Blob(Blob.fromArray(x));
      };
      case(#Array(x)) {
        #Array(Array.map<CandyShared, ValueShared>(x, CandySharedToValue));
      };
      case(#Blob(x)) #Blob(x);
      case(#Bool(x)) #Blob(Blob.fromArray([if(x==true){1 : Nat8} else {0: Nat8}]));
      case(#Float(x)){#Text(Float.format(#exact, x))};
      case(#Floats(x)){
        #Array(Array.map<Float,ValueShared>(x, func(x: Float) : ValueShared { CandySharedToValue(#Float(x))}));
      };
      case(#Option(x)){ //empty array is null
        switch(x){
          case(null) #Array([]);
          case(?x) #Array([CandySharedToValue(x)]);
        };
      };
      case(#Principal(x)){
        #Blob(Principal.toBlob(x));
      };
      case(#Set(x)) {
        #Array(Array.map<CandyShared,ValueShared>(x, func(x: CandyShared) : ValueShared { CandySharedToValue(x)}));
      };
      case(#ValueMap(x)) {
        #Array(Array.map<(CandyShared,CandyShared),ValueShared>(x, func(x: (CandyShared,CandyShared)) : ValueShared { #Array([CandySharedToValue(x.0), CandySharedToValue(x.1)])}));
      };
      //case(_){assert(false);/*unreachable*/#Nat(0);};
    };

    
  };

  ///converts a candy value to the reduced set of ValueShared used in many places like ICRC3.  Some types not recoverable
  public func CandyToValue(x: Candy) : ValueShared {
    switch(x){
      case(#Text(x)) #Text(x);
      case(#Map(x)) {
        let buf = Buffer.Buffer<(Text, ValueShared)>(1);
        for(thisItem in Map.entries(x)){
          buf.add((thisItem.0, CandyToValue(thisItem.1)));
        };
        #Map(Buffer.toArray(buf));
      };
      case(#Class(x)) {
        let buf = Buffer.Buffer<(Text, ValueShared)>(1);
        for(thisItem in Map.entries(x)){
          buf.add((thisItem.1.name, CandyToValue(thisItem.1.value)));
        };
        #Map(Buffer.toArray(buf));
      };
      case(#Int(x)) #Int(x);
      case(#Int8(x)) #Int(Int8.toInt(x));
      case(#Int16(x)) #Int(Int16.toInt(x));
      case(#Int32(x)) #Int(Int32.toInt(x));
      case(#Int64(x)) #Int(Int64.toInt(x));
      case(#Ints(x)){
         #Array(StableBuffer.toArray<ValueShared>(StableBuffer.map<Int,ValueShared>(x, func(x: Int) : ValueShared { #Int(x)})));
      };
      case(#Nat(x)) #Nat(x);
      case(#Nat8(x)) #Nat(Nat8.toNat(x));
      case(#Nat16(x)) #Nat(Nat16.toNat(x));
      case(#Nat32(x)) #Nat(Nat32.toNat(x));
      case(#Nat64(x)) #Nat(Nat64.toNat(x));
      case(#Nats(x)){
          #Array(StableBuffer.toArray<ValueShared>(StableBuffer.map<Nat,ValueShared>(x, func(x: Nat) : ValueShared { #Nat(x)})));
      };
      case(#Bytes(x)){
         #Blob(Blob.fromArray(StableBuffer.toArray<Nat8>(x)));
      };
      case(#Array(x)) {
        #Array(StableBuffer.toArray<ValueShared>(StableBuffer.map<Candy, ValueShared>(x, CandyToValue)));
      };
      case(#Blob(x)) #Blob(x);
      case(#Bool(x)) #Blob(Blob.fromArray([if(x==true){1 : Nat8} else {0: Nat8}]));
      case(#Float(x)){#Text(Float.format(#exact, x))};
      case(#Floats(x)){
        #Array(StableBuffer.toArray<ValueShared>(StableBuffer.map<Float,ValueShared>(x, func(x: Float) : ValueShared { CandyToValue(#Float(x))})));
      };
      case(#Option(x)){ //empty array is null
        switch(x){
          case(null) #Array([]);
          case(?x) #Array([CandyToValue(x)]);
        };
      };
      case(#Principal(x)){
        #Blob(Principal.toBlob(x));
      };
      case(#Set(x)) {
        #Array(Iter.toArray<ValueShared>(Iter.map<Candy,ValueShared>(Set.keys(x), func(x: Candy) : ValueShared { CandyToValue(x)})));
      };
      case(#ValueMap(x)) {
        #Array(Iter.toArray<ValueShared>(Iter.map<(Candy,Candy),ValueShared>(Map.entries(x), func(x: (Candy,Candy)) : ValueShared { #Array([CandyToValue(x.0), CandyToValue(x.1)])})));
      };
      //case(_){assert(false);/*unreachable*/#Nat(0);};
    };

    
  };
}
