import D "mo:base/Debug";
import {test} "mo:test";
import Json "../src/json";
import Types "../src/types";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Text "mo:base/Text";
import Principal "mo:base/Principal";

type CandyShared = Types.CandyShared;

test("value_to_json should convert Nat to JSON", func() {
  let value: CandyShared = #Nat(123);
  let json = Json.value_to_json(value);
  assert(json == "123");
});

test("value_to_json should convert Nat8 to JSON", func() {
  let value: CandyShared = #Nat8(45);
  let json = Json.value_to_json(value);
  assert(json == "45");
});

test("value_to_json should convert Nat16 to JSON", func() {
  let value: CandyShared = #Nat16(400);
  let json = Json.value_to_json(value);
  assert(json == "400");
});

test("value_to_json should convert Nat32 to JSON", func() {
  let value: CandyShared = #Nat32(50000);
  let json = Json.value_to_json(value);
  assert(json == "50000");
});

test("value_to_json should convert Nat64 to JSON", func() {
  let value: CandyShared = #Nat64(70000000);
  let json = Json.value_to_json(value);
  assert(json == "70000000");
});

test("value_to_json should convert Int to JSON", func() {
  let value: CandyShared = #Int(-123);
  let json = Json.value_to_json(value);
  assert(json == "-123");
});

test("value_to_json should convert Int8 to JSON", func() {
  let value: CandyShared = #Int8(-45);
  let json = Json.value_to_json(value);
  assert(json == "-45");
});

test("value_to_json should convert Int16 to JSON", func() {
  let value: CandyShared = #Int16(-400);
  let json = Json.value_to_json(value);
  assert(json == "-400");
});

test("value_to_json should convert Int32 to JSON", func() {
  let value: CandyShared = #Int32(-50000);
  let json = Json.value_to_json(value);
  assert(json == "-50000");
});

test("value_to_json should convert Int64 to JSON", func() {
  let value: CandyShared = #Int64(-70000000);
  let json = Json.value_to_json(value);
  assert(json == "-70000000");
});

test("value_to_json should convert Float to JSON", func() {
  let value: CandyShared = #Float(3.1415);
  let json = Json.value_to_json(value);
  D.print(debug_show(json));
  assert(Text.startsWith(json, #text("3.1415"))); // Handle float precision
});

test("value_to_json should convert Text to JSON", func() {
  let value: CandyShared = #Text("Hello, World!");
  let json = Json.value_to_json(value);
  assert(json == "\"Hello, World!\"");
});

test("value_to_json should convert Bool to JSON", func() {
  let value: CandyShared = #Bool(true);
  let json = Json.value_to_json(value);
  assert(json == "\"true\"");
});

test("value_to_json should convert Blob to JSON", func() {
  let value: CandyShared = #Blob(Text.encodeUtf8("Blob"));
  let json = Json.value_to_json(value);
  D.print(debug_show(json));
  assert(json == "\"426c6f62\"");
});

test("value_to_json should convert Principal to JSON", func() {
  let principalValue = Principal.fromText("rrkah-fqaaa-aaaaa-aaaaq-cai");
  let value: CandyShared = #Principal(principalValue);
  let json = Json.value_to_json(value);
  assert(json == "\"" # Principal.toText(principalValue) # "\"");
});

test("value_to_json should convert Array to JSON", func() {
  let value: CandyShared = #Array([#Nat(1), #Nat(2), #Nat(3)]);
  let json = Json.value_to_json(value);
  assert(json == "[1,2,3]");
});

test("value_to_json should convert empty Array to JSON", func() {
  let value: CandyShared = #Array([]);
  let json = Json.value_to_json(value);
  assert(json == "[]");
});

test("value_to_json should convert Class to JSON", func() {
  let value: CandyShared = #Class([
    {
      name = "age";
      value = #Nat(30);
      immutable = true;
    },
    {
      name = "name";
      value = #Text("John Doe");
      immutable = true;
    }
  ]);
  let json = Json.value_to_json(value);
  assert(json == "{\"age\":30,\"name\":\"John Doe\"}");
});

test("value_to_json should convert Nats to JSON", func() {
  let value: CandyShared = #Nats([Nat8.toNat(1), Nat8.toNat(2), Nat8.toNat(3)]);
  let json = Json.value_to_json(value);
  assert(json == "[1,2,3]");
});

test("value_to_json should convert Floats to JSON", func() {
  let value: CandyShared = #Floats([1.1, 2.2, 3.3]);
  let json = Json.value_to_json(value);
  // Note: Adjust the test for potential loss of precision in the float conversion
  D.print(debug_show(json));
  assert(Text.startsWith(json, #text("[1.10000")));
  assert(Text.contains(json, #text(",2")));
  assert(Text.contains(json, #text(",3")));
});

test("value_to_json should convert Option to JSON", func() {
  let value: CandyShared = #Option(?#Bool(true));
  let json = Json.value_to_json(value);
  assert(json == "\"true\"");
});

test("value_to_json should convert none Option to JSON", func() {
  let value: CandyShared = #Option(null);
  let json = Json.value_to_json(value);
  assert(json == "null");
});

// Additional tests for Map, Set, ValueMap, and any other types can follow the pattern above.