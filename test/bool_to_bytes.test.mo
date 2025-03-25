import Debug "mo:base/Debug";
import Conversion "../src/icrc16/conversion";
import {test} "mo:test";


func testBoolToBytes() {
  // Test case 1: Convert true to bytes
  let result1 = Conversion.boolToBytes(true);
  Debug.print(debug_show(result1));
  assert(result1 == [1]);

  // Test case 2: Convert false to bytes
  let result2 = Conversion.boolToBytes(false);
  Debug.print(debug_show(result2));
  assert(result2 == [0]);

  Debug.print("All boolToBytes tests passed.");
};

test("boolToBytes", testBoolToBytes);

