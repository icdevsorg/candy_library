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
import CandyTypes "types";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Buffer "mo:base/Buffer";
import Map "mo:map7/Map";

module {

  /// Upgrade from V1 representation of `CandyShared` to the V2 representation.
  public func upgradeCandy(item : CandyOld.CandyValueUnstable) : CandyTypes.Candy {
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
        let iter = Iter.map<CandyOld.PropertyUnstable, (Text, CandyTypes.Property)>(
            val.vals(),
            func(x) {(x.name,
              {
                x with value = upgradeCandy(x.value)
              });
            },
          );

        #Class(
          Map.fromIter<Text, CandyTypes.Property>(iter,
        Map.thash));
      };
      case (#Principal(val)) { #Principal(val) };
      case (#Array(val)) {
        switch (val) {
          case (#frozen(val)) {
            #Array(CandyTypes.toBuffer(Array.map<CandyOld.CandyValueUnstable, CandyTypes.Candy>(val, upgradeCandy)));
          };
          case (#thawed(val)) {
            #Array(CandyTypes.toBuffer(Array.map<CandyOld.CandyValueUnstable, CandyTypes.Candy>(Buffer.toArray(val), upgradeCandy)));
          };
        };
      };
      case (#Bytes(val)) {
        switch (val) {
          case (#frozen(val)) { #Bytes(CandyTypes.toBuffer(val)) };
          case (#thawed(val)) { #Bytes(CandyTypes.toBuffer(Buffer.toArray(val))) };
        };
      };
      case (#Floats(val)) {
        switch (val) {
          case (#frozen(val)) { #Floats(CandyTypes.toBuffer(val)) };
          case (#thawed(val)) { #Floats(CandyTypes.toBuffer(Buffer.toArray(val))) };
        };
      };
      case (#Nats(val)) {
        switch (val) {
          case (#frozen(val)) { #Nats(CandyTypes.toBuffer(val)) };
          case (#thawed(val)) { #Nats(CandyTypes.toBuffer(Buffer.toArray(val))) };
        };
      };
      
      case (#Option(val)) {
        switch (val) {
          case (null) { #Option(null) };
          case (?val) { #Option(?upgradeCandy(val)) };
        };
      };
      
      case (#Empty) { #Option(null) };
    };
  };

  /// Upgrade from V1 representation of `CandySharedUnstable` to the V2 representation 'CandyValudShared'.
  public func upgradeCandyShared(item : CandyOld.CandyValue) : CandyTypes.CandyShared {
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
          Array.map<CandyOld.Property, CandyTypes.PropertyShared>(
            val,
            func(x) {
              {
                x with value = upgradeCandyShared(x.value)
              };
            },
          ),
        );
      };
      case (#Principal(val)) { #Principal(val) };
      case (#Array(val)) {
        switch (val) {
          case (#frozen(val)) {
            #Array(Array.map<CandyOld.CandyValue, CandyTypes.CandyShared>(val, upgradeCandyShared));
          };
          case (#thawed(val)) {
            #Array(Array.map<CandyOld.CandyValue, CandyTypes.CandyShared>(Iter.toArray(val.vals()), upgradeCandyShared));
          };
        };
      };
      case (#Option(val)) {
        switch (val) {
          case (null) { #Option(null) };
          case (?val) { #Option(?upgradeCandyShared(val)) };
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
};
