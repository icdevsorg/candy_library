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


import Types "types";
import Array "mo:base/Array";
import StableBuffer "mo:stable_buffer/StableBuffer";
import Map "mo:Map/Map";
import Set "mo:Map/Set";

module {

  type CandyValue = Types.CandyValue;
  type CandyValueUnstable = Types.CandyValueUnstable;
  type PropertyUnstable = Types.PropertyUnstable;

  public func cloneValueUnstable(val : CandyValueUnstable) : CandyValueUnstable{
    switch(val){
      case(#Class(val)){

        return #Class(Array.tabulate<PropertyUnstable>(val.size(), func(idx){
            {name= val[idx].name; value=cloneValueUnstable(val[idx].value); immutable = val[idx].immutable};
        }));
      };
      case(#Bytes(val)){#Bytes(StableBuffer.clone(val))};
      case(#Nats(val)){#Nats(StableBuffer.clone(val))};
      case(#Floats(val)){#Floats(StableBuffer.clone(val))};
      case(#Array(val)){#Array(StableBuffer.clone(val))};
      case(#Map(val)){#Map(Map.fromIter<CandyValueUnstable,CandyValueUnstable>(Map.entries(val), Types.candyValueUnstableMapHashTool))};
      case(#Set(val)){#Set(Set.fromIter<CandyValueUnstable>(Set.keys(val), Types.candyValueUnstableMapHashTool))};
      case(_) val;
    };
  };
}