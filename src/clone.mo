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

/// Cloning support for the candy values.
///
/// This module contains a few utilities for deep cloning candy values.

import Types "types";
import Array "mo:base/Array";
import StableBuffer "mo:stablebuffer_1_3_0/StableBuffer";
import Map "mo:map9/Map";
import Set "mo:map9/Set";

module {

  type CandyShared = Types.CandyShared;
  type Candy = Types.Candy;
  type Property = Types.Property;

  /// Deep clone a `Candy`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let val: Candy = #Option(?#Principal(Principal.fromText("xyz")));
  /// let cloned_val = Clone.cloneCandy(val);
  /// ```
  public func cloneCandy(val : Candy) : Candy {
    switch(val){
      case(#Class(val)){
        return #Class(
          Map.fromIter<Text, Property>(
            Map.entries(val)
          , Map.thash)
        );
      };
      case(#Bytes(val)){#Bytes(StableBuffer.clone(val))};
      case(#Nats(val)){#Nats(StableBuffer.clone(val))};
      case(#Ints(val)){#Ints(StableBuffer.clone(val))};
      case(#Floats(val)){#Floats(StableBuffer.clone(val))};
      case(#Array(val)){#Array(StableBuffer.clone(val))};
      case(#ValueMap(val)){#ValueMap(Map.fromIter<Candy,Candy>(Map.entries(val), Types.candyMapHashTool))};
      case(#Set(val)){#Set(Set.fromIter<Candy>(Set.keys(val), Types.candyMapHashTool))};
      case(_) val;
    };
  };
}