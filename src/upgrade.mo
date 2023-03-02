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

import CandyOld "mo:candy_0_1_12/types";
import CandyTypes "types";
import Array "mo:base/Array";

module {

  

  public func upgradeValue(item : CandyOld.CandyValue) : CandyTypes.CandyValue{
    switch(item){
      case(#Int(val)){ #Int(val)};
      case(#Int8(val)){ #Int8(val)};
      case(#Int16(val)){ #Int16(val)};
      case(#Int32(val)){ #Int32(val)};
      case(#Int64(val)){ #Int64(val)};
      case(#Nat(val)){ #Nat(val)};
      case(#Nat8(val)){ #Nat8(val)};
      case(#Nat16(val)){ #Nat16(val)};
      case(#Nat32(val)){ #Nat32(val)};
      case(#Nat64(val)){ #Nat64(val)};
      case(#Float(val)){ #Float(val)};
      case(#Text(val)){ #Text(val)};
      case(#Bool(val)){ #Bool(val)};
      case(#Blob(val)){ #Blob(val)};
      case(#Class(val)){ #Class(
        Array.map<CandyOld.Property, CandyTypes.Property>(val, func(x){
          { x with
            value = upgradeValue(x.value)
          }
        }))};
      case(#Principal(val)){ #Principal(val)};
       case(#Array(val)){
        switch(val){
          case(#frozen(val)){#Array(Array.map<CandyOld.CandyValue, CandyTypes.CandyValue>(val, upgradeValue))};
          case(#thawed(val)){#Array(Array.map<CandyOld.CandyValue, CandyTypes.CandyValue>(val, upgradeValue))};
        };
      };
      case(#Option(val)){
        switch(val){
          case(null){ #Option(null)};
          case(?val){#Option(?upgradeValue(val))};
        };
      };
      case(#Bytes(val)){
        switch(val){
          case(#frozen(val)){ #Bytes(val)};
          case(#thawed(val)){ #Bytes(val)};
        };
      };
      case(#Floats(val)){
        switch(val){
          case(#frozen(val)){ #Floats(val)};
          case(#thawed(val)){ #Floats(val)};
        };
      };
      case(#Nats(val)){
        switch(val){
          case(#frozen(val)){ #Nats(val)};
          case(#thawed(val)){ #Nats(val)};
        };
      };
      case(#Empty){ #Option(null)};
    }
  };

  public func upgradeValueUnstable(item : CandyOld.CandyValueUnstable) : CandyTypes.CandyValueUnstable{
    switch(item){
      case(#Int(val)){ #Int(val)};
      case(#Int8(val)){ #Int8(val)};
      case(#Int16(val)){ #Int16(val)};
      case(#Int32(val)){ #Int32(val)};
      case(#Int64(val)){ #Int64(val)};
      case(#Nat(val)){ #Nat(val)};
      case(#Nat8(val)){ #Nat8(val)};
      case(#Nat16(val)){ #Nat16(val)};
      case(#Nat32(val)){ #Nat32(val)};
      case(#Nat64(val)){ #Nat64(val)};
      case(#Float(val)){ #Float(val)};
      case(#Text(val)){ #Text(val)};
      case(#Bool(val)){ #Bool(val)};
      case(#Blob(val)){ #Blob(val)};
      case(#Class(val)){ #Class(
        Array.map<CandyOld.PropertyUnstable, CandyTypes.PropertyUnstable>(val, func(x){
          { x with
            value = upgradeValueUnstable(x.value)
          }
        })
      )};
      case(#Principal(val)){ #Principal(val)};
      case(#Array(val)){
        switch(val){
          case(#frozen(val)){#Array(CandyTypes.toBuffer(Array.map<CandyOld.CandyValueUnstable, CandyTypes.CandyValueUnstable>(val, upgradeValueUnstable)))};
          case(#thawed(val)){#Array(CandyTypes.toBuffer(Array.map<CandyOld.CandyValueUnstable, CandyTypes.CandyValueUnstable>(val.toArray(), upgradeValueUnstable)))};
        };
      };
      case(#Option(val)){
        switch(val){
          case(null){ #Option(null)};
          case(?val){#Option(?upgradeValueUnstable(val))};
        };
      };
      case(#Bytes(val)){
        switch(val){
          case(#frozen(val)){ #Bytes(CandyTypes.toBuffer(val))};
          case(#thawed(val)){ #Bytes(CandyTypes.toBuffer(val.toArray()))};
        };
      };
      case(#Floats(val)){
        switch(val){
          case(#frozen(val)){ #Floats(CandyTypes.toBuffer(val))};
          case(#thawed(val)){ #Floats(CandyTypes.toBuffer(val.toArray()))};
        };
      };
      case(#Nats(val)){
        switch(val){
          case(#frozen(val)){ #Nats(CandyTypes.toBuffer(val))};
          case(#thawed(val)){ #Nats(CandyTypes.toBuffer(val.toArray()))};
        };
      };
      case(#Empty){ #Option(null)};
    }
  };

}