import D "mo:base/Debug";
import {test} "mo:test";
import Candid "../src/candid";
import Types "../src/types";
import Conv "../src/conversion";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import StableBuffer "mo:stablebuffer_1_3_0/StableBuffer";
import Array "mo:base/Array";
import Nat8 "mo:base/Nat8";
import Text "mo:base/Text";
import CandidTypes "mo:candid/Type";
import Arg "mo:candid/Arg";
import Value "mo:candid/Value";

type CandyShared = Types.CandyShared;

// Helper function to assert equality on Arg values.
func assertArgEq(expected: Arg.Arg, actual: Arg.Arg) {
  D.print("in assert equal" # debug_show(expected, actual));
  assert(CandidTypes.equal(expected._type, actual._type));
  switch (expected.value, actual.value) {
    case (#text(e), #text(a)) { assert(e == a); };
    case (#principal(e), #principal(a)) { assert(e == a); };
    case (#int(e), #int(a)) { assert(e == a); };
    case (#nat(e), #nat(a)) { assert(e == a); };
    case (#int8(e), #int8(a)) { assert(e == a); };
    case (#int16(e), #int16(a)) { assert(e == a); };
    case (#int32(e), #int32(a)) { assert(e == a); };
    case (#int64(e), #int64(a)) { assert(e == a); };
    case (#nat8(e), #nat8(a)) { assert(e == a); };
    case (#nat16(e), #nat16(a)) { assert(e == a); };
    case (#nat32(e), #nat32(a)) { assert(e == a); };
    case (#nat64(e), #nat64(a)) { assert(e == a); };
    case (#bool(e), #bool(a)) { assert(e == a); };
    case (#float32(e), #float32(a)) { assert(e == a); };
    case (#float64(e), #float64(a)) { assert(e == a); };
    case (#opt(?e), #opt(?a)) { assert(Value.equal(e,a)) };
    case (#vector(e), #vector(a)) { assert(Array.equal((e,a, Value.equal))) };
    case (#record(e), #record(a)) { assert(Value.equal((expected.value, actual.value))) };
    case (#_null(e), #_null(a)) { assert(true); };
    // ... Add other cases as needed for complete coverage of Value variants.
    case (_, _) { assert(false);//, "Types of Arg values do not match."); 
    };
  };
};

// Helper function to construct Arg values for testing.
func makeArg<T>(t: CandidTypes.Type, v: Value.Value): Arg.Arg {
  {_type = t; value = v}
};

// Test cases for value_to_candid
test("should convert CandyShared #Nat to Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Nat(42);
  let expectedArg = makeArg(#nat, #nat(42));
  let result = Candid.value_to_candid(candy);
  assertArgEq(expectedArg, result[0]);
});

test("should convert CandyShared #Nat64 to Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Nat64(42);
  let expectedArg = makeArg(#nat64, #nat64(42: Nat64));
  let result = Candid.value_to_candid(candy);
  assertArgEq(expectedArg, result[0]);
});

// ... Similar tests for #Nat32, #Nat16, #Nat8, #Text, #Principal, #Bool, #Float, and so on.

test("should convert CandyShared #Text to Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Text("Hello");
  let expectedArg = makeArg(#text, #text("Hello"));
  let result = Candid.value_to_candid(candy);
  assertArgEq(expectedArg, result[0]);
});

test("should convert CandyShared #Bool to Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Bool(true);
  let expectedArg = makeArg(#bool, #bool(true));
  let result = Candid.value_to_candid(candy);
  assertArgEq(expectedArg, result[0]);
});

test("should convert CandyShared #Principal to Arg with appropriate Candid type", func() {
  let principalValue = Principal.fromText("rrkah-fqaaa-aaaaa-aaaaq-cai");
  let candy: CandyShared = #Principal(principalValue);
  let expectedArg = makeArg(#principal, #principal(#transparent(principalValue)));
  let result = Candid.value_to_candid(candy);
  assertArgEq(expectedArg, result[0]);
});

test("should convert CandyShared #Option(null) to proper Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Option(null);
  let expectedArg = makeArg(#opt(#_null), #_null);
  let result = Candid.value_to_candid(candy);
  D.print(debug_show(expectedArg, result));
  assertArgEq(expectedArg, result[0]);
});

test("should convert CandyShared #Option(value) to proper Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Option(?#Nat(42));
  let expectedArg = makeArg(#opt(#nat), #opt(?#nat(42)));
  let result = Candid.value_to_candid(candy);
  D.print(debug_show(expectedArg, result));
  assertArgEq(expectedArg, result[0]);
});

test("should convert CandyShared #Set to Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Set([#Nat(1), #Nat(2), #Nat(3)]);
  let expectedArg = makeArg(#vector(#nat), 
    #vector([
      #nat(1), 
      #nat(2), 
      #nat(3)
    ])
  );
  let result = Candid.value_to_candid(candy);
  assertArgEq(expectedArg, result[0]);
});

// Test conversion of CandyShared to Candid for the #Map type.
 test("should convert CandyShared #Map to Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Map([
    ("key1", #Nat(1)), 
    ("key2", #Text("two")), 
    ("key3", #Bool(true))
  ]);
  let expectedArg = makeArg(#record([
    // Need to sort fields in lexicographical order for #record type
    {tag = #name("key1"); _type = #nat}, 
    {tag = #name("key2"); _type = #text}, 
    {tag = #name("key3"); _type = #bool}
  ]), 
  #record([
    {tag = #name("key1"); value = #nat(1)},
    {tag = #name("key2"); value = #text("two")},
    {tag = #name("key3"); value = #bool(true)}
  ]));
  let result = Candid.value_to_candid(candy);
  D.print(debug_show(result));
  D.print(debug_show(expectedArg));
  assertArgEq(expectedArg, result[0]);
}); 

// Test conversion of CandyShared to Candid for the #ValueMap type.
test("should convert CandyShared #ValueMap to Arg with appropriate Candid type", func() {
  let keyVal1: (CandyShared, CandyShared) = (#Nat(10), #Nat(30));
  let keyVal2: (CandyShared, CandyShared) = (#Nat(20), #Nat(40));
  let candy: CandyShared = #ValueMap([keyVal1, keyVal2]);
  let expectedArg = makeArg(#record([
    {tag = #hash(0 : Nat32); _type = #record([{tag = #hash(0 : Nat32); _type = #nat;},{tag = #hash(1 : Nat32); _type = #nat;}])}, 
    {tag = #hash(1 : Nat32); _type = #record([{tag = #hash(0 : Nat32); _type = #nat;},{tag = #hash(1 : Nat32); _type = #nat;}])}, 
  ]), 
  #record([
    {tag = #hash(0 : Nat32); value = #record([ {tag = #hash(0 : Nat32);value=#nat(10)}, {tag = #hash(1 : Nat32); value=#nat(30)}])}, 
    {tag = #hash(1 : Nat32); value = #record([ {tag = #hash(0 : Nat32);value=#nat(20)}, {tag = #hash(1 : Nat32); value=#nat(40)}])},
  ]));
  let result = Candid.value_to_candid(candy);

  D.print(debug_show(result));
  D.print(debug_show(expectedArg));
  assertArgEq(expectedArg, result[0]);
  // Repeat this pattern for each pair in the ValueMap.
});

// Test conversion of CandyShared to Candid for the #Class type.
test("should convert CandyShared #Class to Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Class([
    {name = "age"; value = #Nat(30); immutable = true},
    {name = "name"; value = #Text("Alice"); immutable = true},
    {name = "verified"; value = #Bool(true); immutable = true}
  ]);
  let expectedArg = makeArg(#record([
    {tag = #name("age"); _type = #nat}, 
    {tag = #name("name"); _type = #text},
    {tag = #name("verified"); _type = #bool}
  ]), 
  #record([
    {tag = #name("age"); value = #nat(30)}, 
    {tag = #name("name"); value = #text("Alice")},
    {tag = #name("verified"); value = #bool(true)}
  ]));
  let result = Candid.value_to_candid(candy);
  assertArgEq(expectedArg, result[0]);
});

// Test conversion of CandyShared to Candid for the #Array type.
test("should convert CandyShared #Array to Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Array([#Nat(1), #Nat(2), #Nat(3)]);
  let expectedArg = makeArg(#vector(#nat), 
    #vector([
      #nat(1),
      #nat(2),
      #nat(3)
    ])
  );
  let result = Candid.value_to_candid(candy);
  assertArgEq(expectedArg, result[0]);
});

// Test conversion of CandyShared to Candid for the #Bytes type.
test("should convert CandyShared #Bytes to Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Bytes([0x01, 0x02, 0x03]);
  let expectedArg = makeArg(#vector(#nat8), 
    #vector([
      #nat8(1:Nat8), 
      #nat8(2:Nat8), 
      #nat8(3:Nat8)
    ])
  );
  let result = Candid.value_to_candid(candy);
  assertArgEq(expectedArg, result[0]);
});


// Test conversion of CandyShared #Float to Arg with appropriate Candid type
test("should convert CandyShared #Float to Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Float(42.42);
  let expectedArg = makeArg(#float64, #float64(42.42));
  let result = Candid.value_to_candid(candy);
  assertArgEq(expectedArg, result[0]);
});

// Test conversion of CandyShared #Int to Arg with appropriate Candid type
test("should convert CandyShared #Int to Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Int(42);
  let expectedArg = makeArg(#int, #int(42));
  let result = Candid.value_to_candid(candy);
  assertArgEq(expectedArg, result[0]);
});

// Test conversion of CandyShared #Int8 to Arg with appropriate Candid type
test("should convert CandyShared #Int8 to Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Int8(42);
  let expectedArg = makeArg(#int8, #int8(42 : Int8));
  let result = Candid.value_to_candid(candy);
  assertArgEq(expectedArg, result[0]);
});

// Test conversion of CandyShared #Int16 to Arg with appropriate Candid type
test("should convert CandyShared #Int16 to Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Int16(42);
  let expectedArg = makeArg(#int16, #int16(42 : Int16));
  let result = Candid.value_to_candid(candy);
  assertArgEq(expectedArg, result[0]);
});

// Test conversion of CandyShared #Int32 to Arg with appropriate Candid type
test("should convert CandyShared #Int32 to Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Int32(42);
  let expectedArg = makeArg(#int32, #int32(42:Int32));
  let result = Candid.value_to_candid(candy);
  assertArgEq(expectedArg, result[0]);
});

// Test conversion of CandyShared #Int64 to Arg with appropriate Candid type
test("should convert CandyShared #Int64 to Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Int64(42);
  let expectedArg = makeArg(#int64, #int64(42:Int64));
  let result = Candid.value_to_candid(candy);
  assertArgEq(expectedArg, result[0]);
});

// Test conversion of CandyShared #Class with mixed types to Arg with appropriate Candid type
test("should convert CandyShared #Class with mixed types to Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Class([
    {name = "age"; value = #Nat(30); immutable = true},
    {name = "name"; value = #Text("Alice"); immutable = true},
    {name = "verified"; value = #Bool(true); immutable = true},
    {name = "balance"; value = #Float(100.50); immutable = false}
  ]);
  let expectedArg = makeArg(#record([
    {tag = #name("age"); _type = #nat}, 
    {tag = #name("name"); _type = #text},
    {tag = #name("verified"); _type = #bool},
    {tag = #name("balance"); _type = #float64}
  ]), 
  #record([
    {tag = #name("age"); value = #nat(30)}, 
    {tag = #name("name"); value = #text("Alice")},
    {tag = #name("verified"); value = #bool(true)},
    {tag = #name("balance"); value = #float64(100.50)}
  ]));
  let result = Candid.value_to_candid(candy);
  assertArgEq(expectedArg, result[0]);
});

/* // Test conversion of CandyShared #Array with mixed types to Arg with appropriate Candid type
test("should convert CandyShared #Array with mixed types to Arg with appropriate Candid type", func() {
  let candy: CandyShared = #Array([
    #Nat(1), 
    #Text("Alice"), 
    #Bool(true), 
    #Float(100.50)
  ]);
  let expectedArg = makeArg(#vector, 
    #vector([
      #nat(1 : Nat),
      #text("Alice"),
      #bool(true),
      #float64(100.50 : Float)
    ])
  );
  let result = Candid.value_to_candid(candy);
  assertArgEq(expectedArg, result[0]);
}); */

/* // Test conversion of CandyShared #ValueMap with different value types to Arg with appropriate Candid type
test("should convert CandyShared #ValueMap with different value types to Arg with appropriate Candid type", func() {
  let candy: CandyShared = #ValueMap([
    (#Nat(10), #Text("ten")),
    (#Bool(false), #Float(200.25))
  ]);
  let expectedArg = makeArg(#record([{_type = #any; tag = #hash(0)}]), 
    #record([
      {tag = #hash(0); value = #record([{tag = #hash(0); value = #nat(10)}, {tag = #hash(1); value = #text("ten")}])},
      {tag = #hash(1); value = #record([{tag = #hash(0); value = #bool(false)}, {tag = #hash(1); value = #float64(200.25)}])}
    ])
  );
  let result = Candid.value_to_candid(candy);
  assertArgEq(expectedArg, result[0]);
}); */