import D "mo:base/Debug";
import {test} "mo:test";
import Types "../src/types";
import Clone "../src/clone";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Nat16 "mo:base/Nat16";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Int "mo:base/Int";
import Int8 "mo:base/Int8";
import Int16 "mo:base/Int16";
import Int32 "mo:base/Int32";
import Int64 "mo:base/Int64";
import Iter "mo:base/Iter";
import Float "mo:base/Float";
import Bool "mo:base/Bool";
import Text "mo:base/Text";
import Blob "mo:base/Blob";
import Array "mo:base/Array";
import StableBuffer "mo:stablebuffer_1_3_0/StableBuffer";
import Map "mo:map9/Map";
import Set "mo:map9/Set";

type Candy = Types.Candy;
type CandyShared = Types.CandyShared;
type Property = Types.Property;

// Helper function for deep equality check of Candy type
func deepEqualCandy(x : Candy, y : Candy) : Bool {
  switch (x, y) {
    case (#Int(a), #Int(b)) Int.equal(a, b);
    case (#Int8(a), #Int8(b)) Int8.equal(a, b);
    case (#Int16(a), #Int16(b)) Int16.equal(a, b);
    case (#Int32(a), #Int32(b)) Int32.equal(a, b);
    case (#Int64(a), #Int64(b)) Int64.equal(a, b);
    case (#Nat(a), #Nat(b)) Nat.equal(a, b);
    case (#Nat8(a), #Nat8(b)) Nat8.equal(a, b);
    case (#Nat16(a), #Nat16(b)) Nat16.equal(a, b);
    case (#Nat32(a), #Nat32(b)) Nat32.equal(a, b);
    case (#Nat64(a), #Nat64(b)) Nat64.equal(a, b);
    case (#Float(a), #Float(b)) Float.equal(a, b);
    case (#Text(a), #Text(b)) Text.equal(a, b);
    case (#Bool(a), #Bool(b)) a == b;
    case (#Blob(a), #Blob(b)) Blob.equal(a, b);
    case (#Principal(a), #Principal(b)) Principal.equal(a, b);
    case (#Array(a), #Array(b)) {
      if (StableBuffer.size<Candy>(a) != StableBuffer.size<Candy>(b)) {
        return false;
      };
      for (index in Iter.range(0, StableBuffer.size<Candy>(a) - 1)) {
        if (not (deepEqualCandy(StableBuffer.get<Candy>(a, index), StableBuffer.get<Candy>(b, index)))) {
          return false;
        };
      };
      true;
    };
    case (#Class(a), #Class(b)) {
      if (Map.size<Text, Property>(a) != Map.size<Text, Property>(b)) {
        return false;
      };
      for ((name, propA) in Map.entries<Text, Property>(a)) {
        switch (Map.get<Text, Property>(b, Map.thash, name)) {
          case (null) { return false; };
          case (?propB) {
            if (not (propA.immutable == propB.immutable and deepEqualCandy(propA.value, propB.value))) {
              return false;
            };
          };
        };
      };
      true;
    };
    case (#Set(a), #Set(b)) {
      if (Set.size<Candy>(a) != Set.size<Candy>(b)) {
        return false;
      };
      for (elem in Set.keys<Candy>(a)) {
        if (not (Set.has<Candy>(b, Types.candyMapHashTool, elem))) {
          return false;
        };
      };
      true;
    };
    case (#Map(a), #Map(b)) {
      if (Map.size<Text, Candy>(a) != Map.size<Text, Candy>(b)) {
        return false;
      };
      for ((key, valueA) in Map.entries<Text, Candy>(a)) {
        switch (Map.get<Text, Candy>(b, Map.thash, key)) {
          case (null) { return false; };
          case (?valueB) {
            if (not(deepEqualCandy(valueA, valueB))) {
              return false;
            };
          };
        };
      };
      true;
    };
    case (#ValueMap(a), #ValueMap(b)) {
      if (Map.size<Candy, Candy>(a) != Map.size<Candy, Candy>(b)) {
        return false;
      };
      for ((keyA, valueA) in Map.entries<Candy, Candy>(a)) {
        var found = false;
        for ((keyB, valueB) in Map.entries<Candy, Candy>(b)) {
          // Since keys can be any candy, we cannot use Map.get here and have to iterate
          if (deepEqualCandy(keyA, keyB) and deepEqualCandy(valueA, valueB)) {
            found := true;
          };
        };
        if (not found) {
          return false;
        };
      };
      true;
    };
    case (#Option(aOpt), #Option(bOpt)) {
      switch (aOpt, bOpt) {
        case (null, null) true;
        case (?a, ?b) deepEqualCandy(a, b);
        case (_, _) false;
      }
    };
    case (_, _) false;
  };
};

test("cloneCandy should deep clone #Int", func() {
  let value: Candy = #Int(42);
  let cloned = Clone.cloneCandy(value);
  assert(deepEqualCandy(value, cloned));
});

test("cloneCandy should deep clone #Int64", func() {
  let value: Candy = #Int64(42);
  let cloned = Clone.cloneCandy(value);
  assert(deepEqualCandy(value, cloned));
});

test("cloneCandy should deep clone #Nat literals", func() {
  let value: Candy = #Nat(123);
  let cloned = Clone.cloneCandy(value);
  assert(deepEqualCandy(value, cloned));
});

test("cloneCandy should deep clone #Float", func() {
  let value: Candy = #Float(42.0);
  let cloned = Clone.cloneCandy(value);
  assert(deepEqualCandy(value, cloned));
});

test("cloneCandy should deep clone #Text", func() {
  let value: Candy = #Text("Hello, world!");
  let cloned = Clone.cloneCandy(value);
  assert(deepEqualCandy(value, cloned));
});

test("cloneCandy should deep clone #Blob", func() {
  let value: Candy = #Blob(Blob.fromArray([1, 2]));
  let cloned = Clone.cloneCandy(value);
  assert(deepEqualCandy(value, cloned));
});

test("cloneCandy should deep clone #Principal", func() {
  let value: Candy = #Principal(Principal.fromText("2vxsx-fae"));
  let cloned = Clone.cloneCandy(value);
  assert(deepEqualCandy(value, cloned));
});

test("cloneCandy should deep clone #Class", func() {
  let prop1: Candy = #Int(42);
  let prop2: Candy = #Text("Hello, world!");
  let value: Candy = #Class(Map.fromIter<Text, Property>([
    ("int_prop", {name = "int_prop"; value = prop1; immutable = false}),
    ("text_prop", {name = "text_prop"; value = prop2; immutable = false})
  ].vals(), Map.thash));
  let cloned = Clone.cloneCandy(value);
  assert(deepEqualCandy(value, cloned));
});

test("cloneCandy should deep clone #Array", func() {
  let value: Candy = #Array(StableBuffer.fromArray<Candy>([#Int(42), #Text("Hello, world!")]));
  let cloned = Clone.cloneCandy(value);
  assert(deepEqualCandy(value, cloned));
});

test("cloneCandy should deep clone #Map", func() {
  let value: Candy = #Map(Map.fromIter<Text, Candy>(
    [("key1", #Int(42)), ("key2", #Text("Hello, world!"))].vals(),
    Map.thash
  ));
  let cloned = Clone.cloneCandy(value);
  assert(deepEqualCandy(value, cloned));
});

test("cloneCandy should deep clone #ValueMap", func() {
  let value: Candy = #ValueMap(Map.fromIter<Candy, Candy>(
    [(#Int(1), #Int(42)), (#Int(2), #Text("Hello, world!"))].vals(),
    Types.candyMapHashTool
  ));
  let cloned = Clone.cloneCandy(value);
  assert(deepEqualCandy(value, cloned));
});

test("cloneCandy should deep clone #Set", func() {
  let value: Candy = #Set(Set.fromIter<Candy>(
    [#Int(42), #Text("Hello, world!")].vals(),
    Types.candyMapHashTool
  ));
  let cloned = Clone.cloneCandy(value);
  assert(deepEqualCandy(value, cloned));
});

test("cloneCandy should deep clone #Option", func() {
  let value: Candy = #Option(?#Int(42));
  let cloned = Clone.cloneCandy(value);
  assert(deepEqualCandy(value, cloned));
});