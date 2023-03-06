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
import Hex "hex";
import Properties "properties";
import StableBuffer "mo:stable_buffer/StableBuffer";


module {

  type CandyValue = Types.CandyValue;
  type CandyValueShared = Types.CandyValueShared;
  type DataZone = Types.DataZone;
  type Property = Types.Property;
  type PropertyShared = Types.PropertyShared;


  //todo: generic accesors

  /// Convert a `CandyValue` to `Nat`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValue = #Int16(15);
  /// let converted_value = Conversion.valueToNat(value);
  /// ```
  /// Note: Throws if the underlying value overflows or is negative.
  public func valueToNat(val : CandyValue) : Nat {
    switch(val){
    case(#Nat(val)){ val};
    case(#Nat8(val)){ Nat8.toNat(val)};
    case(#Nat16(val)){ Nat16.toNat(val)};
    case(#Nat32(val)){ Nat32.toNat(val)};
    case(#Nat64(val)){ Nat64.toNat(val)};
    case(#Float(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat(#Int(Float.toInt(Float.nearest(val))))};
    case(#Int(val)){
      if(val < 0){assert false;};//will throw on negative
      
      Int.abs(val)};
    case(#Int8(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
    case(#Int16(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
    case(#Int32(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
    case(#Int64(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
    case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValue` to `Nat8`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValue = #Int8(2);
  /// let converted_value = Conversion.valueToNat8(value);
  /// ```
  /// Note: Throws if the underlying value overflows or is negative.
  public func valueToNat8(val : CandyValue) : Nat8 {
    switch(val){
    case(#Nat8(val)){ val};
    case(#Nat(val)){ Nat8.fromNat(val)};//will throw on overflow
    case(#Nat16(val)){ Nat8.fromNat(Nat16.toNat(val))};//will throw on overflow
    case(#Nat32(val)){ Nat8.fromNat(Nat32.toNat(val))};//will throw on overflow
    case(#Nat64(val)){ Nat8.fromNat(Nat64.toNat(val))};//will throw on overflow
    case(#Float(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat8(#Int(Float.toInt(Float.nearest(val))))};
    case(#Int(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat8(#Nat(Int.abs(val)))};
    case(#Int8(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat8(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
    case(#Int16(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat8(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
    case(#Int32(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat8(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
    case(#Int64(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat8(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
    case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValue` to `Nat16`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValue = #Int8(2);
  /// let converted_value = Conversion.valueToNat16(value);
  /// ```
  /// Note: Throws if the underlying value overflows or is negative.
  public func valueToNat16(val : CandyValue) : Nat16 {
    switch(val){
    case(#Nat16(val)){ val};
    case(#Nat8(val)){Nat16.fromNat(Nat8.toNat(val))};
    case(#Nat(val)){Nat16.fromNat(val)};//will throw on overflow
    case(#Nat32(val)){Nat16.fromNat(Nat32.toNat(val))};//will throw on overflow
    case(#Nat64(val)){Nat16.fromNat(Nat64.toNat(val))};//will throw on overflow
    case(#Float(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat16(#Int(Float.toInt(Float.nearest(val))))};
    case(#Int(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat16(#Nat(Int.abs(val)))};
    case(#Int8(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat16(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
    case(#Int16(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat16(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
    case(#Int32(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat16(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
    case(#Int64(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat16(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
    case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValue` to `Nat32`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValue = #Int8(2);
  /// let converted_value = Conversion.valueToNat32(value);
  /// ```
  /// Note: Throws if the underlying value overflows or is negative.
  public func valueToNat32(val : CandyValue) : Nat32 {
    switch(val){
    case(#Nat32(val)){ val};
    case(#Nat16(val)){ Nat32.fromNat(Nat16.toNat(val))};
    case(#Nat8(val)){ Nat32.fromNat(Nat8.toNat(val))};
    case(#Nat(val)){ Nat32.fromNat(val)};//will throw on overflow
    case(#Float(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat32(#Int(Float.toInt(Float.nearest(val))))};
    case(#Int(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat32(#Nat(Int.abs(val)))};
    case(#Int8(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat32(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
    case(#Int16(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat32(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
    case(#Int32(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat32(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
    case(#Int64(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat32(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
    case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValue` to `Nat64`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValue = #Int8(2);
  /// let converted_value = Conversion.valueToNat64(value);
  /// ```
  /// Note: Throws if the underlying value overflows or is negative.
  public func valueToNat64(val : CandyValue) : Nat64 {
    switch(val){
    case(#Nat64(val)){ val};
    case(#Nat32(val)){ Nat64.fromNat(Nat32.toNat(val))};
    case(#Nat16(val)){ Nat64.fromNat(Nat16.toNat(val))};
    case(#Nat8(val)){ Nat64.fromNat(Nat8.toNat(val))};
    case(#Nat(val)){ Nat64.fromNat(val)};
    case(#Float(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat64(#Int(Float.toInt(Float.nearest(val))))};
    case(#Int(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat64(#Nat(Int.abs(val)))};
    case(#Int8(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat64(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
    case(#Int16(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat64(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
    case(#Int32(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat64(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
    case(#Int64(val)){
      if(val < 0){assert false;};//will throw on negative
      valueToNat64(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
    case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValue` to `Int`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValue = #Int8(2);
  /// let converted_value = Conversion.valueToInt(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func valueToInt(val : CandyValue) : Int {
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

  /// Convert a `CandyValue` to `Int8`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValue = #Int8(2);
  /// let converted_value = Conversion.valueToInt8(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func valueToInt8(val : CandyValue) : Int8 {
    switch(val){
      case(#Int8(val)){val};
      case(#Int(val)){ Int8.fromInt(val)};//will throw on overflow
      case(#Int16(val)){ Int8.fromInt(Int16.toInt(val))};//will throw on overflow
      case(#Int32(val)){ Int8.fromInt(Int32.toInt(val))};//will throw on overflow
      case(#Int64(val)){ Int8.fromInt(Int64.toInt(val))};//will throw on overflow
      case(#Nat8(val)){ Int8.fromNat8(val)};
      case(#Nat(val)){Int8.fromNat8(valueToNat8(#Nat(val)))};//will throw on overflow
      case(#Nat16(val)){Int8.fromNat8(valueToNat8(#Nat16(val)))};//will throw on overflow
      case(#Nat32(val)){Int8.fromNat8(valueToNat8(#Nat32(val)))};//will throw on overflow
      case(#Nat64(val)){Int8.fromNat8(valueToNat8(#Nat64(val)))};//will throw on overflow
      case(#Float(val)){ Int8.fromInt(Float.toInt(Float.nearest(val)))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValue` to `Int16`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValue = #Int8(2);
  /// let converted_value = Conversion.valueToInt16(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func valueToInt16(val : CandyValue) : Int16 {
    switch(val){
      case(#Int16(val)){ val};
      case(#Int8(val)){ Int16.fromInt(Int8.toInt(val))};
      case(#Int(val)){ Int16.fromInt(val)};//will throw on overflow
      case(#Int32(val)){ Int16.fromInt(Int32.toInt(val))};//will throw on overflow
      case(#Int64(val)){ Int16.fromInt(Int64.toInt(val))};//will throw on overflow
      case(#Nat8(val)){Int16.fromNat16(valueToNat16(#Nat8(val)))};
      case(#Nat(val)){Int16.fromNat16(valueToNat16(#Nat(val)))};//will throw on overflow
      case(#Nat16(val)){ Int16.fromNat16(val)};
      case(#Nat32(val)){Int16.fromNat16(valueToNat16(#Nat32(val)))};//will throw on overflow
      case(#Nat64(val)){Int16.fromNat16(valueToNat16(#Nat64(val)))};//will throw on overflow
      case(#Float(val)){ Int16.fromInt(Float.toInt(Float.nearest(val)))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValue` to `Int32`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValue = #Int8(2);
  /// let converted_value = Conversion.valueToInt32(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func valueToInt32(val : CandyValue) : Int32 {
    switch(val){
      case(#Int32(val)){val};
      case(#Int16(val)){Int32.fromInt(Int16.toInt(val))};
      case(#Int8(val)){Int32.fromInt(Int8.toInt(val))};
      case(#Int(val)){Int32.fromInt(val)};//will throw on overflow
      case(#Nat8(val)){Int32.fromNat32(valueToNat32(#Nat8(val)))};
      case(#Nat(val)){Int32.fromNat32(valueToNat32(#Nat(val)))};//will throw on overflow
      case(#Nat16(val)){Int32.fromNat32(valueToNat32(#Nat16(val)))};
      case(#Nat32(val)){Int32.fromNat32(val)};
      case(#Nat64(val)){Int32.fromNat32(valueToNat32(#Nat64(val)))};//will throw on overflow
      case(#Float(val)){Int32.fromInt(Float.toInt(Float.nearest(val)))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValue` to `Int64`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValue = #Int8(2);
  /// let converted_value = Conversion.valueToInt64(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func valueToInt64(val : CandyValue) : Int64 {
    switch(val){
      case(#Int64(val)){ val};
      case(#Int32(val)){ Int64.fromInt(Int32.toInt(val))};
      case(#Int16(val)){ Int64.fromInt(Int16.toInt(val))};
      case(#Int8(val)){ Int64.fromInt(Int8.toInt(val))};
      case(#Int(val)){ Int64.fromInt(val)};//will throw on overflow
      case(#Nat8(val)){Int64.fromNat64(valueToNat64(#Nat8(val)))};
      case(#Nat(val)){Int64.fromNat64(valueToNat64(#Nat(val)))};//will throw on overflow
      case(#Nat16(val)){Int64.fromNat64(valueToNat64(#Nat16(val)))};
      case(#Nat32(val)){Int64.fromNat64(valueToNat64(#Nat32(val)))};//will throw on overflow
      case(#Nat64(val)){ Int64.fromNat64(val)};
      case(#Float(val)){ Float.toInt64(Float.nearest(val))};
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValue` to `Float`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValue = #Int16(2);
  /// let converted_value = Conversion.valueToFloat(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func valueToFloat(val : CandyValue) : Float {
    switch(val){
      case(#Float(val)){ val};
      case(#Int64(val)){ Float.fromInt64(val)};
      case(#Int32(val)){valueToFloat(#Int(Int32.toInt(val)))};
      case(#Int16(val)){valueToFloat(#Int(Int16.toInt(val)))};
      case(#Int8(val)){valueToFloat(#Int(Int8.toInt(val)))};
      case(#Int(val)){ Float.fromInt(val)};
      case(#Nat8(val)){valueToFloat(#Int(Nat8.toNat(val)))};
      case(#Nat(val)){valueToFloat(#Int(val))};//will throw on overflow
      case(#Nat16(val)){valueToFloat(#Int(Nat16.toNat(val)))};
      case(#Nat32(val)){valueToFloat(#Int(Nat32.toNat(val)))};//will throw on overflow
      case(#Nat64(val)){valueToFloat(#Int(Nat64.toNat(val)))};
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValue` to `Text`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValue = #Int8(2);
  /// let converted_value = Conversion.valueToText(value);
  /// ```
  public func valueToText(val : CandyValue) : Text {
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
          case(?val){valueToText(val)};
        };
      };
      //blob
      case(#Blob(val)){
          valueToText(#Bytes(Blob.toArray(val)));
      };
      //class
      case(#Class(val)){ //this is currently not parseable and should probably just be used for debuging. It would be nice to output candid.

        var t = "{";
        for(thisItem in val.vals()){
          t := t # thisItem.name # ":" # (if(thisItem.immutable == false){"var "}else{""}) # valueToText(thisItem.value) # "; ";
        };
        
        return Text.trimEnd(t, #text(" ")) # "}";


      };
      //principal
      case(#Principal(val)){ Principal.toText(val)};
      //array
      case(#Array(val)){
      
          var t = "[";
          for(thisItem in val.vals()){
            t := t # "{" # valueToText(thisItem) # "} ";
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
      //bytes
      case(#Bytes(val)){
       
      return Hex.encode(val);
         
      };
      case(_){assert(false);/*unreachable*/"";};
    };
  };

  /// Convert a `CandyValue` to `Principal`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValue = #Principal(Principal.fromText("abc"));
  /// let converted_value = Conversion.valueToPrincipal(value);
  /// ```
  /// Note: Throws if the underlying value is not a `#Principal`.
  public func valueToPrincipal(val : CandyValue) : Principal {
   
    switch(val){
      case(#Principal(val)){val};
      case(_){assert(false);/*unreachable*/Principal.fromText("");};
    };
  };

  /// Convert a `CandyValue` to `Bool`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValue = #Bool(false);
  /// let converted_value = Conversion.valueToPBool(value);
  /// ```
  /// Note: Throws if the underlying value is not a `#Bool`.
  public func valueToBool(val : CandyValue) : Bool {
    
    switch(val){
      case(#Bool(val)){val};
      case(_){assert(false);/*unreachable*/false;};
    };
  };

  /// Convert a `CandyValue` to `Blob`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValue = #Principal(Principal.fromText("abc"));
  /// let converted_value = Conversion.valueToBlob(value);
  /// ```
  public func valueToBlob(val : CandyValue) : Blob {

    switch(val){
      case(#Blob(val)){val};
      case(#Bytes(val)){Blob.fromArray(val)};
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

  /// Convert a `CandyValue` to `[CandyValue]`
  ///
  /// The conversion is done by getting the array of candy values of the #Array.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValue = #Array([1, 2, 3]);
  /// let converted_value = Conversion.valueToValueArray(value);
  /// ```
  /// Note: Throws if the underlying value is not an `#Array`.
  public func valueToValueArray(val : CandyValue) : [CandyValue] {

    switch(val){
      case(#Array(val)){val};
      //todo: could add all conversions here
      case(_){assert(false);/*unreachable*/[];};
    };
  };

  /// Convert a `CandyValueShared` to `Nat`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Int16(15);
  /// let converted_value = Conversion.valueSharedToNat(value);
  /// ```
  /// Note: Throws if the underlying value overflows or is negative.
  public func valueSharedToNat(val : CandyValueShared) : Nat {

    switch(val){
      case(#Nat(val)){ val};
      case(#Nat8(val)){ Nat8.toNat(val)};
      case(#Nat16(val)){ Nat16.toNat(val)};
      case(#Nat32(val)){Nat32.toNat(val)};
      case(#Nat64(val)){ Nat64.toNat(val)};
      case(#Float(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat(#Int(Float.toInt(Float.nearest(val))))};
      case(#Int(val)){
          if(val < 0){assert false;};//will throw on negative
          
          Int.abs(val)};
      case(#Int8(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
      case(#Int16(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
      case(#Int32(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
      case(#Int64(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValueShared` to `Nat8`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Int8(15);
  /// let converted_value = Conversion.valueSharedToNat8(value);
  /// ```
  /// Note: Throws if the underlying value overflows or is negative.
  public func valueSharedToNat8(val : CandyValueShared) : Nat8 {

    switch(val){
      case(#Nat8(val)){ val};
      case(#Nat(val)){ Nat8.fromNat(val)};//will throw on overflow
      case(#Nat16(val)){ Nat8.fromNat(Nat16.toNat(val))};//will throw on overflow
      case(#Nat32(val)){ Nat8.fromNat(Nat32.toNat(val))};//will throw on overflow
      case(#Nat64(val)){ Nat8.fromNat(Nat64.toNat(val))};//will throw on overflow
      case(#Float(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat8(#Int(Float.toInt(Float.nearest(val))))};
      case(#Int(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat8(#Nat(Int.abs(val)))};
      case(#Int8(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat8(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
      case(#Int16(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat8(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
      case(#Int32(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat8(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
      case(#Int64(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat8(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValueShared` to `Nat16`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Int16(15);
  /// let converted_value = Conversion.valueSharedToNat16(value);
  /// ```
  /// Note: Throws if the underlying value overflows or is negative.
  public func valueSharedToNat16(val : CandyValueShared) : Nat16 {

    switch(val){
      case(#Nat16(val)){ val};
      case(#Nat8(val)){ Nat16.fromNat(Nat8.toNat(val))};
      case(#Nat(val)){ Nat16.fromNat(val)};//will throw on overflow
      case(#Nat32(val)){ Nat16.fromNat(Nat32.toNat(val))};//will throw on overflow
      case(#Nat64(val)){ Nat16.fromNat(Nat64.toNat(val))};//will throw on overflow
      case(#Float(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat16(#Int(Float.toInt(Float.nearest(val))))};
      case(#Int(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat16(#Nat(Int.abs(val)))};
      case(#Int8(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat16(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
      case(#Int16(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat16(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
      case(#Int32(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat16(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
      case(#Int64(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat16(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValueShared` to `Nat32`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Int32(15);
  /// let converted_value = Conversion.valueSharedToNat(value);
  /// ```
  /// Note: Throws if the underlying value overflows or is negative.
  public func valueSharedToNat32(val : CandyValueShared) : Nat32 {

    switch(val){
      case(#Nat32(val)){val};
      case(#Nat16(val)){Nat32.fromNat(Nat16.toNat(val))};
      case(#Nat8(val)){ Nat32.fromNat(Nat8.toNat(val))};
      case(#Nat(val)){ Nat32.fromNat(val)};//will throw on overflow
      case(#Float(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat32(#Int(Float.toInt(Float.nearest(val))))};
      case(#Int(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat32(#Nat(Int.abs(val)))};
      case(#Int8(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat32(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
      case(#Int16(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat32(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
      case(#Int32(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat32(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
      case(#Int64(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat32(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValueShared` to `Nat64`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Int16(15);
  /// let converted_value = Conversion.valueSharedToNat64(value);
  /// ```
  /// Note: Throws if the underlying value is negative.
  public func valueSharedToNat64(val : CandyValueShared) : Nat64 {

    switch(val){
      case(#Nat64(val)){ val};
      case(#Nat32(val)){ Nat64.fromNat(Nat32.toNat(val))};
      case(#Nat16(val)){ Nat64.fromNat(Nat16.toNat(val))};
      case(#Nat8(val)){ Nat64.fromNat(Nat8.toNat(val))};
      case(#Nat(val)){ Nat64.fromNat(val)};
      case(#Float(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat64(#Int(Float.toInt(Float.nearest(val))))};
      case(#Int(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat64(#Nat(Int.abs(val)))};
      case(#Int8(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat64(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
      case(#Int16(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat64(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
      case(#Int32(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat64(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
      case(#Int64(val)){
          if(val < 0){assert false;};//will throw on negative
          valueSharedToNat64(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValueShared` to `Int`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Int16(15);
  /// let converted_value = Conversion.valueSharedToInt(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func valueSharedToInt(val : CandyValueShared) : Int {

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

  /// Convert a `CandyValueShared` to `Int8`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Nat8(11);
  /// let converted_value = Conversion.valueSharedToInt8(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func valueSharedToInt8(val : CandyValueShared) : Int8 {

    switch(val){
      case(#Int8(val)){ val};
      case(#Int(val)){ Int8.fromInt(val)};//will throw on overflow
      case(#Int16(val)){ Int8.fromInt(Int16.toInt(val))};//will throw on overflow
      case(#Int32(val)){ Int8.fromInt(Int32.toInt(val))};//will throw on overflow
      case(#Int64(val)){ Int8.fromInt(Int64.toInt(val))};//will throw on overflow
      case(#Nat8(val)){ Int8.fromNat8(val)};
      case(#Nat(val)){Int8.fromNat8(valueSharedToNat8(#Nat(val)))};//will throw on overflow
      case(#Nat16(val)){Int8.fromNat8(valueSharedToNat8(#Nat16(val)))};//will throw on overflow
      case(#Nat32(val)){Int8.fromNat8(valueSharedToNat8(#Nat32(val)))};//will throw on overflow
      case(#Nat64(val)){Int8.fromNat8(valueSharedToNat8(#Nat64(val)))};//will throw on overflow
      case(#Float(val)){ Int8.fromInt(Float.toInt(Float.nearest(val)))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValueShared` to `Int16`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Float(10);
  /// let converted_value = Conversion.valueSharedToInt16(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func valueSharedToInt16(val : CandyValueShared) : Int16 {

    switch(val){
      case(#Int16(val)){ val};
      case(#Int8(val)){ Int16.fromInt(Int8.toInt(val))};
      case(#Int(val)){ Int16.fromInt(val)};//will throw on overflow
      case(#Int32(val)){ Int16.fromInt(Int32.toInt(val))};//will throw on overflow
      case(#Int64(val)){ Int16.fromInt(Int64.toInt(val))};//will throw on overflow
      case(#Nat8(val)){Int16.fromNat16(valueSharedToNat16(#Nat8(val)))};
      case(#Nat(val)){Int16.fromNat16(valueSharedToNat16(#Nat(val)))};//will throw on overflow
      case(#Nat16(val)){ Int16.fromNat16(val)};
      case(#Nat32(val)){Int16.fromNat16(valueSharedToNat16(#Nat32(val)))};//will throw on overflow
      case(#Nat64(val)){Int16.fromNat16(valueSharedToNat16(#Nat64(val)))};//will throw on overflow
      case(#Float(val)){ Int16.fromInt(Float.toInt(Float.nearest(val)))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValueShared` to `Int32`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Nat32(1111);
  /// let converted_value = Conversion.valueSharedToInt32(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func valueSharedToInt32(val : CandyValueShared) : Int32 {
    switch(val){
      case(#Int32(val)){ val};
      case(#Int16(val)){ Int32.fromInt(Int16.toInt(val))};
      case(#Int8(val)){ Int32.fromInt(Int8.toInt(val))};
      case(#Int(val)){ Int32.fromInt(val)};//will throw on overflow
      case(#Nat8(val)){Int32.fromNat32(valueSharedToNat32(#Nat8(val)))};
      case(#Nat(val)){Int32.fromNat32(valueSharedToNat32(#Nat(val)))};//will throw on overflow
      case(#Nat16(val)){Int32.fromNat32(valueSharedToNat32(#Nat16(val)))};
      case(#Nat32(val)){ Int32.fromNat32(val)};
      case(#Nat64(val)){Int32.fromNat32(valueSharedToNat32(#Nat64(val)))};//will throw on overflow
      case(#Float(val)){ Int32.fromInt(Float.toInt(Float.nearest(val)))};//will throw on overflow
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValueShared` to `Int64`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Nat64(12345);
  /// let converted_value = Conversion.valueSharedToInt64(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func valueSharedToInt64(val : CandyValueShared) : Int64 {
    switch(val){
      case(#Int64(val)){ val};
      case(#Int32(val)){ Int64.fromInt(Int32.toInt(val))};
      case(#Int16(val)){ Int64.fromInt(Int16.toInt(val))};
      case(#Int8(val)){ Int64.fromInt(Int8.toInt(val))};
      case(#Int(val)){ Int64.fromInt(val)};//will throw on overflow
      case(#Nat8(val)){Int64.fromNat64(valueSharedToNat64(#Nat8(val)))};
      case(#Nat(val)){Int64.fromNat64(valueSharedToNat64(#Nat(val)))};//will throw on overflow
      case(#Nat16(val)){Int64.fromNat64(valueSharedToNat64(#Nat16(val)))};
      case(#Nat32(val)){Int64.fromNat64(valueSharedToNat64(#Nat32(val)))};//will throw on overflow
      case(#Nat64(val)){ Int64.fromNat64(val)};
      case(#Float(val)){ Float.toInt64(Float.nearest(val))};
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValueShared` to `Float`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Int16(11);
  /// let converted_value = Conversion.valueSharedToFloat(value);
  /// ```
  /// Note: Throws if the underlying value overflows.
  public func valueSharedToFloat(val : CandyValueShared) : Float {
    switch(val){
      case(#Float(val)){ val};
      case(#Int64(val)){ Float.fromInt64(val)};
      case(#Int32(val)){valueSharedToFloat(#Int(Int32.toInt(val)))};
      case(#Int16(val)){valueSharedToFloat(#Int(Int16.toInt(val)))};
      case(#Int8(val)){valueSharedToFloat(#Int(Int8.toInt(val)))};
      case(#Int(val)){ Float.fromInt(val)};
      case(#Nat8(val)){valueSharedToFloat(#Int(Nat8.toNat(val)))};
      case(#Nat(val)){valueSharedToFloat(#Int(val))};//will throw on overflow
      case(#Nat16(val)){valueSharedToFloat(#Int(Nat16.toNat(val)))};
      case(#Nat32(val)){valueSharedToFloat(#Int(Nat32.toNat(val)))};//will throw on overflow
      case(#Nat64(val)){valueSharedToFloat(#Int(Nat64.toNat(val)))};
      case(_){assert(false);/*unreachable*/0;};
    };
  };

  /// Convert a `CandyValueShared` to `Text`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Float(11);
  /// let converted_value = Conversion.valueSharedToText(value);
  /// ```
  public func valueSharedToText(val : CandyValueShared) : Text {
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
              case(?val){valueSharedToText(val)};
          };
      };
      //blob
      case(#Blob(val)){
          valueToText(#Bytes(Blob.toArray(val)));
      };
      //class
      case(#Class(val)){ //this is currently not parseable and should probably just be used for debuging. It would be nice to output candid.

          var t = "{";
          for(thisItem in val.vals()){
              t := t # thisItem.name # ":" # (if(thisItem.immutable == false){"var "}else{""}) # valueSharedToText(thisItem.value) # "; ";
          };
          
          return Text.trimEnd(t, #text(" ")) # "}";


      };
      //principal
      case(#Principal(val)){ Principal.toText(val)};
      //array
      case(#Array(val)){

        var t = "[";
        for(thisItem in StableBuffer.vals(val)){
            t := t # "{" # valueSharedToText(thisItem) # "} ";
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
      //bytes
      case(#Bytes(val)){
         
        return Hex.encode(StableBuffer.toArray(val));
            
      };
      case(_){assert(false);/*unreachable*/"";};
    };
  };

  /// Convert a `CandyValueShared` to `Principal`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Principal(Principal.fromText("abc"));
  /// let converted_value = Conversion.valueSharedToPrincipal(value);
  /// ```
  /// Note: Throws if the underlying value is not a `#Principal`.
  public func valueSharedToPrincipal(val : CandyValueShared) : Principal {
    switch(val){
      case(#Principal(val)){ val};
      case(_){assert(false);/*unreachable*/Principal.fromText("");};
    };
  };

  /// Convert a `CandyValueShared` to `Principal`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Bool(true);
  /// let converted_value = Conversion.valueSharedToPrincipal(value);
  /// ```
  /// Note: Throws if the underlying value is not a `#Bool`.
  public func valueSharedToBool(val : CandyValueShared) : Bool {
    switch(val){
      case(#Bool(val)){ val};
      case(_){assert(false);/*unreachable*/false;};
    };
  };

  /// Convert a `CandyValueShared` to `Blob`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Principal(Principal.fromText("abc"));
  /// let converted_value = Conversion.valueSharedToBlob(value);
  /// ```
  public func valueSharedToBlob(val : CandyValueShared) : Blob {
    switch(val){

      case(#Blob(val)){ val};
      case(#Bytes(val)){
          
          Blob.fromArray(StableBuffer.toArray(val));
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

  /// Convert a `CandyValueShared` to `[CandyValueShared]`
  ///
  /// The conversion is done by getting the array of candy values of the #Array.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Array([1, 2, 3]);
  /// let converted_value = Conversion.valueSharedToValueArray(value);
  /// ```
  /// Note: Throws if the underlying value is not an `#Array`.
  public func valueSharedToValueArray(val : CandyValueShared) : [CandyValueShared] {

    switch(val){
      case(#Array(val)){StableBuffer.toArray(val)};
      //todo: could add all conversions here
      case(_){assert(false);/*unreachable*/[];};
    };
  };

  /// Convert a `CandyValue` to Bytes(`[Nat8]`)
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValue = #Principal(Principal.fromText("abc"));
  /// let value_as_bytes = Conversion.valueToBytes(value);
  /// ```
  public func valueToBytes(val : CandyValue) : [Nat8]{
    switch(val){
      case(#Int(val)){intToBytes(val)};
      case(#Int8(val)){valueToBytes(#Int(valueToInt(#Int8(val))))};
      case(#Int16(val)){valueToBytes(#Int(valueToInt(#Int16(val))))};
      case(#Int32(val)){valueToBytes(#Int(valueToInt(#Int32(val))))};
      case(#Int64(val)){valueToBytes(#Int(valueToInt(#Int64(val))))};
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
      case(#Bytes(val)){val};
      case(#Floats(val)){Prelude.nyi()};
      case(#Nats(val)){Prelude.nyi()};
      case(#Map(val)){Prelude.nyi()};
      case(#Set(val)){Prelude.nyi()};
    }
  };

  /// Convert a `CandyValueShared` to Bytes(`[Nat8]`)
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Principal(Principal.fromText("abc"));
  /// let value_as_bytes = Conversion.valueSharedToBytes(value);
  /// ```
  public func valueSharedToBytes(val : CandyValueShared) : [Nat8]{
    switch(val){
      case(#Int(val)){intToBytes(val)};
      case(#Int8(val)){valueSharedToBytes(#Int(valueSharedToInt(#Int8(val))))};
      case(#Int16(val)){valueSharedToBytes(#Int(valueSharedToInt(#Int16(val))))};
      case(#Int32(val)){valueSharedToBytes(#Int(valueSharedToInt(#Int32(val))))};
      case(#Int64(val)){valueSharedToBytes(#Int(valueSharedToInt(#Int64(val))))};
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
      case(#Bytes(val)){StableBuffer.toArray(val)};
      case(#Floats(val)){Prelude.nyi()};
      case(#Nats(val)){Prelude.nyi()};
      case(#Map(val)){Prelude.nyi()};
      case(#Set(val)){Prelude.nyi()};
    }
  };

  /// Convert a `CandyValueShared` to `Buffer<Nat8>`
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Principal(Principal.fromText("abc"));
  /// let value_as_buffer = Conversion.valueSharedToBytes(value);
  /// ```
  ///
  /// Note: Throws if the underlying value isn't convertible.
  public func valueSharedToBytesBuffer(val : CandyValueShared) : Buffer.Buffer<Nat8>{
    switch (val){
      case(#Bytes(val)){toBuffer(StableBuffer.toArray(val))};
      case(_){
          toBuffer<Nat8>(valueSharedToBytes(val));//may throw for uncovertable types
      };
    };
  };

  /// Convert a `CandyValueShared` to `Buffer<Float>`
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Nat(102);
  /// let value_as_floats_buffer = Conversion.valueSharedToFloatsBuffer(value);
  /// ```
  /// Note: Throws if the underlying value isn't convertible.
  public func valueSharedToFloatsBuffer(val : CandyValueShared) : Buffer.Buffer<Float>{
    switch (val){
      case(#Floats(val)){
          
                  toBuffer(StableBuffer.toArray(val));
      };
      case(_){
          toBuffer([valueSharedToFloat(val)]); //may throw for unconvertable types
      };
    };
  };

  /// Convert a `CandyValueShared` to `Buffer<Nat>`
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyValueShared = #Nat(102);
  /// let value_as_nats_buffer = Conversion.valueSharedToNatsBuffer(value);
  /// ```
  /// Note: Throws if the underlying value isn't convertible.
  public func valueSharedToNatsBuffer(val : CandyValueShared) : Buffer.Buffer<Nat>{
    switch (val){
      case(#Nats(val)){
          
                  toBuffer(StableBuffer.toArray(val));
      };
      case(_){
          toBuffer([valueSharedToNat(val)]); //may throw for unconvertable types
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

  //////////////////////////////////////////////////////////////////////
  // The following functions convert standard types to Byte arrays
  // From there you can easily get to blobs if necessary with the Blob package
  //////////////////////////////////////////////////////////////////////

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
  public func propertyToText(a:Types.Property):Text{valueToText(a.value)};

  /// Convert `CandyValue` to `Properties`
  ///
  /// Example:
  /// ```motoko include=import
  ///  let val: CandyValue = #Class([
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
  ///  let props = Conversion.valueToProperties(val);
  /// ```
  /// Note: throws if the underlying value is not `#Class`.
  public func valueToProperties(val : CandyValue) : Types.Properties {
    switch(val){
      case(#Class(val)){ val};
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
  /// let val: CandyValue = #Option(?#Principal(Principal.fromText("xyz")));
  /// let unwrapped_val = Conversion.unwrapOptionValue(val);
  /// ```
  public func unwrapOptionValue(val : CandyValue): CandyValue{
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
  /// let val: CandyValueShared = #Option(?#Principal(Principal.fromText("xyz")));
  /// let unwrapped_val = Conversion.unwrapOptionValue(val);
  /// ```
  public func unwrapOptionValueShared(val : CandyValueShared): CandyValueShared{
    
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

}