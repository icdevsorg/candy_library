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

/// Upgrade utilities for the candy library.
///
/// This module contains the utility functions to upgrade candy values from version 1 to version 2.

import CandyOld "mo:candy_0_1_12/types";
import Candy0_2_0 "mo:candy_0_2_0/types";
import CandyTypes "types";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Buffer "mo:base/Buffer";
import Map7 "mo:map7/Map";
import Set7 "mo:map7/Set";
import Map "mo:map9/Map";
import Set "mo:map9/Set";
import StableBuffer_Old "mo:stablebuffer/StableBuffer";
import StableBuffer "mo:stablebuffer_1_3_0/StableBuffer";

module {

  public func toBufferOld<T>(x :[T]) : StableBuffer_Old.StableBuffer<T>{
    let thisBuffer = StableBuffer_Old.initPresized<T>(x.size());
    for(thisItem in x.vals()){
      StableBuffer_Old.add(thisBuffer,thisItem);
    };
    return thisBuffer;
  };

  /// Upgrade from V1 representation of `CandyShared` to the V2 representation.
  public func upgradeCandy0_1_2_to_0_2_0(item : CandyOld.CandyValueUnstable) : Candy0_2_0.Candy {
    switch (item) {
      case (#Int(val)) { #Int(val) };
      case (#Int8(val)) { #Int8(val) };
      case (#Int16(val)) { #Int16(val) };
      case (#Int32(val)) { #Int32(val) };
      case (#Int64(val)) { #Int64(val) };
      case (#Nat(val)) { #Nat(val) };
      case (#Nat8(val)) { #Nat8(val) };
      case (#Nat16(val)) { #Nat16(val) };
      case (#Nat32(val)) { #Nat32(val) };
      case (#Nat64(val)) { #Nat64(val) };
      case (#Float(val)) { #Float(val) };
      case (#Text(val)) { #Text(val) };
      case (#Bool(val)) { #Bool(val) };
      case (#Blob(val)) { #Blob(val) };
      case (#Class(val)) {
        let iter = Iter.map<CandyOld.PropertyUnstable, (Text, Candy0_2_0.Property)>(
            val.vals(),
            func(x) {(x.name,
              {
                x with value = upgradeCandy0_1_2_to_0_2_0(x.value)
              });
            },
          );

        #Class(
          Map7.fromIter<Text, Candy0_2_0.Property>(iter,
        Map7.thash));
      };
      case (#Principal(val)) { #Principal(val) };
      case (#Array(val)) {
        switch (val) {
          case (#frozen(val)) {
            #Array(Candy0_2_0.toBuffer(Array.map<CandyOld.CandyValueUnstable, Candy0_2_0.Candy>(val, upgradeCandy0_1_2_to_0_2_0)));
          };
          case (#thawed(val)) {
            #Array(Candy0_2_0.toBuffer(Array.map<CandyOld.CandyValueUnstable, Candy0_2_0.Candy>(Buffer.toArray(val), upgradeCandy0_1_2_to_0_2_0)));
          };
        };
      };
      case (#Bytes(val)) {
        switch (val) {
          case (#frozen(val)) { #Bytes(toBufferOld(val)) };
          case (#thawed(val)) { #Bytes(toBufferOld(Buffer.toArray(val))) };
        };
      };
      case (#Floats(val)) {
        switch (val) {
          case (#frozen(val)) { #Floats(toBufferOld(val)) };
          case (#thawed(val)) { #Floats(toBufferOld(Buffer.toArray(val))) };
        };
      };
      case (#Nats(val)) {
        switch (val) {
          case (#frozen(val)) { #Nats(toBufferOld(val)) };
          case (#thawed(val)) { #Nats(toBufferOld(Buffer.toArray(val))) };
        };
      };
      
      case (#Option(val)) {
        switch (val) {
          case (null) { #Option(null) };
          case (?val) { #Option(?upgradeCandy0_1_2_to_0_2_0(val)) };
        };
      };
      
      case (#Empty) { #Option(null) };
    };
  };

  /// Upgrade from V1 representation of `CandySharedUnstable` to the V2 representation 'CandyValudShared'.
  public func upgradeCandyShared0_1_2_to_0_2_0(item : CandyOld.CandyValue) : Candy0_2_0.CandyShared {
    switch (item) {
      case (#Int(val)) { #Int(val) };
      case (#Int8(val)) { #Int8(val) };
      case (#Int16(val)) { #Int16(val) };
      case (#Int32(val)) { #Int32(val) };
      case (#Int64(val)) { #Int64(val) };
      case (#Nat(val)) { #Nat(val) };
      case (#Nat8(val)) { #Nat8(val) };
      case (#Nat16(val)) { #Nat16(val) };
      case (#Nat32(val)) { #Nat32(val) };
      case (#Nat64(val)) { #Nat64(val) };
      case (#Float(val)) { #Float(val) };
      case (#Text(val)) { #Text(val) };
      case (#Bool(val)) { #Bool(val) };
      case (#Blob(val)) { #Blob(val) };
      case (#Class(val)) {
        #Class(
          Array.map<CandyOld.Property, Candy0_2_0.PropertyShared>(
            val,
            func(x) {
              {
                x with value = upgradeCandyShared0_1_2_to_0_2_0(x.value)
              };
            },
          ),
        );
      };
      case (#Principal(val)) { #Principal(val) };
      case (#Array(val)) {
        switch (val) {
          case (#frozen(val)) {
            #Array(Array.map<CandyOld.CandyValue, Candy0_2_0.CandyShared>(val, upgradeCandyShared0_1_2_to_0_2_0));
          };
          case (#thawed(val)) {
            #Array(Array.map<CandyOld.CandyValue, Candy0_2_0.CandyShared>(Iter.toArray(val.vals()), upgradeCandyShared0_1_2_to_0_2_0));
          };
        };
      };
      case (#Option(val)) {
        switch (val) {
          case (null) { #Option(null) };
          case (?val) { #Option(?upgradeCandyShared0_1_2_to_0_2_0(val)) };
        };
      };
      case (#Bytes(val)) {
        switch (val) {
          case (#frozen(val)) { #Bytes(val) };
          case (#thawed(val)) { #Bytes(val) };
        };
      };
      case (#Floats(val)) {
        switch (val) {
          case (#frozen(val)) { #Floats(val) };
          case (#thawed(val)) { #Floats(val) };
        };
      };
      case (#Nats(val)) {
        switch (val) {
          case (#frozen(val)) { #Nats(val) };
          case (#thawed(val)) { #Nats(val) };
        };
      };
      
      case (#Empty) { #Option(null) };
    };
  };


  /// Upgrade from V2 representation of `CandyShared` to the V3 representation.
  public func upgradeCandy0_2_0_to_0_3_0(item : Candy0_2_0.Candy) : CandyTypes.Candy {
    switch (item) {
      case (#Int(val)) { #Int(val) };
      case (#Int8(val)) { #Int8(val) };
      case (#Int16(val)) { #Int16(val) };
      case (#Int32(val)) { #Int32(val) };
      case (#Int64(val)) { #Int64(val) };
      case (#Ints(val)) { #Ints(StableBuffer.fromArray(StableBuffer_Old.toArray(val))) };
      case (#Nat(val)) { #Nat(val) };
      case (#Nat8(val)) { #Nat8(val) };
      case (#Nat16(val)) { #Nat16(val) };
      case (#Nat32(val)) { #Nat32(val) };
      case (#Nat64(val)) { #Nat64(val) };
      case (#Float(val)) { #Float(val) };
      case (#Text(val)) { #Text(val) };
      case (#Bool(val)) { #Bool(val) };
      case (#Blob(val)) { #Blob(val) };
      case (#Class(val)) { 
        let iter = Iter.map<Candy0_2_0.Property, (Text, CandyTypes.Property)>(
            Map7.vals(val),
            func(x) {(x.name,
              {
                x with value = upgradeCandy0_2_0_to_0_3_0(x.value)
              });
            },
          );

        #Class(
          Map.fromIter<Text, CandyTypes.Property>(iter,
        Map.thash));
      };
      case (#Principal(val)) { #Principal(val) };
      case (#Array(val)) {
        #Array(CandyTypes.toBuffer(Array.map<Candy0_2_0.Candy, CandyTypes.Candy>(StableBuffer_Old.toArray(val), upgradeCandy0_2_0_to_0_3_0)));
      };
      case (#Bytes(val)) {#Bytes(StableBuffer.fromArray(StableBuffer_Old.toArray(val)))};
      case (#Floats(val)) {#Floats(StableBuffer.fromArray(StableBuffer_Old.toArray(val)))};
      case (#Nats(val)) {#Nats(StableBuffer.fromArray(StableBuffer_Old.toArray(val)))};
      case (#Option(val)) {
        switch(val){
          case(null) #Option(null);
          case(?val){
            #Option(?upgradeCandy0_2_0_to_0_3_0(val));
          };
        };
      };
      case (#Map(val)) { 
        let iter = Iter.map<(Candy0_2_0.Candy, Candy0_2_0.Candy), (CandyTypes.Candy, CandyTypes.Candy)>(
            Map7.entries(val),
            func(x) {(upgradeCandy0_2_0_to_0_3_0(x.0), upgradeCandy0_2_0_to_0_3_0(x.1));
            },
          );
        #ValueMap(Map.fromIter<CandyTypes.Candy, CandyTypes.Candy>(iter,
        CandyTypes.candyMapHashTool))};
      case (#Set(val)) { 
        #Set(Set.fromIter<CandyTypes.Candy>(Iter.map<Candy0_2_0.Candy, CandyTypes.Candy>(Set7.keys(val), upgradeCandy0_2_0_to_0_3_0), CandyTypes.candyMapHashTool));
      };
    };
  };

  /// Upgrade from V1 representation of `CandySharedUnstable` to the V2 representation 'CandyValudShared'.
  public func upgradeCandyShared0_2_0_to_0_3_0(item : Candy0_2_0.CandyShared) : CandyTypes.CandyShared {

    switch (item) {
      case (#Int(val)) { #Int(val) };
      case (#Int8(val)) { #Int8(val) };
      case (#Int16(val)) { #Int16(val) };
      case (#Int32(val)) { #Int32(val) };
      case (#Int64(val)) { #Int64(val) };
      case (#Ints(val)) { #Ints(val) };
      case (#Nat(val)) { #Nat(val) };
      case (#Nat8(val)) { #Nat8(val) };
      case (#Nat16(val)) { #Nat16(val) };
      case (#Nat32(val)) { #Nat32(val) };
      case (#Nat64(val)) { #Nat64(val) };
      case (#Float(val)) { #Float(val) };
      case (#Text(val)) { #Text(val) };
      case (#Bool(val)) { #Bool(val) };
      case (#Blob(val)) { #Blob(val) };
      case (#Class(val)) { 
        #Class(
        Array.map<Candy0_2_0.PropertyShared, CandyTypes.PropertyShared>(
            val,
            func(x) {
              {
                x with value = upgradeCandyShared0_2_0_to_0_3_0(x.value)
              };
            },
          ));
      };
      case (#Principal(val)) { #Principal(val) };
      case (#Array(val)) {
        #Array(Array.map<Candy0_2_0.CandyShared, CandyTypes.CandyShared>(val, upgradeCandyShared0_2_0_to_0_3_0));
      };
      case (#Bytes(val)) {#Bytes(val)};
      case (#Floats(val)) {#Floats(val)};
      case (#Nats(val)) {#Nats(val)};
      case (#Option(val)) {
        switch(val){
          case(null) #Option(null);
          case(?val){
            #Option(?upgradeCandyShared0_2_0_to_0_3_0(val));
          };
        };
      };
      case (#Map(val)) { 
        let iter = Iter.map<(Candy0_2_0.CandyShared, Candy0_2_0.CandyShared), (CandyTypes.CandyShared, CandyTypes.CandyShared)>(
            val.vals(),
            func(x) {(upgradeCandyShared0_2_0_to_0_3_0(x.0), upgradeCandyShared0_2_0_to_0_3_0(x.1));
            },
          );
        #ValueMap(Iter.toArray< (CandyTypes.CandyShared, CandyTypes.CandyShared)>(iter))};
      case (#Set(val)) { 
        let iter = Iter.map<(Candy0_2_0.CandyShared), (CandyTypes.CandyShared)>(
            val.vals(),
            upgradeCandyShared0_2_0_to_0_3_0,
          );
        #Set(Iter.toArray< CandyTypes.CandyShared>(iter))};
      };
    };
};
