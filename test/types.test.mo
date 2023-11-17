import D "mo:base/Debug";
import {test} "mo:test";
import Types "../src/types";
import Conv "../src/conversion";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import StableBuffer "mo:stablebuffer_1_3_0/StableBuffer";
import Array "mo:base/Array";
import Nat8 "mo:base/Nat8";

type Candy = Types.Candy;
type CandyShared = Types.CandyShared;

// Test Instances
let principal = Principal.fromText("rrkah-fqaaa-aaaaa-aaaaq-cai");
let natValue: Nat = 42;
let arrayValue: [Candy] = [#Nat(natValue)];
let bufferValue: StableBuffer.StableBuffer<Nat> = StableBuffer.fromArray<Nat>([natValue]);

// Test `Types` Module
test("shareCandy should convert Candy to CandyShared preserving the structure", func() {
  let original: Candy = #Principal(principal);
  let shared_: CandyShared = Types.shareCandy(original);
  switch(shared_) {
    case (#Principal(p)) {
      assert(p == principal);
    };
    case (_) {
      return assert(false);
    };
  };
});

test("unshare should convert CandyShared to Candy preserving the structure", func() {
  let shared_: CandyShared = #Principal(principal);
  let original: Candy = Types.unshare(shared_);
  switch(original) {
    case (#Principal(p)) {
      assert(p == principal);
    };
    case (_) {
      return assert(false);
    };
  };
});

test("shareProperty should convert Property to PropertyShared preserving the structure", func() {
  let property: Types.Property = {name = "testProp"; value = #Nat(natValue); immutable = true};
  let sharedProperty: Types.PropertyShared = Types.shareProperty(property);
  assert(sharedProperty.name ==property.name);
  assert(sharedProperty.immutable == property.immutable);
  switch(sharedProperty.value) {
    case (#Nat(n)) {
      assert(n == natValue);
    };
    case (_) {
      return assert(false);
    };
  };
});

test("unshareProperty should convert PropertyShared to Property preserving the structure", func() {
  let sharedProperty: Types.PropertyShared = {name = "testProp"; value = #Nat(natValue); immutable = true};
  let property: Types.Property = Types.unshareProperty(sharedProperty);
  assert(property.name ==sharedProperty.name);
  assert(property.immutable ==sharedProperty.immutable);
  switch(property.value) {
    case (#Nat(n)) {
      assert(n == natValue);
    };
    case (_) {
      return assert(false);
    };
  };
});

test("shareCandyArray should convert list of Candy to list of CandyShared", func() {
  let sharedArray: [CandyShared] = Types.shareCandyArray(arrayValue);
  for (value in Array.vals(sharedArray)) {
    switch(value) {
      case (#Nat(n)) {
        assert(n == natValue);
      };
      case (_) {
        return assert(false);
      };
    };
  };
});

test("unshareArray should convert list of CandyShared to list of Candy", func() {
  let sharedArray: [CandyShared] = Types.shareCandyArray(arrayValue);
  let originalArray: [Candy] = Types.unshareArray(sharedArray);
  for (value in Array.vals(originalArray)) {
    switch(value) {
      case (#Nat(n)) {
        assert(n == natValue);
      };
      case (_) {
        return assert(false);
      };
    };
  };
});

test("shareCandyBuffer should convert a DataZone to an array of CandyShared", func() {
  let dataZone: Types.DataZone = StableBuffer.fromArray<Candy>(arrayValue);
  let sharedBuffer: [CandyShared] = Types.shareCandyBuffer(dataZone);
  for (value in sharedBuffer.vals()) {
    switch(value) {
      case (#Nat(n)) {
        assert(n == natValue);
      };
      case (_) {
        return assert(false);
      };
    };
  };
});

test("toBuffer should convert an array to a stable buffer of the same elements", func() {
  let buffer: StableBuffer.StableBuffer<Nat> = Types.toBuffer<Nat>([natValue]);
  assert(StableBuffer.get(buffer, 0) == natValue);
});

test("hash function should produce consistent hash codes for Candy", func() {
  let original: Candy = #Nat(natValue);
  let hashCode1: Nat32 = Types.hash(original);
  let hashCode2: Nat32 = Types.hash(original);
  assert(hashCode1 == hashCode2);
});

test("nat32ToBytes should convert Nat32 to a byte array representation", func() {
  let value = 42 : Nat32;
  let bytes = Conv.nat32ToBytes(value);
  let expectedBytes: [Nat8] = [0, 0, 0, 42];
  assert(Array.equal<Nat8>(bytes, expectedBytes, Nat8.equal));
});

test("eq function should compare two Candy for equality", func() {
  let candy1: Candy = #Nat(natValue);
  let candy2: Candy = #Nat(natValue);
  let unequalCandy: Candy = #Nat(natValue + 1);
  assert(Types.eq(candy1, candy2) == true);
  assert(Types.eq(candy1, unequalCandy) == false);
});

test("candyMapHashTool should provide hash and equality functions for Candy", func() {
  let candy: Candy = #Nat(natValue);
  let hashCode: Nat32 = Types.candyMapHashTool.0(candy);
  let equality: Bool = Types.candyMapHashTool.1(candy, candy);
  assert(equality == true);
});

test("hashShared function should produce consistent hash codes for CandyShared", func() {
  let shared_: CandyShared = #Nat(natValue);
  let hashCode1: Nat32 = Types.hashShared(shared_);
  let hashCode2: Nat32 = Types.hashShared(shared_);
  assert(hashCode1 == hashCode2);
});

test("eqShared function should compare two CandyShared for equality", func() {
  let shared1: CandyShared = #Nat(natValue);
  let shared2: CandyShared = #Nat(natValue);
  let unequalShared: CandyShared = #Nat(natValue + 1);
  assert(Types.eqShared(shared1, shared2) == true);
  assert(Types.eqShared(shared1, unequalShared) == false);
});

test("candySharedMapHashTool should provide hash and equality functions for CandyShared", func() {
  let shared_: CandyShared = #Nat(natValue);
  let hashCode: Nat32 = Types.candySharedMapHashTool.0(shared_);
  let equality: Bool = Types.candySharedMapHashTool.1(shared_, shared_);
  assert(equality == true);
});