import D "mo:base/Debug";
import {test} "mo:test";
import Types "../src/types";
import Upgrade "../src/upgrade";
import StableBuffer "mo:stablebuffer_1_3_0/StableBuffer";
import Nat8 "mo:base/Nat8";
import Principal "mo:base/Principal";
import Array "mo:base/Array";
import Blob "mo:base/Blob";
import CandyOld "mo:candy_0_1_12/types";
import Candy0_2_0 "mo:candy_0_2_0/types";

type CandyV1 = CandyOld.CandyValueUnstable;
type CandySharedV1 = CandyOld.CandyValue;
type CandyV2 = Candy0_2_0.Candy;
type CandySharedV2 = Candy0_2_0.CandyShared;
type CandyV3 = Types.Candy;
type CandySharedV3 = Types.CandyShared;

let testPrincipalV1 = Principal.fromText("rrkah-fqaaa-aaaaa-aaaaq-cai");
let testPrincipalV2 = testPrincipalV1;
let testPrincipalV3 = testPrincipalV1;

// Sample data for various types
let testInt: Int = 1;
let testNat: Nat = 42;
let testBool: Bool = true;
let testText: Text = "test";
let testFloat: Float = 3.14;
let testBlob: Blob = Blob.fromArray([0, 1, 2, 3]);
let testArrayV1: [CandyV1] = [#Int(testInt)]; // V1 only supports an array of CandyV1
let testArrayV2: [CandySharedV2] = Array.tabulate<CandySharedV2>(3, func(_){#Int(testInt)}); // V2 supports long array of CandyV2
// Helpers for constructing V3 test values
let testSharedArrayV3: [CandySharedV3] = [#Int(testInt), #Text(testText), #Bool(testBool)];


// Begin Test Suite

// Test Cases for Upgrade from V1 representation of Candy to V2
test("upgradeCandy0_1_2_to_0_2_0 - Int", func() {
  let originalCandyV1: CandyV1 = #Int(testInt);
  let upgradedCandyV2: CandyV2 = Upgrade.upgradeCandy0_1_2_to_0_2_0(originalCandyV1);
  let #Int(val) = upgradedCandyV2;
  assert(val == testInt);
});

// Add more test cases to cover all Candy types for upgrade function `upgradeCandy0_1_2_to_0_2_0`
// ...

// Test Cases for Upgrade from V1 representation of CandyShared to V2 representations CandyShared
test("upgradeCandyShared0_1_2_to_0_2_0 - Bool", func() {
  let originalCandySharedV1: CandySharedV1 = #Bool(testBool);
  let upgradedCandySharedV2: CandySharedV2 = Upgrade.upgradeCandyShared0_1_2_to_0_2_0(originalCandySharedV1);
  assert(upgradedCandySharedV2 == #Bool(testBool));
});

// Add more test cases to cover all CandyShared types for upgrade function `upgradeCandyShared0_1_2_to_0_2_0`
// ...

// Test Cases for Upgrade from V2 representation of Candy to V3
test("upgradeCandy0_2_0_to_0_3_0 - Text", func() {
  let originalCandyV2: CandyV2 = #Text(testText);
  let upgradedCandyV3: CandyV3 = Upgrade.upgradeCandy0_2_0_to_0_3_0(originalCandyV2);
  let #Text(val) = upgradedCandyV3;
  assert(upgradedCandyV3 == testText);
});

test("upgradeCandy0_1_2_to_0_2_0 - Nat", func() {
  let originalCandyV1: CandyV1 = #Nat(testNat);
  let upgradedCandyV2: CandyV2 = Upgrade.upgradeCandy0_1_2_to_0_2_0(originalCandyV1);
  let #Nat(val) = upgradedCandyV2;
  assert(val == testNat);
});

test("upgradeCandy0_1_2_to_0_2_0 - Bool", func() {
  let originalCandyV1: CandyV1 = #Bool(testBool);
  let upgradedCandyV2: CandyV2 = Upgrade.upgradeCandy0_1_2_to_0_2_0(originalCandyV1);
  let #Bool(val) = upgradedCandyV2;
  assert(val == testBool);
});

test("upgradeCandy0_1_2_to_0_2_0 - Float", func() {
  let originalCandyV1: CandyV1 = #Float(testFloat);
  let upgradedCandyV2: CandyV2 = Upgrade.upgradeCandy0_1_2_to_0_2_0(originalCandyV1);
  let #Float(val) = upgradedCandyV2;
  assert(val == testFloat);
});

test("upgradeCandy0_1_2_to_0_2_0 - Principal", func() {
  let originalCandyV1: CandyV1 = #Principal(testPrincipalV1);
  let upgradedCandyV2: CandyV2 = Upgrade.upgradeCandy0_1_2_to_0_2_0(originalCandyV1);
  let #Principal(val) = upgradedCandyV2;
  assert(val == testPrincipalV2);
});

test("upgradeCandy0_1_2_to_0_2_0 - Null", func() {
  let originalCandyV1: CandyV1 = #Empty;
  let upgradedCandyV2: CandyV2 = Upgrade.upgradeCandy0_1_2_to_0_2_0(originalCandyV1);
  let #Option(val) = upgradedCandyV2;
  switch(val){
    case(null){assert(true)};
    case(_) assert(false);
  };
});


// Test Cases for Upgrade from V2 representation of CandyShared to V3 representations CandyShared
test("upgradeCandyShared0_2_0_to_0_3_0 - Array", func() {
  let originalCandySharedV2: CandySharedV2 = #Array(testArrayV2);
  let upgradedCandySharedV3: CandySharedV3 = Upgrade.upgradeCandyShared0_2_0_to_0_3_0(originalCandySharedV2);
  D.print(debug_show(upgradedCandySharedV3, testSharedArrayV3));
  assert(Types.eqShared(upgradedCandySharedV3, #Array([#Int(1), #Int(1), #Int(1)]))); // Convert upgraded array to V3 format
});

// Add more test cases to cover all CandyShared types for upgrade function `upgradeCandyShared0_2_0_to_0_3_0`
// ...

// End Test Suite

