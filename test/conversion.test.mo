import Debug "mo:base/Debug";
import Result "mo:base/Result";
import Conversion "../src/icrc16/conversion";
import Types "../src/types";
import StableBuffer "mo:stablebuffer_1_3_0/StableBuffer";
import Map "mo:map9/Map";
import Iter "mo:base/Iter";
import Buffer "mo:base/Buffer";
import Principal "mo:base/Principal";
import Blob "mo:base/Blob";
import Array "mo:base/Array";
import Set "mo:map9/Set";
import Error "mo:base/Error";
import PrincipalExt "mo:principal-ext";
import {test} "mo:test";


  
  func testCandyToNat() {
    // Test case 1: Valid Nat input
    let result1 = Conversion.candyToNat(#Nat(42));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(42));

    // Test case 2: Valid Nat8 input
    let result2 = Conversion.candyToNat(#Nat8(255));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(255));

    // Test case 3: Valid Float input
    let result3 = Conversion.candyToNat(#Float(42.0));
    Debug.print(debug_show(result3));
    assert(result3 == #ok(42));

    // Test case 4: Negative Float input
    let result4 = Conversion.candyToNat(#Float(-42.0));
    Debug.print(debug_show(result4));
    assert(result4 == #err("illegal cast"));

    // Test case 5: Invalid type input
    let result5 = Conversion.candyToNat(#Text("invalid"));
    Debug.print(debug_show(result5));
    assert(result5 == #err("illegal cast"));

    // Test case 6: Negative Int input
    let result6 = Conversion.candyToNat(#Int(-42));
    Debug.print(debug_show(result6));
    assert(result6 == #err("illegal cast"));

    // Test case 7: Valid Int input
    let result7 = Conversion.candyToNat(#Int(42));
    Debug.print(debug_show(result7));
    assert(result7 == #ok(42));

    Debug.print("All candyToNat tests passed.");
  };
  test("testCandyToNat", testCandyToNat);

  
  func testCandyToNat8() {
    // Test case 1: Valid Nat8 input
    let result1 = Conversion.candyToNat8(#Nat8(255));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(255));

    Debug.print("Result of candyToNat8 for Nat8(255): " # debug_show(result1));

    // Test case 2: Valid Nat input within Nat8 range
    let result2 = Conversion.candyToNat8(#Nat(42));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(42));

    // Test case 3: Nat input exceeding Nat8 range
    let result3 = Conversion.candyToNat8(#Nat(300));
    Debug.print(debug_show(result3));
    assert(result3 == #err("illegal cast"));

    // Test case 4: Valid Float input within Nat8 range
    let result4 = Conversion.candyToNat8(#Float(42.0));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(42));

    // Test case 5: Negative Float input
    let result5 = Conversion.candyToNat8(#Float(-42.0));
    Debug.print(debug_show(result5));
    assert(result5 == #err("illegal cast"));

    // Test case 6: Invalid type input
    let result6 = Conversion.candyToNat8(#Text("invalid"));
    Debug.print(debug_show(result6));
    assert(result6 == #err("illegal cast"));

    // Test case 7: Negative Int input
    let result7 = Conversion.candyToNat8(#Int(-42));
    Debug.print(debug_show(result7));
    assert(result7 == #err("illegal cast"));

    // Test case 8: Valid Int input within Nat8 range
    let result8 = Conversion.candyToNat8(#Int(42));
    Debug.print(debug_show(result8));
    assert(result8 == #ok(42));

    Debug.print("All candyToNat8 tests passed.");
  };
  test("testCandyToNat8", testCandyToNat8);

  func testCandyToNat16() {
    // Test case 1: Valid Nat16 input
    let result1 = Conversion.candyToNat16(#Nat16(65535));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(65535));

    // Test case 2: Valid Nat input within Nat16 range
    let result2 = Conversion.candyToNat16(#Nat(42));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(42));

    // Test case 3: Nat input exceeding Nat16 range
    let result3 = Conversion.candyToNat16(#Nat(70000));
    Debug.print(debug_show(result3));
    assert(result3 == #err("overflow while converting Nat to Nat16"));

    // Test case 4: Valid Float input within Nat16 range
    let result4 = Conversion.candyToNat16(#Float(42.0));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(42));

    // Test case 5: Negative Float input
    let result5 = Conversion.candyToNat16(#Float(-42.0));
    Debug.print(debug_show(result5));
    assert(result5 == #err("illegal cast"));

    // Test case 6: Invalid type input
    let result6 = Conversion.candyToNat16(#Text("invalid"));
    Debug.print(debug_show(result6));
    assert(result6 == #err("illegal cast"));

    // Test case 7: Negative Int input
    let result7 = Conversion.candyToNat16(#Int(-42));
    Debug.print(debug_show(result7));
    assert(result7 == #err("illegal cast"));

    // Test case 8: Valid Int input within Nat16 range
    let result8 = Conversion.candyToNat16(#Int(42));
    Debug.print(debug_show(result8));
    assert(result8 == #ok(42));

    Debug.print("All candyToNat16 tests passed.");
  };
  test("testCandyToNat16", testCandyToNat16);

  func testCandyToNat32() {
    // Test case 1: Valid Nat32 input
    let result1 = Conversion.candyToNat32(#Nat32(4294967295));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(4294967295));

    // Test case 2: Valid Nat input within Nat32 range
    let result2 = Conversion.candyToNat32(#Nat(42));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(42));

    // Test case 3: Nat input exceeding Nat32 range
    let result3 = Conversion.candyToNat32(#Nat(5000000000));
    Debug.print(debug_show(result3));
    assert(result3 == #err("overflow while converting Nat to Nat32"));

    // Test case 4: Valid Float input within Nat32 range
    let result4 = Conversion.candyToNat32(#Float(42.0));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(42));

    // Test case 5: Negative Float input
    let result5 = Conversion.candyToNat32(#Float(-42.0));
    Debug.print(debug_show(result5));
    assert(result5 == #err("illegal cast"));

    // Test case 6: Invalid type input
    let result6 = Conversion.candyToNat32(#Text("invalid"));
    Debug.print(debug_show(result6));
    assert(result6 == #err("illegal cast"));

    // Test case 7: Negative Int input
    let result7 = Conversion.candyToNat32(#Int(-42));
    Debug.print(debug_show(result7));
    assert(result7 == #err("illegal cast"));

    // Test case 8: Valid Int input within Nat32 range
    let result8 = Conversion.candyToNat32(#Int(42));
    Debug.print(debug_show(result8));
    assert(result8 == #ok(42));

    Debug.print("All candyToNat32 tests passed.");
  };
  test("testCandyToNat32", testCandyToNat32);

  func testCandyToNat64() {
    // Test case 1: Valid Nat64 input
    let result1 = Conversion.candyToNat64(#Nat64(18446744073709551615));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(18446744073709551615));

    // Test case 2: Valid Nat input within Nat64 range
    let result2 = Conversion.candyToNat64(#Nat(42));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(42));

    // Test case 3: Valid Float input within Nat64 range
    let result3 = Conversion.candyToNat64(#Float(42.0));
    Debug.print(debug_show(result3));
    assert(result3 == #ok(42));

    // Test case 4: Negative Float input
    let result4 = Conversion.candyToNat64(#Float(-42.0));
    Debug.print(debug_show(result4));
    assert(result4 == #err("illegal cast"));

    // Test case 5: Invalid type input
    let result5 = Conversion.candyToNat64(#Text("invalid"));
    Debug.print(debug_show(result5));
    assert(result5 == #err("illegal cast"));

    // Test case 6: Negative Int input
    let result6 = Conversion.candyToNat64(#Int(-42));
    Debug.print(debug_show(result6));
    assert(result6 == #err("illegal cast"));

    // Test case 7: Valid Int input within Nat64 range
    let result7 = Conversion.candyToNat64(#Int(42));
    Debug.print(debug_show(result7));
    assert(result7 == #ok(42));

    Debug.print("All candyToNat64 tests passed.");
  };
  test("testCandyToNat64", testCandyToNat64);

  func testCandyToInt() {
    // Test case 1: Valid Int input
    let result1 = Conversion.candyToInt(#Int(42));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(42));

    // Test case 2: Valid Int8 input
    let result2 = Conversion.candyToInt(#Int8(-128));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(-128));

    // Test case 3: Valid Int16 input
    let result3 = Conversion.candyToInt(#Int16(32767));
    Debug.print(debug_show(result3));
    assert(result3 == #ok(32767));

    // Test case 4: Valid Int32 input
    let result4 = Conversion.candyToInt(#Int32(-2147483648));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(-2147483648));

    // Test case 5: Valid Int64 input
    let result5 = Conversion.candyToInt(#Int64(9223372036854775807));
    Debug.print(debug_show(result5));
    assert(result5 == #ok(9223372036854775807));

    // Test case 6: Valid Nat input
    let result6 = Conversion.candyToInt(#Nat(42));
    Debug.print(debug_show(result6));
    assert(result6 == #ok(42));

    // Test case 7: Valid Float input
    let result7 = Conversion.candyToInt(#Float(42.5));
    Debug.print(debug_show(result7));
    assert(result7 == #ok(42));

    // Test case 8: Invalid type input
    let result8 = Conversion.candyToInt(#Text("invalid"));
    Debug.print(debug_show(result8));
    assert(result8 == #err("illegal cast"));

    Debug.print("All candyToInt tests passed.");
  };
  test("testCandyToInt", testCandyToInt);

  func testCandyToInt8() {
    // Test case 1: Valid Int8 input
    let result1 = Conversion.candyToInt8(#Int8(-128));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(-128));

    // Test case 2: Valid Int input within Int8 range
    let result2 = Conversion.candyToInt8(#Int(42));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(42));

    // Test case 3: Int input exceeding Int8 range
    let result3 = Conversion.candyToInt8(#Int(200));
    Debug.print(debug_show(result3));
    assert(result3 == #err("illegal cast"));

    // Test case 4: Valid Nat8 input
    let result4 = Conversion.candyToInt8(#Nat8(127));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(127));

    // Test case 5: Nat8 input exceeding Int8 range
    let result5 = Conversion.candyToInt8(#Nat8(255));
    Debug.print(debug_show(result5));
    assert(result5 == #err("illegal cast"));

    // Test case 6: Valid Float input within Int8 range
    let result6 = Conversion.candyToInt8(#Float(42.0));
    Debug.print(debug_show(result6));
    assert(result6 == #ok(42));

    // Test case 7: Negative Float input
    let result7 = Conversion.candyToInt8(#Float(-42.0));
    Debug.print(debug_show(result7));
    assert(result7 == #ok(-42));

    // Test case 8: Invalid type input
    let result8 = Conversion.candyToInt8(#Text("invalid"));
    Debug.print(debug_show(result8));
    assert(result8 == #err("illegal cast"));

    Debug.print("All candyToInt8 tests passed.");
  };
  test("testCandyToInt8", testCandyToInt8);

  func testCandyToInt16() {
    // Test case 1: Valid Int16 input
    let result1 = Conversion.candyToInt16(#Int16(32767));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(32767));

    // Test case 2: Valid Int input within Int16 range
    let result2 = Conversion.candyToInt16(#Int(-32768));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(-32768));

    // Test case 3: Int input exceeding Int16 range
    let result3 = Conversion.candyToInt16(#Int(40000));
    Debug.print(debug_show(result3));
    assert(result3 == #err("illegal cast"));

    // Test case 4: Valid Nat16 input
    let result4 = Conversion.candyToInt16(#Nat16(32767));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(32767));

    // Test case 5: Nat16 input exceeding Int16 range
    let result5 = Conversion.candyToInt16(#Nat16(65535));
    Debug.print(debug_show(result5));
    assert(result5 == #err("illegal cast"));

    // Test case 6: Valid Float input within Int16 range
    let result6 = Conversion.candyToInt16(#Float(42.0));
    Debug.print(debug_show(result6));
    assert(result6 == #ok(42));

    // Test case 7: Negative Float input
    let result7 = Conversion.candyToInt16(#Float(-42.0));
    Debug.print(debug_show(result7));
    assert(result7 == #ok(-42));

    // Test case 8: Invalid type input
    let result8 = Conversion.candyToInt16(#Text("invalid"));
    Debug.print(debug_show(result8));
    assert(result8 == #err("illegal cast"));

    Debug.print("All candyToInt16 tests passed.");
  };
  test("testCandyToInt16", testCandyToInt16);

  func testCandyToInt32() {
    // Test case 1: Valid Int32 input
    let result1 = Conversion.candyToInt32(#Int32(2147483647));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(2147483647));

    // Test case 2: Valid Int input within Int32 range
    let result2 = Conversion.candyToInt32(#Int(-2147483648));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(-2147483648));

    // Test case 3: Int input exceeding Int32 range
    let result3 = Conversion.candyToInt32(#Int(3000000000));
    Debug.print(debug_show(result3));
    assert(result3 == #err("overflow while converting Int to Int32"));

    // Test case 4: Valid Nat32 input
    let result4 = Conversion.candyToInt32(#Nat32(2147483647));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(2147483647));

    // Test case 5: Nat32 input exceeding Int32 range
    let result5 = Conversion.candyToInt32(#Nat32(4294967295));
    Debug.print(debug_show(result5));
    assert(result5 == #err("illegal cast"));

    // Test case 6: Valid Float input within Int32 range
    let result6 = Conversion.candyToInt32(#Float(42.0));
    Debug.print(debug_show(result6));
    assert(result6 == #ok(42));

    // Test case 7: Negative Float input
    let result7 = Conversion.candyToInt32(#Float(-42.0));
    Debug.print(debug_show(result7));
    assert(result7 == #ok(-42));

    // Test case 8: Invalid type input
    let result8 = Conversion.candyToInt32(#Text("invalid"));
    Debug.print(debug_show(result8));
    assert(result8 == #err("illegal cast"));

    Debug.print("All candyToInt32 tests passed.");
  };
  test("testCandyToInt32", testCandyToInt32);

  func testCandyToInt64() {
    // Test case 1: Valid Int64 input
    let result1 = Conversion.candyToInt64(#Int64(9223372036854775807));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(9223372036854775807));

    // Test case 2: Valid Int input within Int64 range
    let result2 = Conversion.candyToInt64(#Int(-9223372036854775808));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(-9223372036854775808));

    // Test case 3: Int input exceeding Int64 range
    let result3 = Conversion.candyToInt64(#Int(10000000000000000000));
    Debug.print(debug_show(result3));
    assert(result3 == #err("overflow while converting Int to Int64"));

    // Test case 4: Valid Nat64 input
    let result4 = Conversion.candyToInt64(#Nat64(9223372036854775807));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(9223372036854775807));

    // Test case 5: Nat64 input exceeding Int64 range
    let result5 = Conversion.candyToInt64(#Nat64(18446744073709551615));
    Debug.print(debug_show(result5));
    assert(result5 == #err("illegal cast"));

    // Test case 6: Valid Float input within Int64 range
    let result6 = Conversion.candyToInt64(#Float(42.0));
    Debug.print(debug_show(result6));
    assert(result6 == #ok(42));

    // Test case 7: Negative Float input
    let result7 = Conversion.candyToInt64(#Float(-42.0));
    Debug.print(debug_show(result7));
    assert(result7 == #ok(-42));

    // Test case 8: Invalid type input
    let result8 = Conversion.candyToInt64(#Text("invalid"));
    Debug.print(debug_show(result8));
    assert(result8 == #err("illegal cast"));

    Debug.print("All candyToInt64 tests passed.");
  };
  test("testCandyToInt64", testCandyToInt64);

  func testCandyToFloat() {
    // Test case 1: Valid Float input
    let result1 = Conversion.candyToFloat(#Float(42.5));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(42.5));

    // Test case 2: Valid Int input
    let result2 = Conversion.candyToFloat(#Int(42));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(42.0));

    // Test case 3: Valid Int8 input
    let result3 = Conversion.candyToFloat(#Int8(-128));
    Debug.print(debug_show(result3));
    assert(result3 == #ok(-128.0));

    // Test case 4: Valid Int16 input
    let result4 = Conversion.candyToFloat(#Int16(32767));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(32767.0));

    // Test case 5: Valid Int32 input
    let result5 = Conversion.candyToFloat(#Int32(-2147483648));
    Debug.print(debug_show(result5));
    assert(result5 == #ok(-2147483648.0));

    // Test case 6: Valid Int64 input
    let result6 = Conversion.candyToFloat(#Int64(9223372036854775807));
    Debug.print(debug_show(result6));
    assert(result6 == #ok(9223372036854775807.0));

    // Test case 7: Valid Nat input
    let result7 = Conversion.candyToFloat(#Nat(42));
    Debug.print(debug_show(result7));
    assert(result7 == #ok(42.0));

    // Test case 8: Invalid type input
    let result8 = Conversion.candyToFloat(#Text("invalid"));
    Debug.print(debug_show(result8));
    assert(result8 == #err("illegal cast"));

    Debug.print("All candyToFloat tests passed.");
  };
  test("testCandyToFloat", testCandyToFloat);

   func testCandyToPrincipal() {
    // Test case 1: Valid Principal input
    let principal = Principal.fromText("aaaaa-aa");
    let result1 = Conversion.candyToPrincipal(#Principal(principal));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(principal));

    // Test case 2: Invalid type input
    let result2 = Conversion.candyToPrincipal(#Text("invalid"));
    Debug.print(debug_show(result2));
    assert(result2 == #err("invalid principal"));

    Debug.print("All candyToPrincipal tests passed.");
  };
  test("testCandyToPrincipal", testCandyToPrincipal);

  func testCandyToBool() {
    // Test case 1: Valid Bool input (true)
    let result1 = Conversion.candyToBool(#Bool(true));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(true));

    // Test case 2: Valid Bool input (false)
    let result2 = Conversion.candyToBool(#Bool(false));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(false));

    // Test case 3: Invalid type input
    let result3 = Conversion.candyToBool(#Text("invalid"));
    Debug.print(debug_show(result3));
    assert(result3 == #err("illegal cast to Bool"));

    Debug.print("All candyToBool tests passed.");
  };
  test("testCandyToBool", testCandyToBool);

  func testCandyToBlob() {
    // Test case 1: Valid Blob input
    let blob = Blob.fromArray([1, 2, 3]);
    let result1 = Conversion.candyToBlob(#Blob(blob));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(blob));

    // Test case 2: Valid Bytes input
    let rawBytes : [Nat8] = [1, 2, 3];
    let bytes = StableBuffer.fromArray<Nat8>(rawBytes);
    let result2 = Conversion.candyToBlob(#Bytes(bytes));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(Blob.fromArray(rawBytes)));

    // Test case 3: Valid Text input
    let text = "hello";
    let result3 = Conversion.candyToBlob(#Text(text));
    Debug.print(debug_show(result3));
    assert(result3 == #ok(Blob.fromArray(Conversion.textToBytes(text))));

    // Test case 4: Valid Int input
    let intVal = 42;
    let result4 = Conversion.candyToBlob(#Int(intVal));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(Blob.fromArray(Conversion.intToBytes(intVal))));

    // Test case 5: Valid Nat input
    let natVal = 42;
    let result5 = Conversion.candyToBlob(#Nat(natVal));
    Debug.print(debug_show(result5));
    assert(result5 == #ok(Blob.fromArray(Conversion.natToBytes(natVal))));

    // Test case 6: Valid Principal input
    let principal = Principal.fromText("aaaaa-aa");
    let result6 = Conversion.candyToBlob(#Principal(principal));
    Debug.print(debug_show(result6));
    assert(result6 == #ok(Principal.toBlob(principal)));

    // Test case 7: Invalid type input
    let result7 = Conversion.candyToBlob(#Array(StableBuffer.fromArray<Types.Candy>([])));
    Debug.print(debug_show(result7));
    assert(result7 == #err("illegal cast to Blob"));

    Debug.print("All candyToBlob tests passed.");
  };
  test("testCandyToBlob", testCandyToBlob);

  func testCandyToValueArray() {
    // Test case 1: Valid Array input
    let rawArray : [Types.Candy] = [#Nat(1), #Nat(2), #Nat(3)];
    let array = StableBuffer.fromArray<Types.Candy>([#Nat(1), #Nat(2), #Nat(3)]);
    let result1 = Conversion.candyToValueArray(#Array(array));
    Debug.print(debug_show(result1));
    switch (result1) {
      case (#ok(innerArray)) {
        assert(Array.equal(innerArray, rawArray, Types.eq));
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 2: Empty Array input
    let emptyArray  = StableBuffer.fromArray<Types.Candy>([]);
    let result2 = Conversion.candyToValueArray(#Array(emptyArray));
    Debug.print(debug_show(result2));
    switch (result2) {
      case (#ok(innerArray)) {
        assert(Array.equal(innerArray, StableBuffer.toArray(emptyArray), Types.eq));
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };


    // Test case 3: Invalid type input
    let result3 = Conversion.candyToValueArray(#Text("invalid"));
    Debug.print(debug_show(result3));
    switch (result3) {
      case (#err(errMsg)) {
        assert(errMsg == "illegal cast to [Candy]");
      };
      case _ {
        assert(false);
      };
    };

    Debug.print("All candyToValueArray tests passed.");
  };
  test("testCandyToValueArray", testCandyToValueArray);

  func testCandyToBytesBuffer() {
    // Test case 1: Valid Bytes input
    let bytes: [Nat8] = [1, 2, 3];
    let result1 = Conversion.candyToBytesBuffer(#Bytes(StableBuffer.fromArray<Nat8>(bytes)));
    //Debug.print(debug_show(result1));
    assert(switch result1 {
        case(#ok(buffer)){ buffer.toArray() == bytes};
        case(#err(_)) {false};
    });

    // Test case 2: Valid Int input
    let intVal = 42;
    let result2 = Conversion.candyToBytesBuffer(#Int(intVal));
    //Debug.print(debug_show(result2));
    assert(switch result2 {
        case (#ok(buffer)) { buffer.toArray() == Conversion.intToBytes(intVal) };
        case (#err(_)) { false };
    });

    // Test case 3: Valid Nat input
    let natVal = 42;
    let result3 = Conversion.candyToBytesBuffer(#Nat(natVal));
    //Debug.print(debug_show(result3));
    assert(switch result3 {
        case (#ok(buffer)) { buffer.toArray() == Conversion.natToBytes(natVal) };
        case (#err(_)) { false };
    });

    // Test case 4: Valid Text input
    let text = "hello";
    let result4 = Conversion.candyToBytesBuffer(#Text(text));
    //Debug.print(debug_show(result4));
    assert(switch result4 {
        case (#ok(buffer)) { buffer.toArray() == Conversion.textToBytes(text) };
        case (#err(_)) { false };
    });

    // Test case 5: Valid Bool input
    let boolVal = true;
    let result5 = Conversion.candyToBytesBuffer(#Bool(boolVal));
    //Debug.print(debug_show(result5));
    assert(switch result5 {
        case (#ok(buffer)) { buffer.toArray() == Conversion.boolToBytes(boolVal) };
        case (#err(_)) { false };
    });

    // Test case 6: Valid Blob input
    let blob = Blob.fromArray([1, 2, 3]);
    let result6 = Conversion.candyToBytesBuffer(#Blob(blob));
    //Debug.print(debug_show(result6));
    assert(switch result6 {
        case (#ok(buffer)) { buffer.toArray() == Blob.toArray(blob) };
        case (#err(_)) { false };
    });

    // Test case 7: Valid Principal input
    let principal = Principal.fromText("aaaaa-aa");
    let result7 = Conversion.candyToBytesBuffer(#Principal(principal));
    //Debug.print(debug_show(result7));
    assert(switch result7 {
        case (#ok(buffer)) { buffer.toArray() == Conversion.principalToBytes(principal) };
        case (#err(_)) { false };
    });

    // Test case 8: Invalid type input
    let result8 = Conversion.candyToBytesBuffer(#Array(StableBuffer.fromArray<Types.Candy>([])));
    //Debug.print(debug_show(result8));
    assert(switch result8 {
        case (#err(msg)) { msg == "conversion from Array to Bytes not implemented" };
        case (_) { false };
    });

    Debug.print("All candyToBytesBuffer tests passed.");
  };
  test("testCandyToBytesBuffer", testCandyToBytesBuffer);

  func testCandyToMap() {
    // Test case 1: Valid Map input
    let map = Map.new<Text, Types.Candy>();
    ignore Map.put(map, Map.thash, "key1", #Nat(42));
    ignore Map.put(map, Map.thash, "key2", #Text("value"));
    let result1 = Conversion.candyToMap(#Map(map));
    Debug.print(debug_show(result1));
    switch (result1) {
        case (#ok(resMap)) {
          
            assert(Map.size(resMap) == 2);
            switch (Map.get(resMap, Map.thash, "key1")) {
                case (?#Nat(42)) {};
                case (_) { assert(false); };
            };
            switch (Map.get(resMap, Map.thash, "key2")) {
                case (?#Text("value")) {};
                case (_) { assert(false); };
            };
        };
        case (#err(errMsg)) {
            Debug.print("Unexpected error: " # errMsg);
            assert(false);
        };
    };


    // Test case 2: Empty Map input
    let emptyMap = Map.new<Text, Types.Candy>();
    let result2 = Conversion.candyToMap(#Map(emptyMap));
    Debug.print(debug_show(result2));
    switch (result2) {
        case (#ok(resMap)) {
            assert(Array.equal<(Text, Types.Candy)>(Iter.toArray(Map.entries(resMap)), Iter.toArray(Map.entries(emptyMap)), func ((k1, v1), (k2, v2)) { k1 == k2 and Types.eq(v1,v2) }));
        };
        case (#err(errMsg)) {
            Debug.print("Unexpected error: " # errMsg);
            assert(false);
        };
    };


    // Test case 3: Invalid type input
    let result3 = Conversion.candyToMap(#Text("invalid"));
    Debug.print(debug_show(result3));
    switch (result3) {
        case (#err(errMsg)) {
            assert(errMsg == "conversion to Map<Text, Candy> not supported");
        };
        case (_) {
            assert(false);
        };
    };

    Debug.print("All candyToMap tests passed.");
  };
  test("testCandyToMap", testCandyToMap);

  func testCandyToBytes() {
    // Test case 1: Valid Int input
    let intVal = 42;
    let result1 = Conversion.candyToBytes(#Int(intVal));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(Conversion.intToBytes(intVal)));

    // Test case 2: Valid Nat input
    let natVal = 42;
    let result2 = Conversion.candyToBytes(#Nat(natVal));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(Conversion.natToBytes(natVal)));

    // Test case 3: Valid Nat8 input
    let nat8Val : Nat8 = 255;
    let result3 = Conversion.candyToBytes(#Nat8(nat8Val));
    Debug.print(debug_show(result3));
    assert(result3 == #ok([nat8Val]));

    // Test case 4: Valid Text input
    let text = "hello";
    let result4 = Conversion.candyToBytes(#Text(text));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(Conversion.textToBytes(text)));

    // Test case 5: Valid Bool input
    let boolVal = true;
    let result5 = Conversion.candyToBytes(#Bool(boolVal));
    Debug.print(debug_show(result5));
    assert(result5 == #ok(Conversion.boolToBytes(boolVal)));

    // Test case 6: Valid Blob input
    let blob = Blob.fromArray([1, 2, 3]);
    let result6 = Conversion.candyToBytes(#Blob(blob));
    Debug.print(debug_show(result6));
    assert(result6 == #ok(Blob.toArray(blob)));

    // Test case 7: Valid Principal input
    let principal = Principal.fromText("aaaaa-aa");
    let result7 = Conversion.candyToBytes(#Principal(principal));
    Debug.print(debug_show(result7));
    assert(result7 == #ok(Conversion.principalToBytes(principal)));

    // Test case 8: Invalid type input
    let result8 = Conversion.candyToBytes(#Array(StableBuffer.fromArray<Types.Candy>([])));
    Debug.print(debug_show(result8));
    switch (result8) {
      case (#err(errMsg)) {
        assert(errMsg == "conversion from Array to Bytes not implemented");
      };
      case _ {
        assert(false);
      };
    };

    Debug.print("All candyToBytes tests passed.");
  };
  test("testCandyToBytes", testCandyToBytes);

  func testCandyToNatsBuffer() {
    // Test case 1: Valid Nats input
    let nats : [Nat] = [1,2,3];
    let result1 = Conversion.candyToNatsBuffer(#Nats(StableBuffer.fromArray<Nat>(nats)));
    //Debug.print(debug_show(result1));
    assert(switch result1 {
        case (#ok(buffer)) { buffer.toArray() == nats };
        case (#err(_)) { false };
    });

    // Test case 2: Valid Nat input
    let natVal = 42;
    let result2 = Conversion.candyToNatsBuffer(#Nat(natVal));
    //Debug.print(debug_show(result2));
    assert(switch result2 {
        case (#ok(buffer)) { buffer.toArray() == [natVal] };
        case (#err(_)) { false };
    });

    // Test case 3: Invalid type input
    let result3 = Conversion.candyToNatsBuffer(#Text("invalid"));
    //Debug.print(debug_show(result3));
    assert(switch result3 {
        case (#err(msg)) { 
          Debug.print("Error message: " # msg);
          msg == "illegal cast" };
        case (_) { false };
    });

    Debug.print("All candyToNatsBuffer tests passed.");
  };
  test("testCandyToNatsBuffer", testCandyToNatsBuffer);

  func testCandyToFloatsBuffer() {
    // Test case 1: Valid Floats input
    let floats = [1.1, 2.2, 3.3];
    let result1 = Conversion.candyToFloatsBuffer(#Floats(StableBuffer.fromArray<Float>(floats)));
    //Debug.print(debug_show(result1));
    assert(switch result1 {
        case (#ok(buffer)) { buffer.toArray() == floats };
        case (#err(_)) { false };
    });

    // Test case 2: Valid Float input
    let floatVal = 42.5;
    let result2 = Conversion.candyToFloatsBuffer(#Float(floatVal));
    //Debug.print(debug_show(result2));
    assert(switch result2 {
        case (#ok(buffer)) { buffer.toArray() == [floatVal] };
        case (#err(_)) { false };
    });

    // Test case 3: Invalid type input
    let result3 = Conversion.candyToFloatsBuffer(#Text("invalid"));
    //Debug.print(debug_show(result3));
    assert(switch result3 {
        case (#err(msg)) { msg == "illegal cast" };
        case (_) { false };
    });

    Debug.print("All candyToFloatsBuffer tests passed.");
  };
  test("testCandyToFloatsBuffer", testCandyToFloatsBuffer);

  func testBytesToInt() {
    Debug.print("Testing bytesToInt..." # debug_show(Conversion.intToBytes(0)));
    // Test case 1: Convert bytes representing a positive Int
    let bytes1: [Nat8] = [0, 42];
    let #ok(result1) = Conversion.bytesToInt(bytes1) else return assert(false);
    Debug.print(debug_show(result1));
    assert(result1 == 42);

    // Test case 2: Convert bytes representing a negative Int
    let bytes2: [Nat8] = [1, 42];
    let #ok(result2) = Conversion.bytesToInt(bytes2) else return assert(false);
    Debug.print(debug_show(result2));
    assert(result2 == -42);

    // Test case 3: Convert bytes representing zero
    let bytes3: [Nat8] = [0];
    let #ok(result3) = Conversion.bytesToInt(bytes3) else return assert false;
    Debug.print(debug_show(result3));
    assert(result3 == 0); //special case

    // Test case 4: Convert bytes representing a large positive Int
    let bytes4: [Nat8] = [0, 1, 0];
    let #ok(result4) = Conversion.bytesToInt(bytes4) else return assert(false);
    Debug.print(debug_show(result4));
    assert(result4 == 128);

    // Test case 5: Convert bytes representing a large negative Int
    let bytes5: [Nat8] = [1, 1, 0];
    let #ok(result5) = Conversion.bytesToInt(bytes5) else return assert(false);
    Debug.print(debug_show(result5));
    assert(result5 == -128);

    // Test case 6: Invalid bytes input (empty array)
    let #err(result6) =  Conversion.bytesToInt([]) else return assert(false);
    Debug.print(debug_show(result6));
    assert(result6 == "Invalid byte array size for conversion to Int");

    Debug.print("All bytesToInt tests passed.");
  };
  test("testBytesToInt", testBytesToInt);

  func testBytesToNat() {
    // Test case 1: Convert bytes representing a small Nat and back
    let natVal1 = 42;
    let bytes1 = Conversion.natToBytes(natVal1);
    Debug.print(debug_show(bytes1));
    let result1 = Conversion.bytesToNat(bytes1);
    Debug.print(debug_show(result1));
    assert(result1 == natVal1);

    // Test case 2: Convert bytes representing zero and back
    let natVal2 = 0;
    let bytes2 = Conversion.natToBytes(natVal2);
    Debug.print(debug_show(bytes2));
    let result2 = Conversion.bytesToNat(bytes2);
    Debug.print(debug_show(result2));
    assert(result2 == natVal2);

    // Test case 3: Convert bytes representing a large Nat and back
    let natVal3 = 12345678901234567890;
    let bytes3 = Conversion.natToBytes(natVal3);
    Debug.print(debug_show(bytes3));
    let result3 = Conversion.bytesToNat(bytes3);
    Debug.print(debug_show(result3));
    assert(result3 == natVal3);

    // Test case 4: Invalid bytes input (empty array)
    let result4 =  Conversion.bytesToNat([]);
    Debug.print(debug_show(result4));
    assert(result4 == 0);

    Debug.print("All bytesToNat tests passed.");
  };
  test("testBytesToNat", testBytesToNat);

  func testBytesToNat16() {
    // Test case 1: Convert bytes representing a small Nat16 and back
    let nat16Val1: Nat16 = 42;
    let bytes1 = Conversion.nat16ToBytes(nat16Val1);
    Debug.print(debug_show(bytes1));
    let result1 = Conversion.bytesToNat16(bytes1);
    Debug.print(debug_show(result1));
    assert(result1 == nat16Val1);

    // Test case 2: Convert bytes representing zero and back
    let nat16Val2: Nat16 = 0;
    let bytes2 = Conversion.nat16ToBytes(nat16Val2);
    Debug.print(debug_show(bytes2));
    let result2 = Conversion.bytesToNat16(bytes2);
    Debug.print(debug_show(result2));
    assert(result2 == nat16Val2);

    // Test case 3: Convert bytes representing the maximum Nat16 and back
    let nat16Val3: Nat16 = 65535;
    let bytes3 = Conversion.nat16ToBytes(nat16Val3);
    Debug.print(debug_show(bytes3));
    let result3 = Conversion.bytesToNat16(bytes3);
    Debug.print(debug_show(result3));
    assert(result3 == nat16Val3);

    // Test case 4: Invalid bytes input (empty array)
    let result4 = Conversion.bytesToNat16([]);
    Debug.print(debug_show(result4));
    assert(result4 == #ok(0));

    Debug.print("All bytesToNat16 tests passed.");
  };
  test("testBytesToNat16", testBytesToNat16);

  func testBytesToNat64() {
    // Test case 1: Convert bytes representing a small Nat64 and back
    let nat64Val1: Nat64 = 42;
    let bytes1 = Conversion.nat64ToBytes(nat64Val1);
    Debug.print(debug_show(bytes1));
    let result1 = Conversion.bytesToNat64(bytes1);
    Debug.print(debug_show(result1));
    assert(result1 == nat64Val1);

    // Test case 2: Convert bytes representing zero and back
    let nat64Val2: Nat64 = 0;
    let bytes2 = Conversion.nat64ToBytes(nat64Val2);
    Debug.print(debug_show(bytes2));
    let result2 = Conversion.bytesToNat64(bytes2);
    Debug.print(debug_show(result2));
    assert(result2 == nat64Val2);

    // Test case 3: Convert bytes representing the maximum Nat64 and back
    let nat64Val3: Nat64 = 18446744073709551615;
    let bytes3 = Conversion.nat64ToBytes(nat64Val3);
    Debug.print(debug_show(bytes3));
    let result3 = Conversion.bytesToNat64(bytes3);
    Debug.print(debug_show(result3));
    assert(result3 == nat64Val3);

    // Test case 4: Invalid bytes input (empty array)
    let result4 = Conversion.bytesToNat64([]);
     
    Debug.print(debug_show(result4));
    assert(result4 == #ok(0));

    Debug.print("All bytesToNat64 tests passed.");
  };
  test("testBytesToNat64", testBytesToNat64);


  func testBytesToPrincipal() {
    // Test case 1: Valid bytes input for Principal "aaaaa-aa"
    let bytes: [Nat8] = [1, 1, 1, 1, 1, 1, 1];
    let expectedPrincipal = Principal.fromText("djcse-wqbae-aqcai-bae");
    let result1 = Conversion.bytesToPrincipal(bytes);
    Debug.print(debug_show(result1));
    assert(result1 == expectedPrincipal);

    // Test case 2: Valid bytes input for Principal "bbbbb-bb"
    let bytes2: [Nat8] = [2, 2, 2, 2, 2, 2, 2];
    
    let result2 = Conversion.bytesToPrincipal(bytes2);
  
    Debug.print(debug_show(result2));
    let expectedPrincipal2 = Principal.fromText("jbhcg-5ycai-baeaq-cai");
    assert(result2 == expectedPrincipal2);

    Debug.print("All bytesToPrincipal tests passed.");
  };
  test("testBytesToPrincipal", testBytesToPrincipal);

  func testBytesToText() {
    // Test case 1: Valid bytes input representing "hello"
    let bytes: [Nat8] = [0, 0, 0, 104, 0, 0, 0, 101, 0, 0, 0, 108, 0, 0, 0, 108, 0, 0, 0, 111];
    let result1 = Conversion.bytesToText(bytes);
    Debug.print(debug_show(result1));
    assert(result1 == "hello");

    // Test case 2: Valid bytes input representing an empty string
    let emptyBytes: [Nat8] = [];
    let result2 = Conversion.bytesToText(emptyBytes);
    Debug.print(debug_show(result2));
    assert(result2 == "");

    // Test case 3: Valid bytes input with partial characters
    let partialBytes: [Nat8] = [0, 0, 0, 65, 0, 0, 0, 66];
    let result3 = Conversion.bytesToText(partialBytes);
    Debug.print(debug_show(result3));
    assert(result3 == "AB");

    Debug.print("All bytesToText tests passed.");
  };
  test("testBytesToText", testBytesToText);

  func testCandySharedToBlob() {
    // Test case 1: Valid Blob input
    let blob = Blob.fromArray([1, 2, 3]);
    let result1 = Conversion.candySharedToBlob(#Blob(blob));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(blob));

    // Test case 2: Valid Bytes input
    let bytes: [Nat8] = [1, 2, 3];
    let result2 = Conversion.candySharedToBlob(#Bytes(bytes));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(Blob.fromArray(bytes)));

    // Test case 3: Valid Text input
    let text = "hello";
    let result3 = Conversion.candySharedToBlob(#Text(text));
    Debug.print(debug_show(result3));
    assert(result3 == #ok(Blob.fromArray(Conversion.textToBytes(text))));

    // Test case 4: Valid Int input
    let intVal = 42;
    let result4 = Conversion.candySharedToBlob(#Int(intVal));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(Blob.fromArray(Conversion.intToBytes(intVal))));

    // Test case 5: Valid Nat input
    let natVal = 42;
    let result5 = Conversion.candySharedToBlob(#Nat(natVal));
    Debug.print(debug_show(result5));
    assert(result5 == #ok(Blob.fromArray(Conversion.natToBytes(natVal))));

    // Test case 6: Valid Principal input
    let principal = Principal.fromText("aaaaa-aa");
    let result6 = Conversion.candySharedToBlob(#Principal(principal));
    Debug.print(debug_show(result6));
    assert(result6 == #ok(Principal.toBlob(principal)));

    // Test case 7: Invalid type input
    let result7 = Conversion.candySharedToBlob(#Array([]));
    Debug.print(debug_show(result7));
    assert(result7 == #err("illegal cast to Blob"));

    Debug.print("All candySharedToBlob tests passed.");
  };
  test("testCandySharedToBlob", testCandySharedToBlob);

  func testCandySharedToBool() {
    // Test case 1: Valid Bool input (true)
    let result1 = Conversion.candySharedToBool(#Bool(true));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(true));

    // Test case 2: Valid Bool input (false)
    let result2 = Conversion.candySharedToBool(#Bool(false));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(false));

    // Test case 3: Invalid type input
    let result3 = Conversion.candySharedToBool(#Text("invalid"));
    Debug.print(debug_show(result3));
    assert(result3 == #err("illegal cast to Bool"));

    Debug.print("All candySharedToBool tests passed.");
  };
  test("testCandySharedToBool", testCandySharedToBool);

  func testCandySharedToBytesBuffer() {
    // Test case 1: Valid Bytes input
    let bytes: [Nat8] = [1, 2, 3];
    let result1 = Conversion.candySharedToBytesBuffer(#Bytes(bytes));
    //Debug.print(debug_show(result1));
    switch (result1) {
      case (#ok(buffer)) {
        assert(buffer.toArray() == bytes);
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };


    // Test case 2: Valid Int input
    let intVal = 42;
    let result2 = Conversion.candySharedToBytesBuffer(#Int(intVal));
    //Debug.print(debug_show(result2));
    switch (result2) {
      case (#ok(buffer)) {
        assert(buffer.toArray() == Conversion.intToBytes(intVal));
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 3: Valid Nat input
    let natVal = 42;
    let result3 = Conversion.candySharedToBytesBuffer(#Nat(natVal));
    //Debug.print(debug_show(result3));
    switch (result3) {
      case (#ok(buffer)) {
        assert(buffer.toArray() == Conversion.natToBytes(natVal));
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 4: Valid Text input
    let text = "hello";
    let result4 = Conversion.candySharedToBytesBuffer(#Text(text));
    //Debug.print(debug_show(result4));
    switch (result4) {
      case (#ok(buffer)) {
        assert(buffer.toArray() == Conversion.textToBytes(text));
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 5: Valid Bool input
    let boolVal = true;
    let result5 = Conversion.candySharedToBytesBuffer(#Bool(boolVal));
    //Debug.print(debug_show(result5));
    switch (result5) {
      case (#ok(buffer)) {
        assert(buffer.toArray() == Conversion.boolToBytes(boolVal));
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 6: Valid Blob input
    let blob = Blob.fromArray([1, 2, 3]);
    let result6 = Conversion.candySharedToBytesBuffer(#Blob(blob));
    //Debug.print(debug_show(result6));
    switch (result6) {
      case (#ok(buffer)) {
        assert(buffer.toArray() == Blob.toArray(blob));
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 7: Valid Principal input
    let principal = Principal.fromText("aaaaa-aa");
    let result7 = Conversion.candySharedToBytesBuffer(#Principal(principal));
    //Debug.print(debug_show(result7));
    switch (result7) {
      case (#ok(buffer)) {
        assert(buffer.toArray() == Conversion.principalToBytes(principal));
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 8: Invalid type input
    let result8 = Conversion.candySharedToBytesBuffer(#Array([]));
    //Debug.print(debug_show(result8));
    switch (result8) {
      case (#err(errMsg)) {
        assert(errMsg == "conversion from Array to Bytes not implemented");
      };
      case (_) {
        assert(false);
      };
    };

    Debug.print("All candySharedToBytesBuffer tests passed.");
  };
  test("testCandySharedToBytesBuffer", testCandySharedToBytesBuffer);

  func testCandySharedToFloat() {
    // Test case 1: Valid Float input
    let result1 = Conversion.candySharedToFloat(#Float(42.5));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(42.5));

    // Test case 2: Valid Int input
    let result2 = Conversion.candySharedToFloat(#Int(42));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(42.0));

    // Test case 3: Valid Int8 input
    let result3 = Conversion.candySharedToFloat(#Int8(-128));
    Debug.print(debug_show(result3));
    assert(result3 == #ok(-128.0));

    // Test case 4: Valid Int16 input
    let result4 = Conversion.candySharedToFloat(#Int16(32767));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(32767.0));

    // Test case 5: Valid Int32 input
    let result5 = Conversion.candySharedToFloat(#Int32(-2147483648));
    Debug.print(debug_show(result5));
    assert(result5 == #ok(-2147483648.0));

    // Test case 6: Valid Int64 input
    let result6 = Conversion.candySharedToFloat(#Int64(9223372036854775807));
    Debug.print(debug_show(result6));
    assert(result6 == #ok(9223372036854775807.0));

    // Test case 7: Valid Nat input
    let result7 = Conversion.candySharedToFloat(#Nat(42));
    Debug.print(debug_show(result7));
    assert(result7 == #ok(42.0));

    // Test case 8: Invalid type input
    let result8 = Conversion.candySharedToFloat(#Text("invalid"));
    Debug.print(debug_show(result8));
    assert(result8 == #err("illegal cast to Float"));

    Debug.print("All candySharedToFloat tests passed.");
  };
  test("testCandySharedToFloat", testCandySharedToFloat);

  func testCandySharedToFloatsBuffer() {
    // Test case 1: Valid Floats input
    let floats: [Float] = [1.1, 2.2, 3.3];
    let result1 = Conversion.candySharedToFloatsBuffer(#Floats(floats));
    //Debug.print(debug_show(result1));
    switch (result1) {
      case (#ok(buffer)) {
        assert(buffer.toArray() == floats);
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 2: Valid Float input
    let floatVal = 42.5;
    let result2 = Conversion.candySharedToFloatsBuffer(#Float(floatVal));
    //Debug.print(debug_show(result2));
    switch (result2) {
      case (#ok(buffer)) {
        assert(buffer.toArray() == [floatVal]);
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 3: Invalid type input
    let #err(result3) = Conversion.candySharedToFloatsBuffer(#Text("invalid")) else return assert(false);
    Debug.print(debug_show(result3));
    
    assert(result3 == "illegal cast to Float");
     

    Debug.print("All candySharedToFloatsBuffer tests passed.");
  };
  test("testCandySharedToFloatsBuffer", testCandySharedToFloatsBuffer);

  func testCandySharedToInt() {
    // Test case 1: Valid Int input
    let result1 = Conversion.candySharedToInt(#Int(42));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(42));

    // Test case 2: Valid Int8 input
    let result2 = Conversion.candySharedToInt(#Int8(-128));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(-128));

    // Test case 3: Valid Int16 input
    let result3 = Conversion.candySharedToInt(#Int16(32767));
    Debug.print(debug_show(result3));
    assert(result3 == #ok(32767));

    // Test case 4: Valid Int32 input
    let result4 = Conversion.candySharedToInt(#Int32(-2147483648));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(-2147483648));

    // Test case 5: Valid Int64 input
    let result5 = Conversion.candySharedToInt(#Int64(9223372036854775807));
    Debug.print(debug_show(result5));
    assert(result5 == #ok(9223372036854775807));

    // Test case 6: Valid Nat input
    let result6 = Conversion.candySharedToInt(#Nat(42));
    Debug.print(debug_show(result6));
    assert(result6 == #ok(42));

    // Test case 7: Valid Float input
    let result7 = Conversion.candySharedToInt(#Float(42.5));
    Debug.print(debug_show(result7));
    assert(result7 == #ok(42));

    // Test case 8: Invalid type input
    let result8 = Conversion.candySharedToInt(#Text("invalid"));
    Debug.print(debug_show(result8));
    assert(result8 == #err("illegal cast to Int"));

    Debug.print("All candySharedToInt tests passed.");
  };
  test("testCandySharedToInt", testCandySharedToInt);

  func testCandySharedToInt8() {
    // Test case 1: Valid Int8 input
    let result1 = Conversion.candySharedToInt8(#Int8(-128));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(-128));

    // Test case 2: Valid Int input within Int8 range
    let result2 = Conversion.candySharedToInt8(#Int(42));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(42));

    // Test case 3: Int input exceeding Int8 range
    let result3 = Conversion.candySharedToInt8(#Int(200));
    Debug.print(debug_show(result3));
    assert(result3 == #err("overflow while converting Int to Int8"));

    // Test case 4: Valid Nat8 input
    let result4 = Conversion.candySharedToInt8(#Nat8(127));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(127));

    // Test case 5: Nat8 input exceeding Int8 range
    let #err(result5) = Conversion.candySharedToInt8(#Nat8(255)) else return assert(false);
    Debug.print(debug_show(result5));
    assert(result5 == "overflow while converting Nat8 to Int8");

    // Test case 6: Valid Float input within Int8 range
    let result6 = Conversion.candySharedToInt8(#Float(42.0));
    Debug.print(debug_show(result6));
    assert(result6 == #ok(42));

    // Test case 7: Negative Float input
    let result7 = Conversion.candySharedToInt8(#Float(-42.0));
    Debug.print(debug_show(result7));
    assert(result7 == #ok(-42));

    // Test case 8: Invalid type input
    let result8 = Conversion.candySharedToInt8(#Text("invalid"));
    Debug.print(debug_show(result8));
    assert(result8 == #err("illegal cast to Int8"));

    Debug.print("All candySharedToInt8 tests passed.");
  };
  test("testCandySharedToInt8", testCandySharedToInt8);

  func testCandySharedToInt16() {
    // Test case 1: Valid Int16 input
    let result1 = Conversion.candySharedToInt16(#Int16(32767));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(32767));

    // Test case 2: Valid Int input within Int16 range
    let result2 = Conversion.candySharedToInt16(#Int(-32768));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(-32768));

    // Test case 3: Int input exceeding Int16 range
    let result3 = Conversion.candySharedToInt16(#Int(40000));
    Debug.print(debug_show(result3));
    assert(result3 == #err("overflow while converting Int to Int16"));

    // Test case 4: Valid Nat16 input
    let result4 = Conversion.candySharedToInt16(#Nat16(32767));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(32767));

    // Test case 5: Nat16 input exceeding Int16 range
    let result5 = Conversion.candySharedToInt16(#Nat16(65535));
    Debug.print(debug_show(result5));
    assert(result5 == #err("overflow while converting Nat16 to Int16"));

    // Test case 6: Valid Float input within Int16 range
    let result6 = Conversion.candySharedToInt16(#Float(42.0));
    Debug.print(debug_show(result6));
    assert(result6 == #ok(42));

    // Test case 7: Negative Float input
    let result7 = Conversion.candySharedToInt16(#Float(-42.0));
    Debug.print(debug_show(result7));
    assert(result7 == #ok(-42));

    // Test case 8: Invalid type input
    let result8 = Conversion.candySharedToInt16(#Text("invalid"));
    Debug.print(debug_show(result8));
    assert(result8 == #err("illegal cast to Int16"));

    Debug.print("All candySharedToInt16 tests passed.");
  };
  test("testCandySharedToInt16", testCandySharedToInt16);

  func testCandySharedToInt32() {
    // Test case 1: Valid Int32 input
    let result1 = Conversion.candySharedToInt32(#Int32(2147483647));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(2147483647));

    // Test case 2: Valid Int input within Int32 range
    let result2 = Conversion.candySharedToInt32(#Int(-2147483648));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(-2147483648));

    // Test case 3: Int input exceeding Int32 range
    let result3 = Conversion.candySharedToInt32(#Int(3000000000));
    Debug.print(debug_show(result3));
    assert(result3 == #err("overflow while converting Int to Int32"));

    // Test case 4: Valid Nat32 input
    let result4 = Conversion.candySharedToInt32(#Nat32(2147483647));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(2147483647));

    // Test case 5: Nat32 input exceeding Int32 range
    let result5 = Conversion.candySharedToInt32(#Nat32(4294967295));
    Debug.print(debug_show(result5));
    assert(result5 == #err("overflow while converting Nat32 to Int32"));

    // Test case 6: Valid Float input within Int32 range
    let result6 = Conversion.candySharedToInt32(#Float(42.0));
    Debug.print(debug_show(result6));
    assert(result6 == #ok(42));

    // Test case 7: Negative Float input
    let result7 = Conversion.candySharedToInt32(#Float(-42.0));
    Debug.print(debug_show(result7));
    assert(result7 == #ok(-42));

    // Test case 8: Invalid type input
    let result8 = Conversion.candySharedToInt32(#Text("invalid"));
    Debug.print(debug_show(result8));
    assert(result8 == #err("illegal cast to Int32"));

    Debug.print("All candySharedToInt32 tests passed.");
  };
  test("testCandySharedToInt32", testCandySharedToInt32);

  func testCandySharedToInt64() {
    // Test case 1: Valid Int64 input
    let result1 = Conversion.candySharedToInt64(#Int64(9223372036854775807));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(9223372036854775807));

    // Test case 2: Valid Int input within Int64 range
    let result2 = Conversion.candySharedToInt64(#Int(-9223372036854775808));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(-9223372036854775808));

    // Test case 3: Int input exceeding Int64 range
    let result3 = Conversion.candySharedToInt64(#Int(10000000000000000000));
    Debug.print(debug_show(result3));
    assert(result3 == #err("overflow while converting Int to Int64"));

    // Test case 4: Valid Nat64 input
    let result4 = Conversion.candySharedToInt64(#Nat64(9223372036854775807));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(9223372036854775807));

    // Test case 5: Nat64 input exceeding Int64 range
    let result5 = Conversion.candySharedToInt64(#Nat64(18446744073709551615));
    Debug.print(debug_show(result5));
    assert(result5 == #err("overflow while converting Nat64 to Int64"));

    // Test case 6: Valid Float input within Int64 range
    let result6 = Conversion.candySharedToInt64(#Float(42.0));
    Debug.print(debug_show(result6));
    assert(result6 == #ok(42));

    // Test case 7: Negative Float input
    let result7 = Conversion.candySharedToInt64(#Float(-42.0));
    Debug.print(debug_show(result7));
    assert(result7 == #ok(-42));

    // Test case 8: Invalid type input
    let result8 = Conversion.candySharedToInt64(#Text("invalid"));
    Debug.print(debug_show(result8));
    assert(result8 == #err("illegal cast to Int64"));

    Debug.print("All candySharedToInt64 tests passed.");
  };
  test("testCandySharedToInt64", testCandySharedToInt64);

  func testCandySharedToIntsBuffer() {
    // Test case 1: Valid Ints input
    let ints: [Int] = [1, -2, 3];
    let result1 = Conversion.candySharedToIntsBuffer(#Ints(ints));
    //Debug.print(debug_show(result1));
    switch (result1) {
      case (#ok(buffer)) {
        assert(buffer.toArray() == ints);
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 2: Valid Int input
    let intVal = 42;
    let result2 = Conversion.candySharedToIntsBuffer(#Int(intVal));
    //Debug.print(debug_show(result2));
    switch (result2) {
      case (#ok(buffer)) {
        assert(buffer.toArray() == [intVal]);
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 3: Invalid type input
    let result3 = Conversion.candySharedToIntsBuffer(#Text("invalid"));
    //Debug.print(debug_show(result3));
    switch (result3) {
      case (#err(errMsg)) {
        Debug.print("Expected error: " # errMsg);
        assert(errMsg == "illegal cast to Int");
      };
      case (_) {
        assert(false);
      };
    };

    Debug.print("All candySharedToIntsBuffer tests passed.");
  };
  test("testCandySharedToIntsBuffer", testCandySharedToIntsBuffer);

  func testCandySharedToNat() {
    // Test case 1: Valid Nat input
    let result1 = Conversion.candySharedToNat(#Nat(42));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(42));

    // Test case 2: Valid Nat8 input
    let result2 = Conversion.candySharedToNat(#Nat8(255));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(255));

    // Test case 3: Valid Float input
    let result3 = Conversion.candySharedToNat(#Float(42.0));
    Debug.print(debug_show(result3));
    assert(result3 == #ok(42));

    // Test case 4: Negative Float input
    let result4 = Conversion.candySharedToNat(#Float(-42.0));
    Debug.print(debug_show(result4));
    assert(result4 == #err("illegal cast"));

    // Test case 5: Invalid type input
    let result5 = Conversion.candySharedToNat(#Text("invalid"));
    Debug.print(debug_show(result5));
    assert(result5 == #err("illegal cast"));

    // Test case 6: Negative Int input
    let result6 = Conversion.candySharedToNat(#Int(-42));
    Debug.print(debug_show(result6));
    assert(result6 == #err("illegal cast"));

    // Test case 7: Valid Int input
    let result7 = Conversion.candySharedToNat(#Int(42));
    Debug.print(debug_show(result7));
    assert(result7 == #ok(42));

    Debug.print("All candySharedToNat tests passed.");
  };
  test("testCandySharedToNat", testCandySharedToNat);

  func testCandySharedToNat8() {
    // Test case 1: Valid Nat8 input
    let result1 = Conversion.candySharedToNat8(#Nat8(255));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(255));

    // Test case 2: Valid Nat input within Nat8 range
    let result2 = Conversion.candySharedToNat8(#Nat(42));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(42));

    // Test case 3: Nat input exceeding Nat8 range
    let result3 = Conversion.candySharedToNat8(#Nat(300));
    Debug.print(debug_show(result3));
    assert(result3 == #err("overflow while converting Nat to Nat8"));

    // Test case 4: Valid Float input within Nat8 range
    let result4 = Conversion.candySharedToNat8(#Float(42.0));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(42));

    // Test case 5: Negative Float input
    let result5 = Conversion.candySharedToNat8(#Float(-42.0));
    Debug.print(debug_show(result5));
    assert(result5 == #err("illegal cast"));

    // Test case 6: Invalid type input
    let result6 = Conversion.candySharedToNat8(#Text("invalid"));
    Debug.print(debug_show(result6));
    assert(result6 == #err("illegal cast"));

    // Test case 7: Negative Int input
    let result7 = Conversion.candySharedToNat8(#Int(-42));
    Debug.print(debug_show(result7));
    assert(result7 == #err("illegal cast"));

    // Test case 8: Valid Int input within Nat8 range
    let result8 = Conversion.candySharedToNat8(#Int(42));
    Debug.print(debug_show(result8));
    assert(result8 == #ok(42));

    Debug.print("All candySharedToNat8 tests passed.");
  };
  test("testCandySharedToNat8", testCandySharedToNat8);

  func testCandySharedToNat16() {
    // Test case 1: Valid Nat16 input
    let result1 = Conversion.candySharedToNat16(#Nat16(65535));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(65535));

    // Test case 2: Valid Nat input within Nat16 range
    let result2 = Conversion.candySharedToNat16(#Nat(42));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(42));

    // Test case 3: Nat input exceeding Nat16 range
    let result3 = Conversion.candySharedToNat16(#Nat(70000));
    Debug.print(debug_show(result3));
    assert(result3 == #err("overflow while converting Nat to Nat16"));

    // Test case 4: Valid Float input within Nat16 range
    let result4 = Conversion.candySharedToNat16(#Float(42.0));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(42));

    // Test case 5: Negative Float input
    let result5 = Conversion.candySharedToNat16(#Float(-42.0));
    Debug.print(debug_show(result5));
    assert(result5 == #err("illegal cast"));

    // Test case 6: Invalid type input
    let result6 = Conversion.candySharedToNat16(#Text("invalid"));
    Debug.print(debug_show(result6));
    assert(result6 == #err("illegal cast"));

    // Test case 7: Negative Int input
    let result7 = Conversion.candySharedToNat16(#Int(-42));
    Debug.print(debug_show(result7));
    assert(result7 == #err("illegal cast"));

    // Test case 8: Valid Int input within Nat16 range
    let result8 = Conversion.candySharedToNat16(#Int(42));
    Debug.print(debug_show(result8));
    assert(result8 == #ok(42));

    Debug.print("All candySharedToNat16 tests passed.");
  };
  test("testCandySharedToNat16", testCandySharedToNat16);

  func testCandySharedToNat32() {
    // Test case 1: Valid Nat32 input
    let result1 = Conversion.candySharedToNat32(#Nat32(4294967295));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(4294967295));

    // Test case 2: Valid Nat input within Nat32 range
    let result2 = Conversion.candySharedToNat32(#Nat(42));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(42));

    // Test case 3: Nat input exceeding Nat32 range
    let result3 = Conversion.candySharedToNat32(#Nat(5000000000));
    Debug.print(debug_show(result3));
    assert(result3 == #err("overflow while converting Nat to Nat32"));

    // Test case 4: Valid Float input within Nat32 range
    let result4 = Conversion.candySharedToNat32(#Float(42.0));
    Debug.print(debug_show(result4));
    assert(result4 == #ok(42));

    // Test case 5: Negative Float input
    let result5 = Conversion.candySharedToNat32(#Float(-42.0));
    Debug.print(debug_show(result5));
    assert(result5 == #err("illegal cast"));

    // Test case 6: Invalid type input
    let result6 = Conversion.candySharedToNat32(#Text("invalid"));
    Debug.print(debug_show(result6));
    assert(result6 == #err("illegal cast"));

    // Test case 7: Negative Int input
    let result7 = Conversion.candySharedToNat32(#Int(-42));
    Debug.print(debug_show(result7));
    assert(result7 == #err("illegal cast"));

    // Test case 8: Valid Int input within Nat32 range
    let result8 = Conversion.candySharedToNat32(#Int(42));
    Debug.print(debug_show(result8));
    assert(result8 == #ok(42));

    Debug.print("All candySharedToNat32 tests passed.");
  };
  test("testCandySharedToNat32", testCandySharedToNat32);

  func testCandySharedToNat64() {
    // Test case 1: Valid Nat64 input
    let result1 = Conversion.candySharedToNat64(#Nat64(18446744073709551615));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(18446744073709551615));

    // Test case 2: Valid Nat input within Nat64 range
    let result2 = Conversion.candySharedToNat64(#Nat(42));
    Debug.print(debug_show(result2));
    assert(result2 == #ok(42));

    // Test case 3: Valid Float input within Nat64 range
    let result3 = Conversion.candySharedToNat64(#Float(42.0));
    Debug.print(debug_show(result3));
    assert(result3 == #ok(42));

    // Test case 4: Negative Float input
    let result4 = Conversion.candySharedToNat64(#Float(-42.0));
    Debug.print(debug_show(result4));
    assert(result4 == #err("illegal cast"));

    // Test case 5: Invalid type input
    let result5 = Conversion.candySharedToNat64(#Text("invalid"));
    Debug.print(debug_show(result5));
    assert(result5 == #err("illegal cast"));

    // Test case 6: Negative Int input
    let result6 = Conversion.candySharedToNat64(#Int(-42));
    Debug.print(debug_show(result6));
    assert(result6 == #err("illegal cast"));

    // Test case 7: Valid Int input within Nat64 range
    let result7 = Conversion.candySharedToNat64(#Int(42));
    Debug.print(debug_show(result7));
    assert(result7 == #ok(42));

    Debug.print("All candySharedToNat64 tests passed.");
  };
  test("testCandySharedToNat64", testCandySharedToNat64);

  func testCandySharedToNatsBuffer() {
    // Test case 1: Valid Nats input
    let nats: [Nat] = [1, 2, 3];
    let result1 = Conversion.candySharedToNatsBuffer(#Nats(nats));
    //Debug.print(debug_show(result1));
    switch (result1) {
      case (#ok(buffer)) {
        assert(buffer.toArray() == nats);
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 2: Valid Nat input
    let natVal = 42;
    let result2 = Conversion.candySharedToNatsBuffer(#Nat(natVal));
    //Debug.print(debug_show(result2));
    switch (result2) {
      case (#ok(buffer)) {
        assert(buffer.toArray() == [natVal]);
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 3: Invalid type input
    let result3 = Conversion.candySharedToNatsBuffer(#Text("invalid"));
    //Debug.print(debug_show(result3));
    switch (result3) {
      case (#err(errMsg)) {
        assert(errMsg == "conversion from Text to Buffer<Nat> not implemented");
      };
      case (_) {
        assert(false);
      };
    };

    Debug.print("All candySharedToNatsBuffer tests passed.");
  };

  func testCandySharedToPrincipal() {
    // Test case 1: Valid Principal input
    let principal = Principal.fromText("aaaaa-aa");
    let result1 = Conversion.candySharedToPrincipal(#Principal(principal));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(principal));

    // Test case 2: Invalid type input
    let result2 = Conversion.candySharedToPrincipal(#Text("invalid"));
    Debug.print(debug_show(result2));
    assert(result2 == #err("invalid principal"));

    Debug.print("All candySharedToPrincipal tests passed.");
  };
  test("testCandySharedToPrincipal", testCandySharedToPrincipal);

  func testCandySharedToProperties() {
    // Test case 1: Valid Class input
    let propertyMap = [ { name = "prop1"; value = #Nat(42); immutable = true },
    { name = "prop2"; value = #Text("value"); immutable = false }];
    let result1 = Conversion.candySharedToProperties(#Class(propertyMap));
    Debug.print(debug_show(result1));
    switch (result1) {
      case (#ok(resMap)) {
        assert(Array.size(resMap) == 2);
        if(resMap[0].name == "prop1") {
          assert(resMap[0].value == #Nat(42));
          assert(resMap[0].immutable == true);
        } else {
          assert(resMap[1].value == #Nat(42));
          assert(resMap[1].immutable == true);
        };
        if(resMap[0].name == "prop2") {
          assert(resMap[0].value == #Text("value"));
          assert(resMap[0].immutable == false);
        } else {
          assert(resMap[1].value == #Text("value"));
          assert(resMap[1].immutable == false);
        };
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 2: Empty Class input
    let emptyPropertyMap = [];
    let result2 = Conversion.candySharedToProperties(#Class([]));
    Debug.print(debug_show(result2));
    switch (result2) {
      case (#ok(resMap)) {
        assert(Array.size(resMap) == 0);
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 3: Invalid type input
    let result3 = Conversion.candySharedToProperties(#Text("invalid"));
    Debug.print(debug_show(result3));
    switch (result3) {
      case (#err(errMsg)) {
        assert(errMsg == "illegal cast to PropertiesShared");
      };
      case (_) {
        assert(false);
      };
    };

    Debug.print("All candySharedToProperties tests passed.");
  };
  test("testCandySharedToProperties", testCandySharedToProperties);

  func testCandySharedToText() {
    // Test case 1: Valid Text input
    let result1 = Conversion.candySharedToText(#Text("hello"));
    Debug.print(debug_show(result1));
    assert(result1 == #ok("hello"));

    // Test case 2: Valid Nat input
    let result2 = Conversion.candySharedToText(#Nat(42));
    Debug.print(debug_show(result2));
    assert(result2 == #ok("42"));

    // Test case 3: Valid Int input
    let result3 = Conversion.candySharedToText(#Int(-42));
    Debug.print(debug_show(result3));
    assert(result3 == #ok("-42"));

    // Test case 4: Valid Bool input
    let result4 = Conversion.candySharedToText(#Bool(true));
    Debug.print(debug_show(result4));
    assert(result4 == #ok("true"));

    // Test case 5: Valid Float input
    let result5 = Conversion.candySharedToText(#Float(42.5));
    Debug.print(debug_show(result5));
    assert(result5 == #ok("42.5"));

    // Test case 6: Valid Principal input
    let principal = Principal.fromText("aaaaa-aa");
    let result6 = Conversion.candySharedToText(#Principal(principal));
    Debug.print(debug_show(result6));
    assert(result6 == #ok(Principal.toText(principal)));

    // Test case 7: Valid Blob input
    let blob = Blob.fromArray([1, 2, 3]);
    let result7 = Conversion.candySharedToText(#Blob(blob));
    Debug.print(debug_show(result7));
    assert(result7 == #ok("010203")); // Assuming Hex encoding

    // Test case 8: Invalid type input
    let result8 = Conversion.candySharedToText(#Array([]));
    Debug.print(debug_show(result8));
    assert(result8 == #ok("[]"));

    Debug.print("All candySharedToText tests passed.");
  };
  test("testCandySharedToText", testCandySharedToText);

  func testCandySharedToValueArray() {
    // Test case 1: Valid Array input
    let array: [Types.CandyShared] = [#Nat(1), #Text("value"), #Bool(true)];
    let result1 = Conversion.candySharedToValueArray(#Array(array));
    Debug.print(debug_show(result1));
    switch (result1) {
      case (#ok(resArray)) {
        assert(resArray == array);
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 2: Empty Array input
    let emptyArray: [Types.CandyShared] = [];
    let result2 = Conversion.candySharedToValueArray(#Array(emptyArray));
    Debug.print(debug_show(result2));
    switch (result2) {
      case (#ok(resArray)) {
        assert(resArray == emptyArray);
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 3: Invalid type input
    let result3 = Conversion.candySharedToValueArray(#Text("invalid"));
    Debug.print(debug_show(result3));
    switch (result3) {
      case (#err(errMsg)) {
        assert(errMsg == "illegal cast to [CandyShared]");
      };
      case (_) {
        assert(false);
      };
    };

    Debug.print("All candySharedToValueArray tests passed.");
  };
  test("testCandySharedToValueArray", testCandySharedToValueArray);

  func testCandySharedToValue() {
    // Test case 1: Valid Nat input
    let result1 = Conversion.candySharedToValue(#Nat(42));
    Debug.print(debug_show(result1));
    assert(result1 == #Nat(42));

    // Test case 2: Valid Text input
    let result2 = Conversion.candySharedToValue(#Text("hello"));
    Debug.print(debug_show(result2));
    assert(result2 == #Text("hello"));

    // Test case 3: Valid Bool input
    let result3 = Conversion.candySharedToValue(#Bool(true));
    Debug.print(debug_show(result3));
    assert(result3 == #Blob(Blob.fromArray([1])));

    // Test case 4: Valid Float input
    let result4 = Conversion.candySharedToValue(#Float(42.5));
    Debug.print(debug_show(result4));
    assert(result4 == #Text("42.5"));

    // Test case 5: Valid Principal input
    let principal = Principal.fromText("aaaaa-aa");
    let result5 = Conversion.candySharedToValue(#Principal(principal));
    Debug.print(debug_show(result5));
    assert(result5 == #Blob(Principal.toBlob(principal)));

   

    Debug.print("All CandySharedToValue tests passed.");
  };
  test("testCandySharedToValue", testCandySharedToValue);

  func testCandyToPropertyMap() {
    // Test case 1: Valid Class input
    let propertyMap = Map.new<Text, Types.Property>();
    ignore Map.put(propertyMap, Map.thash, "prop1", { name = "prop1"; value = #Nat(42); immutable = true });
    ignore Map.put(propertyMap, Map.thash, "prop2", { name = "prop2"; value = #Text("value"); immutable = false });
    let result1 = Conversion.candyToPropertyMap(#Class(propertyMap));
    Debug.print(debug_show(result1));
    switch (result1) {
      case (#ok(resMap)) {
        assert(Map.size(resMap) == 2);
        switch (Map.get(resMap, Map.thash, "prop1")) {
          case (?val) {
            assert(val.name == "prop1");
            assert(Types.eq(val.value, #Nat(42)));
            assert(val.immutable == true);
          };
          case (_) { assert(false); };
        };
        switch (Map.get(resMap, Map.thash, "prop2")) {
          case (?val) {
            assert(val.name == "prop2");
            assert(Types.eq(val.value, #Text("value")));
            assert(val.immutable == false);
          };
          case (_) { assert(false); };
        };
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 2: Empty Class input
    let emptyPropertyMap = Map.new<Text, Types.Property>();
    let result2 = Conversion.candyToPropertyMap(#Class(emptyPropertyMap));
    Debug.print(debug_show(result2));
    switch (result2) {
      case (#ok(resMap)) {
        assert(Map.size(resMap) == 0);
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 3: Invalid type input
    let result3 = Conversion.candyToPropertyMap(#Text("invalid"));
    Debug.print(debug_show(result3));
    switch (result3) {
      case (#err(errMsg)) {
        assert(errMsg == "conversion to Map<Text, Property> not supported");
      };
      case (_) {
        assert(false);
      };
    };

    Debug.print("All candyToPropertyMap tests passed.");
  };
  test("testCandyToPropertyMap", testCandyToPropertyMap);

  func testCandyToSet() {
    // Test case 1: Valid Set input
    let set = Set.new<Types.Candy>();
    ignore Set.put(set, Types.candyMapHashTool, #Nat(1));
    ignore Set.put(set, Types.candyMapHashTool, #Text("value"));
    let result1 = Conversion.candyToSet(#Set(set));
    Debug.print(debug_show(result1));
    switch (result1) {
      case (#ok(resSet)) {
        assert(Set.size(resSet) == 2);
        assert(Set.contains(resSet, Types.candyMapHashTool, #Nat(1)) == ?true);
        assert(Set.contains(resSet, Types.candyMapHashTool, #Text("value"))== ?true);
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 2: Empty Set input
    let emptySet = Set.new<Types.Candy>();
    let result2 = Conversion.candyToSet(#Set(emptySet));
    Debug.print(debug_show(result2));
    switch (result2) {
      case (#ok(resSet)) {
        assert(Set.size(resSet) == 0);
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 3: Invalid type input
    let result3 = Conversion.candyToSet(#Text("invalid"));
    Debug.print(debug_show(result3));
    switch (result3) {
      case (#err(errMsg)) {
        assert(errMsg == "conversion to Set<Candy> not supported");
      };
      case (_) {
        assert(false);
      };
    };

    Debug.print("All candyToSet tests passed.");
  };
  test("testCandyToSet", testCandyToSet);

  func testCandyToValueMap() {
    // Test case 1: Valid ValueMap input
    let valueMap = Map.new<Types.Candy, Types.Candy>();
    ignore Map.put(valueMap, Types.candyMapHashTool, #Nat(1), #Text("value1"));
    ignore Map.put(valueMap, Types.candyMapHashTool, #Nat(2), #Text("value2"));
    let result1 = Conversion.candyToValueMap(#ValueMap(valueMap));
    Debug.print(debug_show(result1));
    switch (result1) {
      case (#ok(resMap)) {
        assert(Map.size(resMap) == 2);
        switch (Map.get(resMap, Types.candyMapHashTool, #Nat(1))) {
          case (?#Text("value1")) {};
          case (_) { assert(false); };
        };
        switch (Map.get(resMap, Types.candyMapHashTool, #Nat(2))) {
          case (?#Text("value2")) {};
          case (_) { assert(false); };
        };
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 2: Empty ValueMap input
    let emptyValueMap = Map.new<Types.Candy, Types.Candy>();
    let result2 = Conversion.candyToValueMap(#ValueMap(emptyValueMap));
    Debug.print(debug_show(result2));
    switch (result2) {
      case (#ok(resMap)) {
        assert(Map.size(resMap) == 0);
      };
      case (#err(errMsg)) {
        Debug.print("Unexpected error: " # errMsg);
        assert(false);
      };
    };

    // Test case 3: Invalid type input
    let result3 = Conversion.candyToValueMap(#Text("invalid"));
    Debug.print(debug_show(result3));
    switch (result3) {
      case (#err(errMsg)) {
        assert(errMsg == "conversion to Map<Candy, Candy> not supported");
      };
      case (_) {
        assert(false);
      };
    };

    Debug.print("All candyToValueMap tests passed.");
  };
  test("testCandyToValueMap", testCandyToValueMap);

  func testCandyToValue() {
    // Test case 1: Valid Nat input
    let result1 = Conversion.candyToValue(#Nat(42));
    Debug.print(debug_show(result1));
    assert(result1 == #Nat(42));

    // Test case 2: Valid Text input
    let result2 = Conversion.candyToValue(#Text("hello"));
    Debug.print(debug_show(result2));
    assert(result2 == #Text("hello"));

    // Test case 3: Valid Bool input
    let result3 = Conversion.candyToValue(#Bool(true));
    Debug.print(debug_show(result3));
    assert(result3 == #Blob(Blob.fromArray([1])));

    // Test case 4: Valid Float input
    let result4 = Conversion.candyToValue(#Float(42.5));
    Debug.print(debug_show(result4));
    assert(result4 == #Text("42.5"));

    // Test case 5: Valid Principal input
    let principal = Principal.fromText("aaaaa-aa");
    let result5 = Conversion.candyToValue(#Principal(principal));
    Debug.print(debug_show(result5));
    assert(result5 == #Blob(Principal.toBlob(principal)));



    Debug.print("All CandyToValue tests passed.");
  };
  test("testCandyToValue", testCandyToValue);

  func testIntToBytes() {
    // Test case 1: Convert a positive Int to bytes
    let intVal1 = 42;
    let result1 = Conversion.intToBytes(intVal1);
    Debug.print(debug_show(result1));
    assert(result1 == [0, 42]);

    // Test case 2: Convert a negative Int to bytes
    let intVal2 = -42;
    let result2 = Conversion.intToBytes(intVal2);
    Debug.print(debug_show(result2));
    assert(result2 == [1, 42]);

    // Test case 3: Convert zero to bytes
    let intVal3 = 0;
    let result3 = Conversion.intToBytes(intVal3);
    Debug.print(debug_show(result3));
    assert(result3 == [0,0]);

    // Test case 4: Convert a large positive Int to bytes
    let intVal4 = 128;
    let result4 = Conversion.intToBytes(intVal4);
    Debug.print(debug_show(result4));
    assert(result4 == [0, 1, 0]);

    // Test case 5: Convert a large negative Int to bytes
    let intVal5 = -128;
    let result5 = Conversion.intToBytes(intVal5);
    Debug.print(debug_show(result5));
    assert(result5 == [1, 1, 0]);

    Debug.print("All intToBytes tests passed.");
  };
  test("testIntToBytes", testIntToBytes);

  func testNatToBytes() {
    // Test case 1: Convert a small Nat to bytes and back
    let natVal1 = 42;
    let bytes1 = Conversion.natToBytes(natVal1);
    Debug.print(debug_show(bytes1));
    let result1 = Conversion.bytesToNat(bytes1);
    Debug.print(debug_show(result1));
    assert(result1 == natVal1);

    // Test case 2: Convert zero to bytes and back
    let natVal2 = 0;
    let bytes2 = Conversion.natToBytes(natVal2);
    Debug.print(debug_show(bytes2));
    let result2 = Conversion.bytesToNat(bytes2);
    Debug.print(debug_show(result2));
    assert(result2 == natVal2);

    // Test case 3: Convert a large Nat to bytes and back
    let natVal3 = 12345678901234567890;
    let bytes3 = Conversion.natToBytes(natVal3);
    Debug.print(debug_show(bytes3));
    let result3 = Conversion.bytesToNat(bytes3);
    Debug.print(debug_show(result3));
    assert(result3 == natVal3);

    Debug.print("All natToBytes tests passed.");
  };
  test("testNatToBytes", testNatToBytes);


  func testNat16ToBytes() {
    // Test case 1: Convert a small Nat16 to bytes and back
    let nat16Val1: Nat16 = 42;
    let bytes1 = Conversion.nat16ToBytes(nat16Val1);
    Debug.print(debug_show(bytes1));
    let result1 = Conversion.bytesToNat16(bytes1);
    Debug.print(debug_show(result1));
    assert(result1 == nat16Val1);

    // Test case 2: Convert zero to bytes and back
    let nat16Val2: Nat16 = 0;
    let bytes2 = Conversion.nat16ToBytes(nat16Val2);
    Debug.print(debug_show(bytes2));
    let result2 = Conversion.bytesToNat16(bytes2);
    Debug.print(debug_show(result2));
    assert(result2 == nat16Val2);

    // Test case 3: Convert the maximum Nat16 to bytes and back
    let nat16Val3: Nat16 = 65535;
    let bytes3 = Conversion.nat16ToBytes(nat16Val3);
    Debug.print(debug_show(bytes3));
    let result3 = Conversion.bytesToNat16(bytes3);
    Debug.print(debug_show(result3));
    assert(result3 == nat16Val3);

    Debug.print("All nat16ToBytes tests passed.");
  };
  test("testNat16ToBytes", testNat16ToBytes);

  func testNat32ToBytes() {
    // Test case 1: Convert a small Nat32 to bytes and back
    let nat32Val1: Nat32 = 42;
    let bytes1 = Conversion.nat32ToBytes(nat32Val1);
    Debug.print(debug_show(bytes1));
    let result1 = Conversion.bytesToNat32(bytes1);
    Debug.print(debug_show(result1));
    assert(result1 == nat32Val1);

    // Test case 2: Convert zero to bytes and back
    let nat32Val2: Nat32 = 0;
    let bytes2 = Conversion.nat32ToBytes(nat32Val2);
    Debug.print(debug_show(bytes2));
    let result2 = Conversion.bytesToNat32(bytes2);
    Debug.print(debug_show(result2));
    assert(result2 == nat32Val2);

    // Test case 3: Convert a large Nat32 to bytes and back
    let nat32Val3: Nat32 = 4294967295;
    let bytes3 = Conversion.nat32ToBytes(nat32Val3);
    Debug.print(debug_show(bytes3));
    let result3 = Conversion.bytesToNat32(bytes3);
    Debug.print(debug_show(result3));
    assert(result3 == nat32Val3);

    Debug.print("All nat32ToBytes tests passed.");
  };
  test("testNat32ToBytes", testNat32ToBytes);

  func testNat64ToBytes() {
    // Test case 1: Convert a small Nat64 to bytes and back
    let nat64Val1: Nat64 = 42;
    let bytes1 = Conversion.nat64ToBytes(nat64Val1);
    Debug.print(debug_show(bytes1));
    let result1 = Conversion.bytesToNat64(bytes1);
    Debug.print(debug_show(result1));
    assert(result1 == nat64Val1);

    // Test case 2: Convert zero to bytes and back
    let nat64Val2: Nat64 = 0;
    let bytes2 = Conversion.nat64ToBytes(nat64Val2);
    Debug.print(debug_show(bytes2));
    let result2 = Conversion.bytesToNat64(bytes2);
    Debug.print(debug_show(result2));
    assert(result2 == nat64Val2);

    // Test case 3: Convert a large Nat64 to bytes and back
    let nat64Val3: Nat64 = 18446744073709551615;
    let bytes3 = Conversion.nat64ToBytes(nat64Val3);
    Debug.print(debug_show(bytes3));
    let result3 = Conversion.bytesToNat64(bytes3);
    Debug.print(debug_show(result3));
    assert(result3 == nat64Val3);

    Debug.print("All nat64ToBytes tests passed.");
  };
  test("testNat64ToBytes", testNat64ToBytes);

  func testPrincipalToBytes() {
    // Test case 1: Valid Principal input
    let principal = Principal.fromText("aaaaa-aa");
    Debug.print(debug_show(principal));
    let result1 = Conversion.principalToBytes(principal);
    Debug.print(debug_show(result1));
    assert(result1 == []);

    // Test case 2: Another valid Principal input
    let principal2 = Principal.fromText("jbhcg-5ycai-baeaq-cai");
    let result2 = Conversion.principalToBytes(principal2);
    Debug.print(debug_show(result2));
    assert(result2 == [2, 2, 2, 2, 2, 2, 2]);

    Debug.print("All principalToBytes tests passed.");
  };
  test("testPrincipalToBytes", testPrincipalToBytes);

  

  func testStableBufferToBuffer() {
    // Test case 1: Convert a StableBuffer<Nat> to Buffer<Nat>
    let stableNatBuffer = StableBuffer.fromArray<Nat>([1, 2, 3, 4]);
    let result1 = Conversion.stableBufferToBuffer<Nat>(stableNatBuffer);
    //Debug.print(debug_show(result1));
    assert(result1.toArray() == StableBuffer.toArray(stableNatBuffer));

    // Test case 2: Convert an empty StableBuffer<Nat> to Buffer<Nat>
    let emptyStableNatBuffer = StableBuffer.fromArray<Nat>([]);
    let result2 = Conversion.stableBufferToBuffer<Nat>(emptyStableNatBuffer);
    //Debug.print(debug_show(result2));
    assert(result2.toArray() == StableBuffer.toArray(emptyStableNatBuffer));

    // Test case 3: Convert a StableBuffer<Text> to Buffer<Text>
    let stableTextBuffer = StableBuffer.fromArray<Text>(["hello", "world"]);
    let result3 = Conversion.stableBufferToBuffer<Text>(stableTextBuffer);
    //Debug.print(debug_show(result3));
    assert(result3.toArray() == StableBuffer.toArray(stableTextBuffer));

    // Test case 4: Convert a StableBuffer<Bool> to Buffer<Bool>
    let stableBoolBuffer = StableBuffer.fromArray<Bool>([true, false, true]);
    let result4 = Conversion.stableBufferToBuffer<Bool>(stableBoolBuffer);
    //Debug.print(debug_show(result4));
    assert(result4.toArray() == StableBuffer.toArray(stableBoolBuffer));

    Debug.print("All stableBufferToBuffer tests passed.");
  };
  test("testStableBufferToBuffer", testStableBufferToBuffer);

  func testTextToByteBuffer() {
    // Test case 1: Convert a valid Text to ByteBuffer and back
    let text1 = "hello";
    let buffer1 = Conversion.textToByteBuffer(text1);
    //Debug.print(debug_show(buffer1));
    assert(text1 == Conversion.bytesToText(buffer1.toArray()));
   

    // Test case 2: Convert an empty Text to ByteBuffer and back
    let text2 = "";
    let buffer2 = Conversion.textToByteBuffer(text2);
    //Debug.print(debug_show(buffer2));

    assert(Conversion.bytesToText(buffer2.toArray()) == text2);

    // Test case 3: Convert a Text with special characters to ByteBuffer and back
    let text3 = "こんにちは世界"; // "Hello World" in Japanese
    let buffer3 = Conversion.textToByteBuffer(text3);
    //Debug.print(debug_show(buffer3));

    assert(Conversion.bytesToText(buffer3.toArray()) == text3);

    Debug.print("All textToByteBuffer tests passed.");
  };
  test("testTextToByteBuffer", testTextToByteBuffer);

  func testTextToBytes() {
    // Test case 1: Convert a valid Text to bytes and back
    let text1 = "hello";
    let bytes1 = Conversion.textToBytes(text1);
    Debug.print(debug_show(bytes1));
    let result1 = Conversion.bytesToText(bytes1);
    Debug.print(debug_show(result1));
    assert(result1 == text1);

    // Test case 2: Convert an empty Text to bytes and back
    let text2 = "";
    let bytes2 = Conversion.textToBytes(text2);
    Debug.print(debug_show(bytes2));
    let result2 = Conversion.bytesToText(bytes2);
    Debug.print(debug_show(result2));
    assert(result2 == text2);

    // Test case 3: Convert a Text with special characters to bytes and back
    let text3 = "こんにちは世界"; // "Hello World" in Japanese
    let bytes3 = Conversion.textToBytes(text3);
    Debug.print(debug_show(bytes3));
    let result3 = Conversion.bytesToText(bytes3);
    Debug.print(debug_show(result3));
    assert(result3 == text3);

    Debug.print("All textToBytes tests passed.");
  };
  test("testTextToBytes", testTextToBytes);

  func testTextToNat() {
    // Test case 1: Convert a valid Text to Nat and back
    let text1 = "12345";
    let nat1Opt = Conversion.textToNat(text1);
    assert(nat1Opt != null); // Ensure the conversion succeeded
    let nat1 = switch (nat1Opt) {
      case (?value) value;
     
    };
    Debug.print(debug_show(nat1));
    let result1 = Conversion.natToBytes(nat1);
    Debug.print(debug_show(result1));
    assert(Conversion.bytesToText(result1) == text1);

    // Test case 2: Convert a Text representing zero to Nat and back
    let text2 = "0";
    let nat2Opt = Conversion.textToNat(text2);
    Debug.print(debug_show(nat2Opt));
    assert(nat2Opt != null); // Ensure the conversion succeeded
    let nat2 = switch (nat2Opt) {
      case (?value) value;
     
    };
    let result2 = Conversion.natToBytes(nat2);
    Debug.print(debug_show(result2));
    assert(Conversion.bytesToText(result2) == text2);

    // Test case 3: Invalid Text input (non-numeric)
    let text3 = "invalid";
    let result3 = Conversion.textToNat(text3);

    Debug.print(debug_show(result3));
    assert(result3 == null); // Ensure the conversion failed

    Debug.print("All textToNat tests passed.");
  };

  func testToBuffer() {
    // Test case 1: Convert an array of Nat to Buffer<Nat>
    let natArray: [Nat] = [1, 2, 3, 4];
    let result1 = Conversion.toBuffer<Nat>(natArray);
    //Debug.print(debug_show(result1));
    assert(result1.toArray() == natArray);

    // Test case 2: Convert an empty array to Buffer<Nat>
    let emptyNatArray: [Nat] = [];
    let result2 = Conversion.toBuffer<Nat>(emptyNatArray);
    //Debug.print(debug_show(result2));
    assert(result2.toArray() == emptyNatArray);

    // Test case 3: Convert an array of Text to Buffer<Text>
    let textArray: [Text] = ["hello", "world"];
    let result3 = Conversion.toBuffer<Text>(textArray);
    //Debug.print(debug_show(result3));
    assert(result3.toArray() == textArray);

    // Test case 4: Convert an array of Bool to Buffer<Bool>
    let boolArray: [Bool] = [true, false, true];
    let result4 = Conversion.toBuffer<Bool>(boolArray);
    //Debug.print(debug_show(result4));
    assert(result4.toArray() == boolArray);

    Debug.print("All toBuffer tests passed.");
  };
  test("testToBuffer", testToBuffer);

  func testUnwrapOptionCandyShared() {
    // Test case 1: Valid Some CandyShared input
    let result1 = Conversion.unwrapOptionCandyShared(#Option(?#Nat(42)));
    Debug.print(debug_show(result1));
    assert(result1 == #ok(#Nat(42)));

    // Test case 2: None input
    let result2 = Conversion.unwrapOptionCandyShared(#Option(null));
    Debug.print(debug_show(result2));
    assert(result2 == #err("option is null"));

    // Test case 3: Invalid type input
    let result3 = Conversion.unwrapOptionCandyShared(#Text("invalid"));
    Debug.print(debug_show(result3));
    assert(switch (result3) {
      case (#ok(value)) value == #Text("invalid");
      case _ false;
    });

    Debug.print("All unwrapOptionCandyShared tests passed.");
  };
  test("testUnwrapOptionCandyShared", testUnwrapOptionCandyShared);

  func testUnwrapOptionCandy() {
    // Test case 1: Valid Some Candy input
    let result1 = Conversion.unwrapOptionCandy(#Option(?#Nat(42)));
    Debug.print(debug_show(result1));
    let unwrappedResult1 = switch (result1) {
      case (#ok(value)) value;
      case (#err(_)) {assert(false); #Nat(56);} // This should not happen
    };

    assert(Types.eq(unwrappedResult1, #Nat(42)));

    // Test case 2: None input
    let result2 = Conversion.unwrapOptionCandy(#Option(null));
    Debug.print(debug_show(result2));
    assert(switch (result2) {
      case (#err(msg)) msg == "option is null";
      case _ false;
    });

    // Test case 3: Invalid type input
    let result3 = Conversion.unwrapOptionCandy(#Text("invalid"));
    Debug.print(debug_show(result3));
    switch (result3) {
      case (#ok(value)) {
        switch (value) {
          case (#Text(text)) { assert(text == "invalid"); };
          case (_) { assert(false); }; // Fail if the value is not #Text
        };
      };
      case (_) {
        assert(false); // Fail if the result is not #ok
      };
    };

    Debug.print("All unwrapOptionCandy tests passed.");
  };

  test("testUnwrapOptionCandy", testUnwrapOptionCandy);

  