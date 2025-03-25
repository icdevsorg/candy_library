import Debug "mo:base/Debug";
import Conversion "../src/icrc16/conversion";
import {test} "mo:test";


  func testBytesToBool() {
    // Test case 1: Convert bytes [1] to true
    let result1 = Conversion.bytesToBool([1]);
    Debug.print(debug_show(result1));
    assert(result1 == true);

    // Test case 2: Convert bytes [0] to false
    let result2 = Conversion.bytesToBool([0]);
    Debug.print(debug_show(result2));
    assert(result2 == false);

    // Test case 3: Invalid bytes input (empty array)
    let result3 = Conversion.bytesToBool([]);
      
    //Debug.print(debug_show(result3));
    assert(result3 == false); // Assuming empty input returns false

    // Test case 4: Invalid bytes input (array with multiple elements)
    let result4 = Conversion.bytesToBool([1, 0]);
     
    //Debug.print(debug_show(result4));
    assert(result4);

    Debug.print("All bytesToBool tests passed.");
  };

  test("testBytesToBool", testBytesToBool);



