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
import Result "mo:base/Result";
import List "mo:base/List";
import Types "../types";
import Hex "mo:encoding_0_4_1/Hex";
import Properties "../properties";
import StableBuffer "mo:stablebuffer_1_3_0/StableBuffer";
import Map "mo:map9/Map";
import Set "mo:map9/Set";
import PrincipalExt "mo:principal-ext";


module {

  type CandyShared = Types.CandyShared;
  type Candy = Types.Candy;
  type ValueShared = Types.ValueShared;
  type DataZone = Types.DataZone;
  type PropertyShared = Types.PropertyShared;
  type Property = Types.Property;
  type StableBuffer<T> = StableBuffer.StableBuffer<T>;

  //todo: generic accessors

  /// Convert a `Candy` to `Nat`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int16(15);
  /// let converted_value = Conversion.candyToNat(value);
  /// ```
  public func candyToNat(val : Candy) : Result.Result<Nat, Text> {
    switch(val){
    case(#Nat(val)){ #ok(val)};
    case(#Nat8(val)){ #ok(Nat8.toNat(val))};
    case(#Nat16(val)){ #ok(Nat16.toNat(val))};
    case(#Nat32(val)){ #ok(Nat32.toNat(val))};
    case(#Nat64(val)){ #ok(Nat64.toNat(val))};
    case(#Float(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat(#Int(Float.toInt(Float.nearest(val))))};
    case(#Int(val)){
      if(val < 0){return #err("illegal cast");};
      
      #ok(Int.abs(val))};
    case(#Int8(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat(#Int(Int8.toInt(Int8.abs(val))))};
    case(#Int16(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat(#Int(Int16.toInt(Int16.abs(val))))};
    case(#Int32(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat(#Int(Int32.toInt(Int32.abs(val))))};
    case(#Int64(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat(#Int(Int64.toInt(Int64.abs(val))))};
    case(_){return #err("illegal cast");/*unreachable*/};
    };
  };

  /// Convert a `Candy` to `Nat8`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToNat8(value);
  /// ```
  
  public func candyToNat8(val : Candy) : Result.Result<Nat8, Text> {
    switch(val){
    case(#Nat8(val)){ #ok(val)};
    case(#Nat(val)){ 
      if(val > Nat8.toNat(Nat8.maximumValue)) return #err("illegal cast");
      #ok(Nat8.fromNat(val))
    };
    case(#Nat16(val)){ 
      if(Nat16.toNat(val) > Nat8.toNat(Nat8.maximumValue)) return #err("illegal cast");
      #ok(Nat8.fromNat(Nat16.toNat(val)))};
    case(#Nat32(val)){ 
      if(Nat32.toNat(val) > Nat8.toNat(Nat8.maximumValue)) return #err("illegal cast");
      #ok(Nat8.fromNat(Nat32.toNat(val)))};
    case(#Nat64(val)){ 
      if(Nat64.toNat(val) > Nat8.toNat(Nat8.maximumValue)) return #err("illegal cast");
      #ok(Nat8.fromNat(Nat64.toNat(val)))};
    case(#Float(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat8(#Int(Float.toInt(Float.nearest(val))))};
    case(#Int(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat8(#Nat(Int.abs(val)))};
    case(#Int8(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat8(#Int(Int8.toInt(Int8.abs(val))))};
    case(#Int16(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat8(#Int(Int16.toInt(Int16.abs(val))))};
    case(#Int32(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat8(#Int(Int32.toInt(Int32.abs(val))))};
    case(#Int64(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat8(#Int(Int64.toInt(Int64.abs(val))))};
    case(_){return #err("illegal cast");/*unreachable*/};
    };
  };

  /// Convert a `Candy` to `Nat16`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToNat16(value);
  /// ```
  
  public func candyToNat16(val : Candy) : Result.Result<Nat16, Text> {
    switch(val){
    case(#Nat16(val)){ #ok(val)};
    case(#Nat8(val)){ #ok(Nat16.fromNat(Nat8.toNat(val)))};
    case(#Nat(val)){ 
      //make sure it is less than the largest Nat16
      if(val < Nat16.toNat(Nat16.maximumValue)) {
        return #ok(Nat16.fromNat(val))
      } else {
        return #err("overflow while converting Nat to Nat16")
      }
    };
    case(#Nat32(val)){ 
      if(val < Nat16.toNat32(Nat16.maximumValue)) {
        return #ok(Nat16.fromNat(Nat32.toNat(val)))
      } else {
        return #err("overflow while converting Nat32 to Nat16")
      }
    };
    case(#Nat64(val)){ 
      if(Nat64.toNat(val) < Nat16.toNat(Nat16.maximumValue)) {
        return #ok(Nat16.fromNat(Nat64.toNat(val)))
      } else {
        return #err("overflow while converting Nat64 to Nat16")
      }
    };
    case(#Float(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat16(#Int(Float.toInt(Float.nearest(val))))};
    case(#Int(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat16(#Nat(Int.abs(val)))};
    case(#Int8(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat16(#Int(Int8.toInt(Int8.abs(val))))};
    case(#Int16(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat16(#Int(Int16.toInt(Int16.abs(val))))};
    case(#Int32(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat16(#Int(Int32.toInt(Int32.abs(val))))};
    case(#Int64(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat16(#Int(Int64.toInt(Int64.abs(val))))};
    case(_){return #err("illegal cast");/*unreachable*/};
    };
  };

  /// Convert a `Candy` to `Nat32`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToNat32(value);
  /// ```
  
  public func candyToNat32(val : Candy) : Result.Result<Nat32, Text> {
    switch(val){
    case(#Nat32(val)){ #ok(val)};
    case(#Nat16(val)){ #ok(Nat32.fromNat(Nat16.toNat(val)))};
    case(#Nat8(val)){ #ok(Nat32.fromNat(Nat8.toNat(val)))};
    case(#Nat(val)){ 
      if(val < Nat32.toNat(Nat32.maximumValue)) {        
        return #ok(Nat32.fromNat(val)) 
      } else {
        return #err("overflow while converting Nat to Nat32")
      }
    };
    case(#Float(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat32(#Int(Float.toInt(Float.nearest(val))))};
    case(#Int(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat32(#Nat(Int.abs(val)))};
    case(#Int8(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat32(#Int(Int8.toInt(Int8.abs(val))))};
    case(#Int16(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat32(#Int(Int16.toInt(Int16.abs(val))))};
    case(#Int32(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat32(#Int(Int32.toInt(Int32.abs(val))))};
    case(#Int64(val)){
      if(val < 0){return #err("illegal cast");};
      candyToNat32(#Int(Int64.toInt(Int64.abs(val))))};
    case(_){return #err("illegal cast");/*unreachable*/};
    };
  };

  /// Convert a `Candy` to `Nat64`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToNat64(value);
  /// ```
  
  public func candyToNat64(val : Candy) : Result.Result<Nat64, Text> {
    switch(val){
    case(#Nat64(val)){ #ok(val)};
    case(#Nat32(val)){ #ok(Nat64.fromNat(Nat32.toNat(val)))};
    case(#Nat16(val)){ #ok(Nat64.fromNat(Nat16.toNat(val)))};
    case(#Nat8(val)){ #ok(Nat64.fromNat(Nat8.toNat(val)))};
    case(#Nat(val)){ #ok(Nat64.fromNat(val))};
    case(#Float(val)){
      if(val < 0){ return #err("illegal cast"); };
      candyToNat64(#Int(Float.toInt(Float.nearest(val))))};
    case(#Int(val)){
      if(val < 0){ return #err("illegal cast"); };
      candyToNat64(#Nat(Int.abs(val)))};
    case(#Int8(val)){
      if(val < 0){ return #err("illegal cast"); };
      candyToNat64(#Int(Int8.toInt(Int8.abs(val))))};
    case(#Int16(val)){
      if(val < 0){ return #err("illegal cast"); };
      candyToNat64(#Int(Int16.toInt(Int16.abs(val))))};
    case(#Int32(val)){
      if(val < 0){ return #err("illegal cast"); };
      candyToNat64(#Int(Int32.toInt(Int32.abs(val))))};
    case(#Int64(val)){
      if(val < 0){ return #err("illegal cast"); };
      candyToNat64(#Int(Int64.toInt(Int64.abs(val))))};
    case(_){ return #err("illegal cast"); /*unreachable*/ };
    };
  };

  /// Convert a `Candy` to `Int`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToInt(value);
  /// ```
  
  public func candyToInt(val : Candy) : Result.Result<Int, Text> {
    switch(val){
      case(#Int(val)){ #ok(val) };
      case(#Int8(val)){ #ok(Int8.toInt(val)) };
      case(#Int16(val)){ #ok(Int16.toInt(val)) };
      case(#Int32(val)){ #ok(Int32.toInt(val)) };
      case(#Int64(val)){ #ok(Int64.toInt(val)) };
      case(#Nat(val)){ #ok(val) };
      case(#Nat8(val)){ #ok(Nat8.toNat(val)) };
      case(#Nat16(val)){ #ok(Nat16.toNat(val)) };
      case(#Nat32(val)){ #ok(Nat32.toNat(val)) };
      case(#Nat64(val)){ #ok(Nat64.toNat(val)) };
      case(#Float(val)){ #ok(Float.toInt(Float.nearest(val))) }; 
      case(_){ #err("illegal cast") };
    };
  };

  /// Convert a `Candy` to `Int8`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToInt8(value);
  /// ```
  
  public func candyToInt8(val : Candy) : Result.Result<Int8, Text> {
    switch(val){
      case(#Int8(val)){ #ok(val) };
      case(#Int(val)){ 
        if(val <= Int8.toInt(Int8.maximumValue) and val >= Int8.toInt(Int8.minimumValue)){
          #ok(Int8.fromInt(val)) 
        } else {
          #err("illegal cast")
        }
      };
      case(#Int16(val)){ 
        if(Int16.toInt(val) > Int.abs(Int8.toInt(Int8.maximumValue))) return #err("illegal cast");
        #ok(Int8.fromInt(Int16.toInt(val))) };
      case(#Int32(val)){ 
        if(Int32.toInt(val) > Int.abs(Int8.toInt(Int8.maximumValue))) return #err("illegal cast");
        #ok(Int8.fromInt(Int32.toInt(val))) };
      case(#Int64(val)){ 
        if(Int64.toInt(val) > Int.abs(Int8.toInt(Int8.maximumValue))) return #err("illegal cast");
        #ok(Int8.fromInt(Int64.toInt(val))) };
      case(#Nat8(val)){ 
        if(Nat8.toNat(val) > Int.abs(Int8.toInt(Int8.maximumValue))) return #err("illegal cast");
        #ok(Int8.fromNat8(val)) };
      case(#Nat(val)){ 
        switch(candyToNat8(#Nat(val))){
          case(#ok(nat8)){ #ok(Int8.fromNat8(nat8)) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Nat16(val)){ 
        switch(candyToNat8(#Nat16(val))){
          case(#ok(nat8)){ #ok(Int8.fromNat8(nat8)) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Nat32(val)){ 
        switch(candyToNat8(#Nat32(val))){
          case(#ok(nat8)){ #ok(Int8.fromNat8(nat8)) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Nat64(val)){ 
        switch(candyToNat8(#Nat64(val))){
          case(#ok(nat8)){ #ok(Int8.fromNat8(nat8)) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Float(val)){ #ok(Int8.fromInt(Float.toInt(Float.nearest(val)))) };
      case(_){ #err("illegal cast") };
    };
  };

  /// Convert a `Candy` to `Int16`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToInt16(value);
  /// ```
  
  public func candyToInt16(val : Candy) : Result.Result<Int16, Text> {
    switch(val){
      case(#Int16(val)){ #ok(val) };
      case(#Int8(val)){ #ok(Int16.fromInt(Int8.toInt(val))) };
      case(#Int(val)){ 
        if(val <= Int16.toInt(Int16.maximumValue) and val >= Int16.toInt(Int16.minimumValue)){
          #ok(Int16.fromInt(val)) 
        } else {
          #err("illegal cast")
        }
      };
      case(#Int32(val)){ 
        if(Int32.toInt(val) > Int.abs(Int16.toInt(Int16.maximumValue))) return #err("illegal cast");
        #ok(Int16.fromInt(Int32.toInt(val))) };
      case(#Int64(val)){ 
        if(Int64.toInt(val) > Int.abs(Int16.toInt(Int16.maximumValue))) return #err("illegal cast");
        #ok(Int16.fromInt(Int64.toInt(val))) };
      case(#Nat8(val)){ 
        switch(candyToNat16(#Nat8(val))){
          case(#ok(nat16)){ #ok(Int16.fromNat16(nat16)) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Nat(val)){ 
        switch(candyToNat16(#Nat(val))){
          case(#ok(nat16)){ #ok(Int16.fromNat16(nat16)) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Nat16(val)){
        if(Nat16.toNat(val) > Int.abs(Int16.toInt(Int16.maximumValue))) return #err("illegal cast");
         #ok(Int16.fromNat16(val)) };
      case(#Nat32(val)){ 
        switch(candyToNat16(#Nat32(val))){
          case(#ok(nat16)){ #ok(Int16.fromNat16(nat16)) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Nat64(val)){ 
        switch(candyToNat16(#Nat64(val))){
          case(#ok(nat16)){ #ok(Int16.fromNat16(nat16)) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Float(val)){ #ok(Int16.fromInt(Float.toInt(Float.nearest(val)))) };
      case(_){ #err("illegal cast") };
    };
  };

  /// Convert a `Candy` to `Int32`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToInt32(value);
  /// ```
  
  public func candyToInt32(val : Candy) : Result.Result<Int32, Text> {
    switch(val){
      case(#Int32(val)){ #ok(val) };
      case(#Int16(val)){ #ok(Int32.fromInt(Int16.toInt(val))) };
      case(#Int8(val)){ #ok(Int32.fromInt(Int8.toInt(val))) };
      case(#Int(val)){ 
        if(val <= Int32.toInt(Int32.maximumValue) and val >= Int32.toInt(Int32.minimumValue)){
          #ok(Int32.fromInt(val)) 
        } else {
          #err("overflow while converting Int to Int32")
        }
      };
      case(#Nat8(val)){ 
        switch(candyToNat32(#Nat8(val))){
          case(#ok(nat32)){ #ok(Int32.fromNat32(nat32)) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Nat(val)){ 
        switch(candyToNat32(#Nat(val))){
          case(#ok(nat32)){ #ok(Int32.fromNat32(nat32)) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Nat16(val)){ 
        switch(candyToNat32(#Nat16(val))){
          case(#ok(nat32)){ #ok(Int32.fromNat32(nat32)) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Nat32(val)){ 
        if(Nat32.toNat(val) > Int.abs(Int32.toInt(Int32.maximumValue))) return #err("illegal cast");
        #ok(Int32.fromNat32(val)) };
      case(#Nat64(val)){ 
        switch(candyToNat32(#Nat64(val))){
          case(#ok(nat32)){ #ok(Int32.fromNat32(nat32)) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Float(val)){ 
        let nearestVal = Float.toInt(val);
        return candyToInt32(#Int(nearestVal));
      };
      case(_){ #err("illegal cast") };
    };
  };

  /// Convert a `Candy` to `Int64`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToInt64(value);
  /// ```
  
  public func candyToInt64(val : Candy) : Result.Result<Int64, Text> {
    switch(val){
      case(#Int64(val)){ #ok(val) };
      case(#Int32(val)){ #ok(Int64.fromInt(Int32.toInt(val))) };
      case(#Int16(val)){ #ok(Int64.fromInt(Int16.toInt(val))) };
      case(#Int8(val)){ #ok(Int64.fromInt(Int8.toInt(val))) };
      case(#Int(val)){ 
        if(val <= Int64.toInt(Int64.maximumValue) and val >= Int64.toInt(Int64.minimumValue)){
          #ok(Int64.fromInt(val)) 
        } else {
          #err("overflow while converting Int to Int64")
        }
      };
      case(#Nat8(val)){ 
        switch(candyToNat64(#Nat8(val))){
          case(#ok(nat64)){ #ok(Int64.fromNat64(nat64)) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Nat(val)){ 
        switch(candyToNat64(#Nat(val))){
          case(#ok(nat64)){ #ok(Int64.fromNat64(nat64)) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Nat16(val)){ 
        switch(candyToNat64(#Nat16(val))){
          case(#ok(nat64)){ #ok(Int64.fromNat64(nat64)) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Nat32(val)){ 
        switch(candyToNat64(#Nat32(val))){
          case(#ok(nat64)){ #ok(Int64.fromNat64(nat64)) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Nat64(val)){
        if(Nat64.toNat(val) > Int.abs(Int64.toInt(Int64.maximumValue))) return #err("illegal cast");
         #ok(Int64.fromNat64(val)) };
      case(#Float(val)){ 
        let nearestVal = Float.toInt(val);
        return candyToInt64(#Int(nearestVal));
      };
      case(_){ #err("illegal cast") };
    };
  };

  /// Convert a `Candy` to `Float`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int16(2);
  /// let converted_value = Conversion.candyToFloat(value);
  /// ```
  
  public func candyToFloat(val : Candy) : Result.Result<Float, Text> {
    switch(val){
      case(#Float(val)){ #ok(val) };
      case(#Int64(val)){ #ok(Float.fromInt64(val)) };
      case(#Int32(val)){ 
        switch(candyToFloat(#Int(Int32.toInt(val)))){
          case(#ok(float)){ #ok(float) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Int16(val)){ 
        switch(candyToFloat(#Int(Int16.toInt(val)))){
          case(#ok(float)){ #ok(float) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Int8(val)){ 
        switch(candyToFloat(#Int(Int8.toInt(val)))){
          case(#ok(float)){ #ok(float) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Int(val)){ #ok(Float.fromInt(val)) };
      case(#Nat8(val)){ 
        switch(candyToFloat(#Int(Nat8.toNat(val)))){
          case(#ok(float)){ #ok(float) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Nat(val)){ 
        switch(candyToFloat(#Int(val))){
          case(#ok(float)){ #ok(float) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Nat16(val)){ 
        switch(candyToFloat(#Int(Nat16.toNat(val)))){
          case(#ok(float)){ #ok(float) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Nat32(val)){ 
        switch(candyToFloat(#Int(Nat32.toNat(val)))){
          case(#ok(float)){ #ok(float) };
          case(#err(e)){ #err(e) };
        }
      };
      case(#Nat64(val)){ 
        switch(candyToFloat(#Int(Nat64.toNat(val)))){
          case(#ok(float)){ #ok(float) };
          case(#err(e)){ #err(e) };
        }
      };
      case(_){ #err("illegal cast") };
    };
  };

  /// Convert a `Candy` to `Text`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Int8(2);
  /// let converted_value = Conversion.candyToText(value);
  /// ```
  public func candyToText(val : Candy) : Result.Result<Text, Text> {
    switch(val){
      case(#Text(val)){ #ok(val)};
      case(#Nat64(val)){ #ok(Nat64.toText(val))};
      case(#Nat32(val)){ #ok(Nat32.toText(val))};
      case(#Nat16(val)){ #ok(Nat16.toText(val))};
      case(#Nat8(val)){ #ok(Nat8.toText(val))};
      case(#Nat(val)){ #ok(Nat.toText(val))};
      case(#Int64(val)){ #ok(Int64.toText(val))};
      case(#Int32(val)){ #ok(Int32.toText(val))};
      case(#Int16(val)){ #ok(Int16.toText(val))};
      case(#Int8(val)){ #ok(Int8.toText(val))};
      case(#Int(val)){ #ok(Int.toText(val))};
      case(#Bool(val)){ #ok(Bool.toText(val))};
      case(#Float(val)){ #ok(Float.format(#exact, val))};
      case(#Option(val)){
        switch(val){
          case(null){ #ok("null")};
          case(?val){
            switch(candyToText(val)){
              case(#ok(text)){ #ok(text) };
              case(#err(e)){ #err(e) };
            }
          };
        };
      };
      //blob
      case(#Blob(val)){
        #ok(Hex.encode(Blob.toArray(val)));
      };
      //class
      case(#Class(val)){ 
        var t = "{";
        for(thisItem in Map.entries(val)){
          switch(candyToText(thisItem.1.value)){
            case(#ok(text)){
              t := t # thisItem.1.name # ":" # (if(thisItem.1.immutable == false){"var "}else{""}) # text # "; ";
            };
            case(#err(e)){ return #err(e) };
          }
        };
        #ok(Text.trimEnd(t, #text(" ")) # "}");
      };
      //principal
      case(#Principal(val)){ #ok(Principal.toText(val))};
      //array
      case(#Array(val)){
        var t = "[";
        for(thisItem in StableBuffer.vals(val)){
          switch(candyToText(thisItem)){
            case(#ok(text)){
              t := t # "{" # text # "} ";
            };
            case(#err(e)){ return #err(e) };
          }
        };
        #ok(Text.trimEnd(t, #text(" ")) # "]");
      };
      //floats
      case(#Floats(val)){
        var t = "[";
        for(thisItem in StableBuffer.vals(val)){
          t := t # Float.format(#exact, thisItem) # " ";
        };
        #ok(Text.trimEnd(t, #text(" ")) # "]");
      };
      //nats
      case(#Nats(val)){
        var t = "[";
        for(thisItem in StableBuffer.vals(val)){
          t := t # Nat.toText(thisItem) # " ";
        };
        #ok(Text.trimEnd(t, #text(" ")) # "]");
      };
      //ints
      case(#Ints(val)){
        var t = "[";
        for(thisItem in StableBuffer.vals(val)){
          t := t # Int.toText(thisItem) # " ";
        };
        #ok(Text.trimEnd(t, #text(" ")) # "]");
      };
      //bytes
      case(#Bytes(val)){
        #ok(Hex.encode(StableBuffer.toArray(val)));
      };
      case(#Set(val)){ 
        var t = "[";
        for(thisItem in Set.keys(val)){
          switch(candyToText(thisItem)){
            case(#ok(text)){
              t := t # "{" # text # "} ";
            };
            case(#err(e)){ return #err(e) };
          }
        };
        #ok(Text.trimEnd(t, #text(" ")) # "]");
      };
      case(#Map(val)){ 
        var t = "{";
        for(thisItem in Map.entries(val)){
          switch(candyToText(thisItem.1)){
            case(#ok(text)){
              t := t # thisItem.0 # ":" # text # "; ";
            };
            case(#err(e)){ return #err(e) };
          }
        };
        #ok(Text.trimEnd(t, #text(" ")) # "}");
      };
      case(#ValueMap(val)){ 
        var t = "{";
        for(thisItem in Map.entries(val)){
          switch(candyToText(thisItem.0)){
            case(#ok(keyText)){
              switch(candyToText(thisItem.1)){
                case(#ok(valueText)){
                  t := t # keyText # ":" # valueText # "; ";
                };
                case(#err(e)){ return #err(e) };
              }
            };
            case(#err(e)){ return #err(e) };
          }
        };
        #ok(Text.trimEnd(t, #text(" ")) # "}");
      };
      case(_){ #err("illegal cast") };
    };
  };

  /// Convert a `Candy` to `Principal`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Principal(Principal.fromText("abc"));
  /// let converted_value = Conversion.candyToPrincipal(value);
  /// ```
  
  public func candyToPrincipal(val : Candy) : Result.Result<Principal, Text> {
    switch(val){
      case(#Principal(val)){ #ok(val) };
      case(#Blob(val)){ 
        if(val.size() > 29){ 
          return #err("invalid blob size for Principal");
        };
        #ok(Principal.fromBlob(val));
      };
      case(#Bytes(val)){ 
        if(StableBuffer.size(val) > 29){ 
          return #err("invalid blob size for Principal");
        };
        #ok(Principal.fromBlob(Blob.fromArray(StableBuffer.toArray<Nat8>(val))));
      };
      case(#Text(val)){ 
        
        switch(PrincipalExt.fromText(val)){
          case(?principal){ return #ok(principal) };
          case(null){ return #err("invalid principal") };
        };
      };
      case(_){ #err("illegal cast to Principal") };
    };
  };

  /// Convert a `Candy` to `Bool`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Bool(false);
  /// let converted_value = Conversion.candyToPBool(value);
  /// ```
  
  public func candyToBool(val : Candy) : Result.Result<Bool, Text> {
    switch(val){
      case(#Bool(val)){ #ok(val) };
      case(#Text(val)){
        if(val == "true"){ return #ok(true) };
        if(val == "false"){ return #ok(false) };
        #err("illegal cast to Bool");
      };
      case(_){ #err("illegal cast to Bool") };
    };
  };

  /// Convert a `Candy` to `Blob`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Principal(Principal.fromText("abc"));
  /// let converted_value = Conversion.candyToBlob(value);
  /// ```
  public func candyToBlob(val : Candy) : Result.Result<Blob, Text> {
    switch(val){
      case(#Blob(val)){ #ok(val) };
      case(#Bytes(val)){ #ok(Blob.fromArray(StableBuffer.toArray(val))) };
      case(#Text(val)){ #ok(Blob.fromArray(textToBytes(val))) };
      case(#Int(val)){ #ok(Blob.fromArray(intToBytes(val))) };
      case(#Nat(val)){ #ok(Blob.fromArray(natToBytes(val))) };
      case(#Nat8(val)){ #ok(Blob.fromArray([val])) };
      case(#Nat16(val)){ #ok(Blob.fromArray(nat16ToBytes(val))) };
      case(#Nat32(val)){ #ok(Blob.fromArray(nat32ToBytes(val))) };
      case(#Nat64(val)){ #ok(Blob.fromArray(nat64ToBytes(val))) };
      case(#Principal(val)){ #ok(Principal.toBlob(val)) };
      case(_){ #err("illegal cast to Blob") };
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
  
  public func candyToValueArray(val : Candy) : Result.Result<[Candy], Text> {
    switch(val){
      case(#Array(val)){ #ok(StableBuffer.toArray(val)) };
      case(_){ #err("illegal cast to [Candy]") };
    };
  };

  /// Convert a `Candy` to Bytes(`[Nat8]`)
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: Candy = #Principal(Principal.fromText("abc"));
  /// let value_as_bytes = Conversion.candyToBytes(value);
  /// ```
  public func candyToBytes(val : Candy) : Result.Result<[Nat8], Text> {
    switch(val){
      case(#Int(val)){ #ok(intToBytes(val)) };
      case(#Int8(val)){
        switch (candyToInt(#Int8(val))) {
          case (#ok(intVal)) { candyToBytes(#Int(intVal)) };
          case (#err(e)) { return #err(e) };
        }
      };
      case(#Int16(val)){
        switch (candyToInt(#Int16(val))) {
          case (#ok(intVal)) { candyToBytes(#Int(intVal)) };
          case (#err(e)) { return #err(e) };
        }
      };
      case(#Int32(val)){
        switch (candyToInt(#Int32(val))) {
          case (#ok(intVal)) { candyToBytes(#Int(intVal)) };
          case (#err(e)) { return #err(e) };
        }
      };
      case(#Int64(val)){
        switch (candyToInt(#Int64(val))) {
          case (#ok(intVal)) { candyToBytes(#Int(intVal)) };
          case (#err(e)) { return #err(e) };
        }
      };
      case(#Nat(val)){ #ok(natToBytes(val)) };
      case(#Nat8(val)){ #ok([val]) };
      case(#Nat16(val)){ #ok(nat16ToBytes(val)) };
      case(#Nat32(val)){ #ok(nat32ToBytes(val)) };
      case(#Nat64(val)){ #ok(nat64ToBytes(val)) };
      case(#Float(val)){ #err("conversion from Float to Bytes not implemented") };
      case(#Text(val)){ #ok(textToBytes(val)) };
      case(#Bool(val)){ #ok(boolToBytes(val)) };
      case(#Blob(val)){ #ok(Blob.toArray(val)) };
      case(#Class(val)){ #err("conversion from Class to Bytes not implemented") };
      case(#Principal(val)){ #ok(principalToBytes(val)) };
      case(#Option(val)){ #err("conversion from Option to Bytes not implemented") };
      case(#Array(val)){ #err("conversion from Array to Bytes not implemented") };
      case(#Bytes(val)){ #ok(StableBuffer.toArray(val)) };
      case(#Floats(val)){ #err("conversion from Floats to Bytes not implemented") };
      case(#Nats(val)){ #err("conversion from Nats to Bytes not implemented") };
      case(#Ints(val)){ #err("conversion from Ints to Bytes not implemented") };
      case(#ValueMap(val)){ #err("conversion from ValueMap to Bytes not implemented") };
      case(#Map(val)){ #err("conversion from Map to Bytes not implemented") };
      case(#Set(val)){ #err("conversion from Set to Bytes not implemented") };
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
  
  public func candyToBytesBuffer(val : Candy) : Result.Result<Buffer.Buffer<Nat8>, Text> {
    switch (val) {
      case (#Bytes(val)) { #ok(Buffer.fromArray(StableBuffer.toArray(val))) };
      case (_) {
        switch (candyToBytes(val)) {
          case (#ok(bytes)) { #ok(toBuffer<Nat8>(bytes)) };
          case (#err(e)) { #err(e) };
        }
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
  
  public func candyToFloatsBuffer(val : Candy) : Result.Result<Buffer.Buffer<Float>, Text> {
    switch (val) {
      case (#Floats(val)) { #ok(stableBufferToBuffer(val)) };
      case (_) {
        switch (candyToFloat(val)) {
          case (#ok(float)) { #ok(toBuffer([float])) };
          case (#err(e)) { #err(e) };
        }
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
  
  public func candyToNatsBuffer(val : Candy) : Result.Result<Buffer.Buffer<Nat>, Text> {
    switch (val) {
      case (#Nats(val)) { #ok(stableBufferToBuffer(val)) };
      case (_) {
        switch (candyToNat(val)) {
          case (#ok(nat)) { #ok(toBuffer([nat])) };
          case (#err(e)) { #err(e) };
        }
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
  
  public func candyToMap(val : Candy) : Result.Result<Map.Map<Text, Candy>, Text> {
    switch (val) {
      case (#Map(val)) { #ok(val) };
      case (_) { #err("conversion to Map<Text, Candy> not supported") };
    };
  };

  /// Example:
  /// ```motoko include=import
  /// let map = Map.new<text,Candy>();
  /// Map.put<candy, Candy>(map, candyHashTool, #Text("akey"), #Text("value"));
  /// let value: Candy = #ValueMapMap(map);
  /// let value_as_nats_buffer = Conversion.candyToValueMap(value);
  /// ```
  
  public func candyToValueMap(val : Candy) : Result.Result<Map.Map<Candy, Candy>, Text> {
    switch (val) {
      case (#ValueMap(val)) { #ok(val) };
      case (_) { #err("conversion to Map<Candy, Candy> not supported") };
    };
  };

  /// Example:
  /// ```motoko include=import
  /// let map = Set.new<Candy>();
  /// Set.put<Candy>(map, candyHashTool, #Text("akey"));
  /// let value: Candy = #Set(map);
  /// let value_as_nats_buffer = Conversion.candyToSet(value);
  /// ```
  
  public func candyToSet(val : Candy) : Result.Result<Set.Set<Candy>, Text> {
    switch (val) {
      case (#Set(val)) { #ok(val) };
      case (_) { #err("conversion to Set<Candy> not supported") };
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
  
  public func candyToPropertyMap(val : Candy) : Result.Result<Map.Map<Text, Property>, Text> {
    switch (val) {
      case (#Class(val)) { #ok(val) };
      case (#Map(val)) { 
        // Convert Map<Text, Candy> to Map<Text, Property>
        var propertyMap = Map.new<Text, Property>();
        for (entry in Map.entries(val)) {
          
          ignore Map.put<Text, Property>(propertyMap, Map.thash, entry.0, {name=entry.0; value=entry.1; immutable=true});
            
        };
        #ok(propertyMap);
      };
      case (_) { #err("conversion to Map<Text, Property> not supported") };
    };
  };

  /// Convert a `CandyShared` to `Nat`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Int16(15);
  /// let converted_value = Conversion.candySharedToNat(value);
  /// ```
  
  public func candySharedToNat(val : CandyShared) : Result.Result<Nat, Text> {
    switch (val) {
      case (#Nat(val)) { #ok(val) };
      case (#Nat8(val)) { #ok(Nat8.toNat(val)) };
      case (#Nat16(val)) { #ok(Nat16.toNat(val)) };
      case (#Nat32(val)) { #ok(Nat32.toNat(val)) };
      case (#Nat64(val)) { #ok(Nat64.toNat(val)) };
      case (#Float(val)) {
        if (val < 0) { #err("illegal cast") }
        else { candySharedToNat(#Int(Float.toInt(Float.nearest(val)))) };
      };
      case (#Int(val)) {
        if (val < 0) { #err("illegal cast") }
        else { #ok(Int.abs(val)) };
      };
      case (#Int8(val)) {
        if (val < 0) { #err("illegal cast") }
        else { candySharedToNat(#Int(Int8.toInt(Int8.abs(val)))) };
      };
      case (#Int16(val)) {
        if (val < 0) { #err("illegal cast") }
        else { candySharedToNat(#Int(Int16.toInt(Int16.abs(val)))) };
      };
      case (#Int32(val)) {
        if (val < 0) { #err("illegal cast") }
        else { candySharedToNat(#Int(Int32.toInt(Int32.abs(val)))) };
      };
      case (#Int64(val)) {
        if (val < 0) { #err("illegal cast") }
        else { candySharedToNat(#Int(Int64.toInt(Int64.abs(val)))) };
      };
      case (_) { #err("illegal cast") };
    };
  };

  /// Convert a `CandyShared` to `Nat8`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Int8(15);
  /// let converted_value = Conversion.candySharedToNat8(value);
  /// ```
  
  public func candySharedToNat8(val : CandyShared) : Result.Result<Nat8, Text> {
    switch(val){
      case(#Nat8(val)){ #ok(val) };
      case(#Nat(val)){ 
        if(val > Nat8.toNat(Nat8.maximumValue)){
        return #err("overflow while converting Nat to Nat8");
        };
        #ok(Nat8.fromNat(val))
      };
      case(#Nat16(val)){ 
        if(Nat16.toNat(val) > Nat8.toNat(Nat8.maximumValue)){
          return #err("overflow while converting Nat16 to Nat8");
        } else {
          #ok(Nat8.fromNat(Nat16.toNat(val)))
        }
      };
      case(#Nat32(val)){ 
        if(Nat32.toNat(val) > Nat8.toNat(Nat8.maximumValue)){
          return #err("overflow while converting Nat32 to Nat8");
        } else {
          #ok(Nat8.fromNat(Nat32.toNat(val)))
        }
      };
      case(#Nat64(val)){ 
        if(Nat64.toNat(val) > Nat8.toNat(Nat8.maximumValue)){
          return #err("overflow while converting Nat64 to Nat8");
        } else {
          #ok(Nat8.fromNat(Nat64.toNat(val)))
        }
      };
      case(#Float(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat8(#Int(Float.toInt(Float.nearest(val)))) };
      };
      case(#Int(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat8(#Nat(Int.abs(val))) };
      };
      case(#Int8(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat8(#Int(Int8.toInt(Int8.abs(val)))) };
      };
      case(#Int16(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat8(#Int(Int16.toInt(Int16.abs(val)))) };
      };
      case(#Int32(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat8(#Int(Int32.toInt(Int32.abs(val)))) };
      };
      case(#Int64(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat8(#Int(Int64.toInt(Int64.abs(val)))) };
      };
      case(_){ #err("illegal cast") };
    };
  };

  /// Convert a `CandyShared` to `Nat16`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Int16(15);
  /// let converted_value = Conversion.candySharedToNat16(value);
  /// ```
  
  public func candySharedToNat16(val : CandyShared) : Result.Result<Nat16, Text> {
    switch(val){
      case(#Nat16(val)){ #ok(val) };
      case(#Nat8(val)){ #ok(Nat16.fromNat(Nat8.toNat(val))) };
      case(#Nat(val)){ 
        if (val <= Nat16.toNat(Nat16.maximumValue)) {
          #ok(Nat16.fromNat(val))
        } else {
          #err("overflow while converting Nat to Nat16")
        }
      };
      case(#Nat32(val)){ 
        if (Nat32.toNat(val) <= Nat16.toNat(Nat16.maximumValue)) {
          #ok(Nat16.fromNat(Nat32.toNat(val)))
        } else {
          #err("overflow while converting Nat32 to Nat16")
        }
      };
      case(#Nat64(val)){ 
        if (Nat64.toNat(val) <= Nat16.toNat(Nat16.maximumValue)) {
          #ok(Nat16.fromNat(Nat64.toNat(val)))
        } else {
          #err("overflow while converting Nat64 to Nat16")
        }
      };
      case(#Float(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat16(#Int(Float.toInt(Float.nearest(val)))) };
      };
      case(#Int(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat16(#Nat(Int.abs(val))) };
      };
      case(#Int8(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat16(#Int(Int8.toInt(Int8.abs(val)))) };
      };
      case(#Int16(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat16(#Int(Int16.toInt(Int16.abs(val)))) };
      };
      case(#Int32(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat16(#Int(Int32.toInt(Int32.abs(val)))) };
      };
      case(#Int64(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat16(#Int(Int64.toInt(Int64.abs(val)))) };
      };
      case(_){ #err("illegal cast") };
    };
  };

  /// Convert a `CandyShared` to `Nat32`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Int32(15);
  /// let converted_value = Conversion.candySharedToNat(value);
  /// ```
  
  public func candySharedToNat32(val : CandyShared) : Result.Result<Nat32, Text> {
    switch(val){
      case(#Nat32(val)){ #ok(val) };
      case(#Nat16(val)){ #ok(Nat32.fromNat(Nat16.toNat(val))) };
      case(#Nat8(val)){ #ok(Nat32.fromNat(Nat8.toNat(val))) };
      case(#Nat(val)){ 
        if (val <= Nat32.toNat(Nat32.maximumValue)) {
          #ok(Nat32.fromNat(val))
        } else {
          #err("overflow while converting Nat to Nat32")
        }
      };
      case(#Float(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat32(#Int(Float.toInt(Float.nearest(val)))) };
      };
      case(#Int(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat32(#Nat(Int.abs(val))) };
      };
      case(#Int8(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat32(#Int(Int8.toInt(Int8.abs(val)))) };
      };
      case(#Int16(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat32(#Int(Int16.toInt(Int16.abs(val)))) };
      };
      case(#Int32(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat32(#Int(Int32.toInt(Int32.abs(val)))) };
      };
      case(#Int64(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat32(#Int(Int64.toInt(Int64.abs(val)))) };
      };
      case(_){ #err("illegal cast") };
    };
  };

  /// Convert a `CandyShared` to `Nat64`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Int16(15);
  /// let converted_value = Conversion.candySharedToNat64(value);
  /// ```
  
  public func candySharedToNat64(val : CandyShared) : Result.Result<Nat64, Text> {
    switch(val){
      case(#Nat64(val)){ #ok(val) };
      case(#Nat32(val)){ #ok(Nat64.fromNat(Nat32.toNat(val))) };
      case(#Nat16(val)){ #ok(Nat64.fromNat(Nat16.toNat(val))) };
      case(#Nat8(val)){ #ok(Nat64.fromNat(Nat8.toNat(val))) };
      case(#Nat(val)){ #ok(Nat64.fromNat(val)) };
      case(#Float(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat64(#Int(Float.toInt(Float.nearest(val)))) };
      };
      case(#Int(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat64(#Nat(Int.abs(val))) };
      };
      case(#Int8(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat64(#Int(Int8.toInt(Int8.abs(val)))) };
      };
      case(#Int16(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat64(#Int(Int16.toInt(Int16.abs(val)))) };
      };
      case(#Int32(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat64(#Int(Int32.toInt(Int32.abs(val)))) };
      };
      case(#Int64(val)){
        if(val < 0){ #err("illegal cast") }
        else { candySharedToNat64(#Int(Int64.toInt(Int64.abs(val)))) };
      };
      case(_){ #err("illegal cast") };
    };
  };

  /// Convert a `CandyShared` to `Int`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Int16(15);
  /// let converted_value = Conversion.candySharedToInt(value);
  /// ```
  
  public func candySharedToInt(val : CandyShared) : Result.Result<Int, Text> {
    switch(val){
      case(#Int(val)){ #ok(val) };
      case(#Int8(val)){ #ok(Int8.toInt(val)) };
      case(#Int16(val)){ #ok(Int16.toInt(val)) };
      case(#Int32(val)){ #ok(Int32.toInt(val)) };
      case(#Int64(val)){ #ok(Int64.toInt(val)) };
      case(#Nat(val)){ #ok(val) };
      case(#Nat8(val)){ #ok(Nat8.toNat(val)) };
      case(#Nat16(val)){ #ok(Nat16.toNat(val)) };
      case(#Nat32(val)){ #ok(Nat32.toNat(val)) };
      case(#Nat64(val)){ #ok(Nat64.toNat(val)) };
      case(#Float(val)){ #ok(Float.toInt(Float.nearest(val))) }; 
      case(_){ #err("illegal cast to Int") };
    };
  };

  /// Convert a `CandyShared` to `Int8`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Nat8(11);
  /// let converted_value = Conversion.candySharedToInt8(value);
  /// ```
  
  public func candySharedToInt8(val : CandyShared) : Result.Result<Int8, Text> {
    switch(val){
      case(#Int8(val)){ #ok(val) };
      case(#Int(val)){ 
        if (val >= Int8.toInt(Int8.minimumValue) and val <= Int8.toInt(Int8.maximumValue)) {
          #ok(Int8.fromInt(val))
        } else {
          #err("overflow while converting Int to Int8")
        }
      };
      case(#Int16(val)){ 
        let intVal = Int16.toInt(val);
        if (intVal >= Int8.toInt(Int8.minimumValue) and intVal <= Int8.toInt(Int8.maximumValue)) {
          #ok(Int8.fromInt(intVal))
        } else {
          #err("overflow while converting Int16 to Int8")
        }
      };
      case(#Int32(val)){ 
        let intVal = Int32.toInt(val);
        if (intVal >= Int8.toInt(Int8.minimumValue) and intVal <= Int8.toInt(Int8.maximumValue)) {
          #ok(Int8.fromInt(intVal))
        } else {
          #err("overflow while converting Int32 to Int8")
        }
      };
      case(#Int64(val)){ 
        let intVal = Int64.toInt(val);
        if (intVal >= Int8.toInt(Int8.minimumValue) and intVal <= Int8.toInt(Int8.maximumValue)) {
          #ok(Int8.fromInt(intVal))
        } else {
          #err("overflow while converting Int64 to Int8")
        }
      };
      case(#Nat8(val)){
        if(Nat8.toNat(val) <= Int8.toInt(Int8.maximumValue)){
          #ok(Int8.fromNat8(val))
        } else {  
          #err("overflow while converting Nat8 to Int8")
        }
      };
      case(#Nat(val)){
        switch (candySharedToNat8(#Nat(val))) {
          case (#ok(nat8)) { #ok(Int8.fromNat8(nat8)) };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Nat16(val)){
        switch (candySharedToNat8(#Nat16(val))) {
          case (#ok(nat8)) { #ok(Int8.fromNat8(nat8)) };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Nat32(val)){
        switch (candySharedToNat8(#Nat32(val))) {
          case (#ok(nat8)) { #ok(Int8.fromNat8(nat8)) };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Nat64(val)){
        switch (candySharedToNat8(#Nat64(val))) {
          case (#ok(nat8)) { #ok(Int8.fromNat8(nat8)) };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Float(val)){ 
        let intVal = Float.toInt(Float.nearest(val));
        if (intVal >= Int8.toInt(Int8.minimumValue) and intVal <= Int8.toInt(Int8.maximumValue)) {
          #ok(Int8.fromInt(intVal))
        } else {
          #err("overflow while converting Float to Int8")
        }
      };
     
      case(_){ #err("illegal cast to Int8") };
    };
  };

  /// Convert a `CandyShared` to `Int16`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Float(10);
  /// let converted_value = Conversion.candySharedToInt16(value);
  /// ```
  
  public func candySharedToInt16(val : CandyShared) : Result.Result<Int16, Text> {
    switch(val){
      case(#Int16(val)){ #ok(val) };
      case(#Int8(val)){ #ok(Int16.fromInt(Int8.toInt(val))) };
      case(#Int(val)){ 
        if (val >= Int16.toInt(Int16.minimumValue) and val <= Int16.toInt(Int16.maximumValue)) {
          #ok(Int16.fromInt(val))
        } else {
          #err("overflow while converting Int to Int16")
        }
      };
      case(#Int32(val)){ 
        let intVal = Int32.toInt(val);
        if (intVal >= Int16.toInt(Int16.minimumValue) and intVal <= Int16.toInt(Int16.maximumValue)) {
          #ok(Int16.fromInt(intVal))
        } else {
          #err("overflow while converting Int32 to Int16")
        }
      };
      case(#Int64(val)){ 
        let intVal = Int64.toInt(val);
        if (intVal >= Int16.toInt(Int16.minimumValue) and intVal <= Int16.toInt(Int16.maximumValue)) {
          #ok(Int16.fromInt(intVal))
        } else {
          #err("overflow while converting Int64 to Int16")
        }
      };
      case(#Nat8(val)){
        switch (candySharedToNat16(#Nat8(val))) {
          case (#ok(nat16)) { #ok(Int16.fromNat16(nat16)) };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Nat(val)){
        switch (candySharedToNat16(#Nat(val))) {
          case (#ok(nat16)) { #ok(Int16.fromNat16(nat16)) };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Nat16(val)){ 
        if(Nat16.toNat(val) <= Int16.toInt(Int16.maximumValue)){
          #ok(Int16.fromNat16(val)) 
        } else {
          #err("overflow while converting Nat16 to Int16")
        }
      };
      case(#Nat32(val)){
        switch (candySharedToNat16(#Nat32(val))) {
          case (#ok(nat16)) { #ok(Int16.fromNat16(nat16)) };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Nat64(val)){
        switch (candySharedToNat16(#Nat64(val))) {
          case (#ok(nat16)) { #ok(Int16.fromNat16(nat16)) };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Float(val)){ 
        let intVal = Float.toInt(Float.nearest(val));
        if (intVal >= Int16.toInt(Int16.minimumValue) and intVal <= Int16.toInt(Int16.maximumValue)) {
          #ok(Int16.fromInt(intVal))
        } else {
          #err("overflow while converting Float to Int16")
        }
      };
      case(_){ #err("illegal cast to Int16") };
    };
  };

  /// Convert a `CandyShared` to `Int32`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Nat32(1111);
  /// let converted_value = Conversion.candySharedToInt32(value);
  /// ```
  
  public func candySharedToInt32(val : CandyShared) : Result.Result<Int32, Text> {
    switch(val){
      case(#Int32(val)){ #ok(val) };
      case(#Int16(val)){ #ok(Int32.fromInt(Int16.toInt(val))) };
      case(#Int8(val)){ #ok(Int32.fromInt(Int8.toInt(val))) };
      case(#Int(val)){ 
        if (val >= Int32.toInt(Int32.minimumValue) and val <= Int32.toInt(Int32.maximumValue)) {
          #ok(Int32.fromInt(val))
        } else {
          #err("overflow while converting Int to Int32")
        }
      };
      case(#Nat8(val)){
        switch (candySharedToNat32(#Nat8(val))) {
          case (#ok(nat32)) { #ok(Int32.fromNat32(nat32)) };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Nat(val)){
        switch (candySharedToNat32(#Nat(val))) {
          case (#ok(nat32)) { #ok(Int32.fromNat32(nat32)) };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Nat16(val)){
        switch (candySharedToNat32(#Nat16(val))) {
          case (#ok(nat32)) { #ok(Int32.fromNat32(nat32)) };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Nat32(val)){ 
        if(Nat32.toNat(val) <= Int32.toInt(Int32.maximumValue)){
          #ok(Int32.fromNat32(val)) 
        } else { 
          #err("overflow while converting Nat32 to Int32") 
        }
      };
      case(#Nat64(val)){
        switch (candySharedToNat32(#Nat64(val))) {
          case (#ok(nat32)) { #ok(Int32.fromNat32(nat32)) };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Float(val)){ 
        let intVal = Float.toInt(Float.nearest(val));
        if (intVal >= Int32.toInt(Int32.minimumValue) and intVal <= Int32.toInt(Int32.maximumValue)) {
          #ok(Int32.fromInt(intVal))
        } else {
          #err("overflow while converting Float to Int32")
        }
      };
      case(_){ #err("illegal cast to Int32") };
    };
  };

  /// Convert a `CandyShared` to `Int64`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Nat64(12345);
  /// let converted_value = Conversion.candySharedToInt64(value);
  /// ```
  
  public func candySharedToInt64(val : CandyShared) : Result.Result<Int64, Text> {
    switch(val){
      case(#Int64(val)){ #ok(val) };
      case(#Int32(val)){ #ok(Int64.fromInt(Int32.toInt(val))) };
      case(#Int16(val)){ #ok(Int64.fromInt(Int16.toInt(val))) };
      case(#Int8(val)){ #ok(Int64.fromInt(Int8.toInt(val))) };
      case(#Int(val)){ 
        if (val >= Int64.toInt(Int64.minimumValue) and val <= Int64.toInt(Int64.maximumValue)) {
          #ok(Int64.fromInt(val))
        } else {
          #err("overflow while converting Int to Int64")
        }
      };
      case(#Nat8(val)){ 
        switch (candySharedToNat64(#Nat8(val))) {
          case (#ok(nat64)) { #ok(Int64.fromNat64(nat64)) };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Nat(val)){ 
        switch (candySharedToNat64(#Nat(val))) {
          case (#ok(nat64)) { #ok(Int64.fromNat64(nat64)) };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Nat16(val)){ 
        switch (candySharedToNat64(#Nat16(val))) {
          case (#ok(nat64)) { #ok(Int64.fromNat64(nat64)) };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Nat32(val)){ 
        switch (candySharedToNat64(#Nat32(val))) {
          case (#ok(nat64)) { #ok(Int64.fromNat64(nat64)) };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Nat64(val)){ 
        if(Nat64.toNat(val) > Int64.toInt(Int64.maximumValue)){
          return #err("overflow while converting Nat64 to Int64");
        } 
        else {
          
          #ok(Int64.fromNat64(val)) 
        };
      };
      case(#Float(val)){ 
        let intVal = Float.toInt(Float.nearest(val));
        if (intVal >= Int64.toInt(Int64.minimumValue) and intVal <= Int64.toInt(Int64.maximumValue)) {
          #ok(Int64.fromInt(intVal))
        } else {
          #err("overflow while converting Float to Int64")
        }
      };
      case(_){ #err("illegal cast to Int64") };
    };
  };

  /// Convert a `CandyShared` to `Float`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Int16(11);
  /// let converted_value = Conversion.candySharedToFloat(value);
  /// ```
  
  public func candySharedToFloat(val : CandyShared) : Result.Result<Float, Text> {
    switch(val){
      case(#Float(val)){ #ok(val) };
      case(#Int64(val)){ #ok(Float.fromInt64(val)) };
      case(#Int32(val)){ candySharedToFloat(#Int(Int32.toInt(val))) };
      case(#Int16(val)){ candySharedToFloat(#Int(Int16.toInt(val))) };
      case(#Int8(val)){ candySharedToFloat(#Int(Int8.toInt(val))) };
      case(#Int(val)){ #ok(Float.fromInt(val)) };
      case(#Nat8(val)){ candySharedToFloat(#Int(Nat8.toNat(val))) };
      case(#Nat(val)){ candySharedToFloat(#Int(val)) };
      case(#Nat16(val)){ candySharedToFloat(#Int(Nat16.toNat(val))) };
      case(#Nat32(val)){ candySharedToFloat(#Int(Nat32.toNat(val))) };
      case(#Nat64(val)){ candySharedToFloat(#Int(Nat64.toNat(val))) };
      case(_){ #err("illegal cast to Float") };
    };
  };

  /// Convert a `CandyShared` to `Text`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Float(11);
  /// let converted_value = Conversion.candySharedToText(value);
  /// ```
  public func candySharedToText(val : CandyShared) : Result.Result<Text, Text> {
    switch(val){
      case(#Text(val)){ #ok(val) };
      case(#Nat64(val)){ #ok(Nat64.toText(val)) };
      case(#Nat32(val)){ #ok(Nat32.toText(val)) };
      case(#Nat16(val)){ #ok(Nat16.toText(val)) };
      case(#Nat8(val)){ #ok(Nat8.toText(val)) };
      case(#Nat(val)){ #ok(Nat.toText(val)) };
      case(#Int64(val)){ #ok(Int64.toText(val)) };
      case(#Int32(val)){ #ok(Int32.toText(val)) };
      case(#Int16(val)){ #ok(Int16.toText(val)) };
      case(#Int8(val)){ #ok(Int8.toText(val)) };
      case(#Int(val)){ #ok(Int.toText(val)) };
      case(#Bool(val)){ #ok(Bool.toText(val)) };
      case(#Float(val)){ #ok(Float.format(#exact, val)) };
      case(#Option(val)){
        switch(val){
          case(null){ #ok("null") };
          case(?val){ candySharedToText(val) };
        };
      };
      case(#Blob(val)){ #ok(Hex.encode(Blob.toArray(val))) };
      case(#Class(val)){
        var t = "{";
        for(thisItem in val.vals()){
          switch(candySharedToText(thisItem.value)){
            case(#ok(text)){
              t := t # thisItem.name # ": " # (if(thisItem.immutable == false){"var "}else{""}) # text # "; ";
            };
            case(#err(e)){ return #err(e) };
          }
        };
        #ok(Text.trimEnd(t, #text(" ")) # "}");
      };
      case(#Principal(val)){ #ok(Principal.toText(val)) };
      case(#Array(val)){
        var t = "[";
        for(thisItem in val.vals()){
          switch(candySharedToText(thisItem)){
            case(#ok(text)){
              t := t # "{" # text # "} ";
            };
            case(#err(e)){ return #err(e) };
          }
        };
        #ok(Text.trimEnd(t, #text(" ")) # "]");
      };
      case(#Floats(val)){
        var t = "[";
        for(thisItem in val.vals()){
          t := t # Float.format(#exact, thisItem) # " ";
        };
        #ok(Text.trimEnd(t, #text(" ")) # "]");
      };
      case(#Nats(val)){
        var t = "[";
        for(thisItem in val.vals()){
          t := t # Nat.toText(thisItem) # " ";
        };
        #ok(Text.trimEnd(t, #text(" ")) # "]");
      };
      case(#Ints(val)){
        var t = "[";
        for(thisItem in val.vals()){
          t := t # Int.toText(thisItem) # " ";
        };
        #ok(Text.trimEnd(t, #text(" ")) # "]");
      };
      case(#Bytes(val)){ #ok(Hex.encode(val)) };
      case(#Set(val)){
        var t = "[";
        for(thisItem in val.vals()){
          switch(candySharedToText(thisItem)){
            case(#ok(text)){
              t := t # "{" # text # "} ";
            };
            case(#err(e)){ return #err(e) };
          }
        };
        #ok(Text.trimEnd(t, #text(" ")) # "]");
      };
      case(#Map(val)){
        var t = "{";
        for(thisItem in val.vals()){
          switch(candySharedToText(thisItem.1)){
            case(#ok(text)){
              t := t # thisItem.0 # ": " # text # "; ";
            };
            case(#err(e)){ return #err(e) };
          }
        };
        #ok(Text.trimEnd(t, #text(" ")) # "}");
      };
      case(#ValueMap(val)){
        var t = "{";
        for(thisItem in val.vals()){
          switch(candySharedToText(thisItem.0)){
            case(#ok(keyText)){
              switch(candySharedToText(thisItem.1)){
                case(#ok(valueText)){
                  t := t # keyText # ": " # valueText # "; ";
                };
                case(#err(e)){ return #err(e) };
              }
            };
            case(#err(e)){ return #err(e) };
          }
        };
        #ok(Text.trimEnd(t, #text(" ")) # "}");
      };
      case(_){ #err("illegal cast to Text") };
    };
  };

  /// Convert a `CandyShared` to `Principal`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Principal(Principal.fromText("abc"));
  /// let converted_value = Conversion.candySharedToPrincipal(value);
  /// ```
  
  public func candySharedToPrincipal(val : CandyShared) : Result.Result<Principal, Text> {
    switch(val){
      case(#Principal(val)){ #ok(val) };
      case(#Text(val)){
        switch(PrincipalExt.fromText(val)){
          case(?principal){ return #ok(principal) };
          case(null){ return #err("invalid principal") };
        }
      };
      case(#Blob(val)){
        if (val.size() > 29){ 
          return #err("invalid blob size for Principal");
        };
        #ok(Principal.fromBlob(val));
      };
      case(#Bytes(val)){
        if(val.size() > 29){ 
          return #err("invalid bytes size for Principal");
        };
        #ok(Principal.fromBlob(Blob.fromArray(val)));
      };
      case(_){ #err("illegal cast to Principal") };
    };
  };

  /// Convert a `CandyShared` to `Bool`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Bool(true);
  /// let converted_value = Conversion.candySharedToBool(value);
  /// ```
  
  public func candySharedToBool(val : CandyShared) : Result.Result<Bool, Text> {
    switch(val){
      case(#Bool(val)){ #ok(val) };
      case(#Text(val)){
        switch (Text.trimEnd(val, #text(" "))) {
          case("true"){ #ok(true) };
          case("false"){ #ok(false) };
          case(_){ #err("illegal cast to Bool") };
        }
      };
      case(_){ #err("illegal cast to Bool") };
    };
  };

  /// Convert a `CandyShared` to `Blob`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Principal(Principal.fromText("abc"));
  /// let converted_value = Conversion.candySharedToBlob(value);
  /// ```
  public func candySharedToBlob(val : CandyShared) : Result.Result<Blob, Text> {
    switch(val){
      case(#Blob(val)){ #ok(val) };
      case(#Bytes(val)){ #ok(Blob.fromArray(val)) };
      case(#Text(val)){ #ok(Blob.fromArray(textToBytes(val))) };
      case(#Int(val)){ #ok(Blob.fromArray(intToBytes(val))) };
      case(#Nat(val)){ #ok(Blob.fromArray(natToBytes(val))) };
      case(#Nat8(val)){ #ok(Blob.fromArray([val])) };
      case(#Nat16(val)){ #ok(Blob.fromArray(nat16ToBytes(val))) };
      case(#Nat32(val)){ #ok(Blob.fromArray(nat32ToBytes(val))) };
      case(#Nat64(val)){ #ok(Blob.fromArray(nat64ToBytes(val))) };
      case(#Principal(val)){ #ok(Principal.toBlob(val)) };
      case(_){ #err("illegal cast to Blob") };
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
  
  public func candySharedToValueArray(val : CandyShared) : Result.Result<[CandyShared], Text> {
    switch(val){
      case(#Array(val)){ #ok(val) };
      case(_){ #err("illegal cast to [CandyShared]") };
    };
  };

  /// Convert a `CandyShared` to Bytes(`[Nat8]`)
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Principal(Principal.fromText("abc"));
  /// let value_as_bytes = Conversion.candySharedToBytes(value);
  /// ```
  public func candySharedToBytes(val : CandyShared) : Result.Result<[Nat8], Text> {
    switch(val){
      case(#Int(val)){
        #ok(intToBytes(val));
      };
      case(#Int8(val)){
        switch (candySharedToInt(#Int8(val))) {
          case (#ok(intVal)) {
            #ok(intToBytes(intVal));
          };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Int16(val)){
        switch (candySharedToInt(#Int16(val))) {
          case (#ok(intVal)) {
            #ok(intToBytes(intVal));
          };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Int32(val)){
        switch (candySharedToInt(#Int32(val))) {
          case (#ok(intVal)) {
            #ok(intToBytes(intVal));
          };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Int64(val)){
        switch (candySharedToInt(#Int64(val))) {
          case (#ok(intVal)) {
             #ok(intToBytes(intVal));
          };
          case (#err(e)) { #err(e) };
        }
      };
      case(#Nat(val)){
        #ok(natToBytes(val))
      };
      case(#Nat8(val)){ #ok([val]) };
      case(#Nat16(val)){
        #ok(nat16ToBytes(val))
      };
      case(#Nat32(val)){
        #ok(nat32ToBytes(val))
      };
      case(#Nat64(val)){
        #ok(nat64ToBytes(val))
      };
      case(#Float(val)){ #err("conversion from Float to Bytes not implemented") };
      case(#Text(val)){
        #ok(textToBytes(val))
      };
      case(#Bool(val)){
        #ok(boolToBytes(val))
      };
      case(#Blob(val)){ #ok(Blob.toArray(val)) };
      case(#Class(val)){ #err("conversion from Class to Bytes not implemented") };
      case(#Principal(val)){
        #ok(principalToBytes(val))
      };
      case(#Option(val)){ #err("conversion from Option to Bytes not implemented") };
      case(#Array(val)){ #err("conversion from Array to Bytes not implemented") };
      case(#Bytes(val)){ #ok(val) };
      case(#Floats(val)){ #err("conversion from Floats to Bytes not implemented") };
      case(#Nats(val)){ #err("conversion from Nats to Bytes not implemented") };
      case(#Ints(val)){ #err("conversion from Ints to Bytes not implemented") };
      case(#ValueMap(val)){ #err("conversion from ValueMap to Bytes not implemented") };
      case(#Map(val)){ #err("conversion from Map to Bytes not implemented") };
      case(#Set(val)){ #err("conversion from Set to Bytes not implemented") };
    };
  };

  /// Convert a `CandyShared` to `Buffer<Nat8>`
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Principal(Principal.fromText("abc"));
  /// let value_as_buffer = Conversion.candySharedToBytes(value);
  /// ```
  ///
  
  public func candySharedToBytesBuffer(val : CandyShared) : Result.Result<Buffer.Buffer<Nat8>, Text> {
    switch (val){
      case(#Bytes(val)){ #ok(toBuffer(val)) };
      case(_){
        switch (candySharedToBytes(val)) {
          case (#ok(bytes)) { #ok(toBuffer<Nat8>(bytes)) };
          case (#err(e)) { #err(e) };
        }
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

  /// Convert a `CandyShared` to `Buffer<Float>`
  ///
  /// Example:
  /// ```motoko include=import
  /// let value: CandyShared = #Nat(102);
  /// let value_as_floats_buffer = Conversion.candySharedToFloatsBuffer(value);
  /// ```
  
  public func candySharedToFloatsBuffer(val : CandyShared) : Result.Result<Buffer.Buffer<Float>, Text> {
    switch (val){
      case(#Floats(val)){ #ok(toBuffer(val)) };
      case(_){
        switch (candySharedToFloat(val)) {
          case (#ok(float)) { #ok(toBuffer([float])) };
          case (#err(e)) { #err(e) };
        }
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
  
  public func candySharedToNatsBuffer(val : CandyShared) : Result.Result<Buffer.Buffer<Nat>, Text> {
    switch (val){
      case(#Nats(val)){ #ok(toBuffer(val)) };
      case(_){
        switch (candySharedToNat(val)) {
          case (#ok(nat)) { #ok(toBuffer([nat])) };
          case (#err(e)) { #err(e) };
        }
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
  
  public func candySharedToIntsBuffer(val : CandyShared) : Result.Result<Buffer.Buffer<Int>, Text> {
    switch (val){
      case(#Ints(val)){ #ok(toBuffer(val)) };
      case(_){
        switch (candySharedToInt(val)) {
          case (#ok(int)) { #ok(toBuffer([int])) };
          case (#err(e)) { #err(e) };
        }
      };
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
  public func candySharedToProperties(val : CandyShared) : Result.Result<Types.PropertiesShared, Text> {
    switch(val){
      case(#Class(val)){ #ok(val) };
      case(#Map(val)){ #ok(
        Array.map<(Text, Types.CandyShared), Types.PropertyShared>(val, func(a,b){
          {
            name = a;
            value = b;
            immutable = true; // default to true
          };
        }))};
      case(_){ #err("illegal cast to PropertiesShared") };
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
          switch (bytesToNat32(Array.freeze<Nat8>(aChar))) {
            case (#ok(nat32)) { result := result # Char.toText(Char.fromNat32(nat32)); };
            case (#err(e)) { result := result # "�"; }; // Use a placeholder for error cases
          };
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
    if(_bytes.size() == 0){
      return false; // invalid size
    };
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
  public func bytesToInt(_bytes : [Nat8]) : Result.Result<Int, Text> {
    if (_bytes.size() < 1) {
      return #err("Invalid byte array size for conversion to Int");
    };

    if (_bytes.size()==1 and _bytes[0] == 0) {
      return #ok(0); // special case for single byte zero
    };

    if (_bytes.size() < 2) {
      return #err("Invalid byte array size for conversion to Int");
    };

    var n : Int = 0;
    var i = 0;
    let natBytes = Array.tabulate<Nat8>(_bytes.size() - 1, func(idx) { _bytes[idx + 1] });

    Array.foldRight<Nat8, ()>(natBytes, (), func(byte, _) {
      n += Nat8.toNat(byte) * (128 ** i);
      i += 1;
      return;
    });

    if (_bytes[0] == 1) {
      n *= -1;
    };

    return #ok(n);
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
  public func unwrapOptionCandy(val : Candy): Result.Result<Candy, Text> {
    switch(val){
      case(#Option(val)){
          switch(val){
              case(null){
                  #err("option is null");
              };
              case(?val){
                  #ok(val);
              }
          };
      };
      case(otherVal){ return(#ok(val)) };
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
  public func unwrapOptionCandyShared(val : CandyShared): Result.Result<CandyShared, Text> {
    switch(val){
      case(#Option(val)){
          switch(val){
              case(null){
                  #err("option is null");
              };
              case(?val){
                  #ok(val);
              }
          };
      };
      case(otherVal){ #ok(val) };
    };
  };

  ///converts a candyshared value to the reduced set of ValueShared used in many places like ICRC3.  Some types not recoverable
  public func candySharedToValue(x: CandyShared) : ValueShared {
    switch(x){
      case(#Text(x)) #Text(x);
      case(#Map(x)) {
        let buf = Buffer.Buffer<(Text, ValueShared)>(1);
        for(thisItem in x.vals()){
          buf.add((thisItem.0, candySharedToValue(thisItem.1)));
        };
        #Map(Buffer.toArray(buf));
      };
      case(#Class(x)) {
        let buf = Buffer.Buffer<(Text, ValueShared)>(1);
        for(thisItem in x.vals()){
          buf.add((thisItem.name, candySharedToValue(thisItem.value)));
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
        #Array(Array.map<CandyShared, ValueShared>(x, candySharedToValue));
      };
      case(#Blob(x)) #Blob(x);
      case(#Bool(x)) #Blob(Blob.fromArray([if(x==true){1 : Nat8} else {0: Nat8}]));
      case(#Float(x)){#Text(Float.format(#exact, x))};
      case(#Floats(x)){
        #Array(Array.map<Float,ValueShared>(x, func(x: Float) : ValueShared { candySharedToValue(#Float(x))}));
      };
      case(#Option(x)){ //empty array is null
        switch(x){
          case(null) #Array([]);
          case(?x) #Array([candySharedToValue(x)]);
        };
      };
      case(#Principal(x)){
        #Blob(Principal.toBlob(x));
      };
      case(#Set(x)) {
        #Array(Array.map<CandyShared,ValueShared>(x, func(x: CandyShared) : ValueShared { candySharedToValue(x)}));
      };
      case(#ValueMap(x)) {
        #Array(Array.map<(CandyShared,CandyShared),ValueShared>(x, func(x: (CandyShared,CandyShared)) : ValueShared { #Array([candySharedToValue(x.0), candySharedToValue(x.1)])}));
      };
      //case(_){assert(false);/*unreachable*/#Nat(0);};
    };

    
  };

  ///converts a candy value to the reduced set of ValueShared used in many places like ICRC3.  Some types not recoverable
  public func candyToValue(x: Candy) : ValueShared {
    switch(x){
      case(#Text(x)) #Text(x);
      case(#Map(x)) {
        let buf = Buffer.Buffer<(Text, ValueShared)>(1);
        for(thisItem in Map.entries(x)){
          buf.add((thisItem.0, candyToValue(thisItem.1)));
        };
        #Map(Buffer.toArray(buf));
      };
      case(#Class(x)) {
        let buf = Buffer.Buffer<(Text, ValueShared)>(1);
        for(thisItem in Map.entries(x)){
          buf.add((thisItem.1.name, candyToValue(thisItem.1.value)));
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
        #Array(StableBuffer.toArray<ValueShared>(StableBuffer.map<Candy, ValueShared>(x, candyToValue)));
      };
      case(#Blob(x)) #Blob(x);
      case(#Bool(x)) #Blob(Blob.fromArray([if(x==true){1 : Nat8} else {0: Nat8}]));
      case(#Float(x)){#Text(Float.format(#exact, x))};
      case(#Floats(x)){
        #Array(StableBuffer.toArray<ValueShared>(StableBuffer.map<Float,ValueShared>(x, func(x: Float) : ValueShared { candyToValue(#Float(x))})));
      };
      case(#Option(x)){ //empty array is null
        switch(x){
          case(null) #Array([]);
          case(?x) #Array([candyToValue(x)]);
        };
      };
      case(#Principal(x)){
        #Blob(Principal.toBlob(x));
      };
      case(#Set(x)) {
        #Array(Iter.toArray<ValueShared>(Iter.map<Candy,ValueShared>(Set.keys(x), func(x: Candy) : ValueShared { candyToValue(x)})));
      };
      case(#ValueMap(x)) {
        #Array(Iter.toArray<ValueShared>(Iter.map<(Candy,Candy),ValueShared>(Map.entries(x), func(x: (Candy,Candy)) : ValueShared { #Array([candyToValue(x.0), candyToValue(x.1)])})));
      };
      //case(_){assert(false);/*unreachable*/#Nat(0);};
    };

    

    
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
  public func bytesToNat16(bytes: [Nat8]) : Result.Result<Nat16, Text> {
    if (bytes.size() < 2) {
      // If less than required, use bytesToNat and convert to Nat16
      let natValue = bytesToNat(bytes);
      if (natValue <= Nat16.toNat(Nat16.maximumValue)) {
        return #ok(Nat16.fromNat(natValue));
      } else {
        return #err("overflow while converting bytes to Nat16");
      }
    } else if (bytes.size() > 2) {
      // If too large, return an error
      return #err("too many bytes to convert to Nat16");
    } else {
      // If exactly 2 bytes, perform the conversion
      return #ok(
        (Nat16.fromNat(Nat8.toNat(bytes[0])) << 8) +
        (Nat16.fromNat(Nat8.toNat(bytes[1])))
      );
    }
  };

  /// Convert Bytes(`[Nat8]`) to `Nat32`
  ///
  /// Example:
  /// ```motoko include=import
  ///  let bytes: [Nat8] = [1, 2, 3, 4];
  ///  let value = Conversion.bytesToNat32(bytes);
  /// ```
  public func bytesToNat32(bytes: [Nat8]) : Result.Result<Nat32, Text> {
    if (bytes.size() < 4) {
      // If less than required, use bytesToNat and convert to Nat32
      let natValue = bytesToNat(bytes);
      if (natValue <= Nat32.toNat(Nat32.maximumValue)) {
        return #ok(Nat32.fromNat(natValue));
      } else {
        return #err("overflow while converting bytes to Nat32");
      }
    } else if (bytes.size() > 4) {
      // If too large, return an error
      return #err("too many bytes to convert to Nat32");
    } else {
      // If exactly 4 bytes, perform the conversion
      return #ok(
        (Nat32.fromNat(Nat8.toNat(bytes[0])) << 24) +
        (Nat32.fromNat(Nat8.toNat(bytes[1])) << 16) +
        (Nat32.fromNat(Nat8.toNat(bytes[2])) << 8) +
        (Nat32.fromNat(Nat8.toNat(bytes[3])))
      );
    }
  };

  /// Convert Bytes(`[Nat8]`) to `Nat64`
  ///
  /// Example:
  /// ```motoko include=import
  ///  let bytes: [Nat8] = [1, 2, 3, 4];
  ///  let value = Conversion.bytesToNat64(bytes);
  /// ```
  public func bytesToNat64(bytes: [Nat8]) : Result.Result<Nat64, Text> {
    if (bytes.size() < 8) {
      // If less than required, use bytesToNat and convert to Nat64
      let natValue = bytesToNat(bytes);
      if (natValue <= Nat64.toNat(Nat64.maximumValue)) {
        return #ok(Nat64.fromNat(natValue));
      } else {
        return #err("overflow while converting bytes to Nat64");
      }
    } else if (bytes.size() > 8) {
      // If too large, return an error
      return #err("too many bytes to convert to Nat64");
    } else {
      // If exactly 8 bytes, perform the conversion
      return #ok(
        (Nat64.fromNat(Nat8.toNat(bytes[0])) << 56) +
        (Nat64.fromNat(Nat8.toNat(bytes[1])) << 48) +
        (Nat64.fromNat(Nat8.toNat(bytes[2])) << 40) +
        (Nat64.fromNat(Nat8.toNat(bytes[3])) << 32) +
        (Nat64.fromNat(Nat8.toNat(bytes[4])) << 24) +
        (Nat64.fromNat(Nat8.toNat(bytes[5])) << 16) +
        (Nat64.fromNat(Nat8.toNat(bytes[6])) << 8) +
        (Nat64.fromNat(Nat8.toNat(bytes[7])))
      );
    }
  };

  /// Convert Bytes(`[Nat8]`) to `Nat`
  ///
  /// Example:
  /// ```motoko include=import
  ///  let bytes: [Nat8] = [1, 2, 3, 4];
  ///  let value = Conversion.bytesToNat(bytes);
  /// ```
  public func bytesToNat(bytes : [Nat8]) : Nat {
    if(bytes.size() == 0) {
      return 0; // empty array
    };
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
    Iter.iterate(Text.toIter(phrase), func (x : Char, n : Nat) {
      if (x >= '0' and x <= '9') {
        theSum := theSum + ((Nat32.toNat(Char.toNat32(x)) - Nat32.toNat(Char.toNat32('0'))) * 10 ** (phrase.size() - n - 1));
      } else {
        return; // Ignore non-digit characters
      };
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
          if (v >= '0' and v <= '9') {
              let charToNum = Nat32.toNat(Char.toNat32(v) - Char.toNat32('0'));
              num := num * 10 + charToNum;
          } else {
              return null;
          };
      };
      ?num;
    }else {
      return null;
    };
  };
}
