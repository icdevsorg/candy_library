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

import Buffer "mo:base/Buffer";
import Blob "mo:base/Blob";
import Char "mo:base/Char";
import Iter "mo:base/Iter";
import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Nat16 "mo:base/Nat16";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Nat8 "mo:base/Nat8";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Int8 "mo:base/Int8";
import Int16 "mo:base/Int16";
import Int32 "mo:base/Int32";
import Int64 "mo:base/Int64";
import Bool "mo:base/Bool";
import Principal "mo:base/Principal";
import Prelude "mo:base/Prelude";
import List "mo:base/List";
import Types "types";
import Hex "hex";
import Properties "properties";


module {

        type CandyValue = Types.CandyValue;
        type CandyValueUnstable = Types.CandyValueUnstable;
        type DataZone = Types.DataZone;
        type Property = Types.Property;
        type PropertyUnstable = Types.PropertyUnstable;


        //todo: generic accesors

        public func valueToNat(val : CandyValue) : Nat {
            switch(val){
                case(#Nat(val)){ val};
                case(#Nat8(val)){ Nat8.toNat(val)};
                case(#Nat16(val)){ Nat16.toNat(val)};
                case(#Nat32(val)){ Nat32.toNat(val)};
                case(#Nat64(val)){ Nat64.toNat(val)};
                case(#Float(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat(#Int(Float.toInt(Float.nearest(val))))};
                case(#Int(val)){
                    if(val < 0){assert false;};//will throw on negative
                    
                    Int.abs(val)};
                case(#Int8(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
                case(#Int16(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
                case(#Int32(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
                case(#Int64(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueToNat8(val : CandyValue) : Nat8 {
            switch(val){
                case(#Nat8(val)){ val};
                case(#Nat(val)){ Nat8.fromNat(val)};//will throw on overflow
                case(#Nat16(val)){ Nat8.fromNat(Nat16.toNat(val))};//will throw on overflow
                case(#Nat32(val)){ Nat8.fromNat(Nat32.toNat(val))};//will throw on overflow
                case(#Nat64(val)){ Nat8.fromNat(Nat64.toNat(val))};//will throw on overflow
                case(#Float(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat8(#Int(Float.toInt(Float.nearest(val))))};
                case(#Int(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat8(#Nat(Int.abs(val)))};
                case(#Int8(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat8(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
                case(#Int16(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat8(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
                case(#Int32(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat8(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
                case(#Int64(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat8(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueToNat16(val : CandyValue) : Nat16 {
            switch(val){
                case(#Nat16(val)){ val};
                case(#Nat8(val)){Nat16.fromNat(Nat8.toNat(val))};
                case(#Nat(val)){Nat16.fromNat(val)};//will throw on overflow
                case(#Nat32(val)){Nat16.fromNat(Nat32.toNat(val))};//will throw on overflow
                case(#Nat64(val)){Nat16.fromNat(Nat64.toNat(val))};//will throw on overflow
                case(#Float(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat16(#Int(Float.toInt(Float.nearest(val))))};
                case(#Int(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat16(#Nat(Int.abs(val)))};
                case(#Int8(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat16(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
                case(#Int16(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat16(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
                case(#Int32(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat16(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
                case(#Int64(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat16(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueToNat32(val : CandyValue) : Nat32 {
            switch(val){
                case(#Nat32(val)){ val};
                case(#Nat16(val)){ Nat32.fromNat(Nat16.toNat(val))};
                case(#Nat8(val)){ Nat32.fromNat(Nat8.toNat(val))};
                case(#Nat(val)){ Nat32.fromNat(val)};//will throw on overflow
                case(#Float(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat32(#Int(Float.toInt(Float.nearest(val))))};
                case(#Int(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat32(#Nat(Int.abs(val)))};
                case(#Int8(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat32(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
                case(#Int16(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat32(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
                case(#Int32(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat32(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
                case(#Int64(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat32(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueToNat64(val : CandyValue) : Nat64 {
            switch(val){
                case(#Nat64(val)){ val};
                case(#Nat32(val)){ Nat64.fromNat(Nat32.toNat(val))};
                case(#Nat16(val)){ Nat64.fromNat(Nat16.toNat(val))};
                case(#Nat8(val)){ Nat64.fromNat(Nat8.toNat(val))};
                case(#Nat(val)){ Nat64.fromNat(val)};
                case(#Float(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat64(#Int(Float.toInt(Float.nearest(val))))};
                case(#Int(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat64(#Nat(Int.abs(val)))};
                case(#Int8(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat64(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
                case(#Int16(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat64(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
                case(#Int32(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat64(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
                case(#Int64(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueToNat64(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueToInt(val : CandyValue) : Int {
            switch(val){
                case(#Int(val)){ val};
                case(#Int8(val)){ Int8.toInt(val)};
                case(#Int16(val)){ Int16.toInt(val)};
                case(#Int32(val)){ Int32.toInt(val)};
                case(#Int64(val)){ Int64.toInt(val)};
                case(#Nat(val)){ val};
                case(#Nat8(val)){ Nat8.toNat(val)};
                case(#Nat16(val)){ Nat16.toNat(val)};
                case(#Nat32(val)){ Nat32.toNat(val)};
                case(#Nat64(val)){Nat64.toNat(val)};
                case(#Float(val)){ Float.toInt(Float.nearest(val))};//will throw on overflow
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueToInt8(val : CandyValue) : Int8 {
            switch(val){
                case(#Int8(val)){val};
                case(#Int(val)){ Int8.fromInt(val)};//will throw on overflow
                case(#Int16(val)){ Int8.fromInt(Int16.toInt(val))};//will throw on overflow
                case(#Int32(val)){ Int8.fromInt(Int32.toInt(val))};//will throw on overflow
                case(#Int64(val)){ Int8.fromInt(Int64.toInt(val))};//will throw on overflow
                case(#Nat8(val)){ Int8.fromNat8(val)};
                case(#Nat(val)){Int8.fromNat8(valueToNat8(#Nat(val)))};//will throw on overflow
                case(#Nat16(val)){Int8.fromNat8(valueToNat8(#Nat16(val)))};//will throw on overflow
                case(#Nat32(val)){Int8.fromNat8(valueToNat8(#Nat32(val)))};//will throw on overflow
                case(#Nat64(val)){Int8.fromNat8(valueToNat8(#Nat64(val)))};//will throw on overflow
                case(#Float(val)){ Int8.fromInt(Float.toInt(Float.nearest(val)))};//will throw on overflow
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueToInt16(val : CandyValue) : Int16 {
            switch(val){
                case(#Int16(val)){ val};
                case(#Int8(val)){ Int16.fromInt(Int8.toInt(val))};
                case(#Int(val)){ Int16.fromInt(val)};//will throw on overflow
                case(#Int32(val)){ Int16.fromInt(Int32.toInt(val))};//will throw on overflow
                case(#Int64(val)){ Int16.fromInt(Int64.toInt(val))};//will throw on overflow
                case(#Nat8(val)){Int16.fromNat16(valueToNat16(#Nat8(val)))};
                case(#Nat(val)){Int16.fromNat16(valueToNat16(#Nat(val)))};//will throw on overflow
                case(#Nat16(val)){ Int16.fromNat16(val)};
                case(#Nat32(val)){Int16.fromNat16(valueToNat16(#Nat32(val)))};//will throw on overflow
                case(#Nat64(val)){Int16.fromNat16(valueToNat16(#Nat64(val)))};//will throw on overflow
                case(#Float(val)){ Int16.fromInt(Float.toInt(Float.nearest(val)))};//will throw on overflow
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueToInt32(val : CandyValue) : Int32 {
            switch(val){
                case(#Int32(val)){val};
                case(#Int16(val)){Int32.fromInt(Int16.toInt(val))};
                case(#Int8(val)){Int32.fromInt(Int8.toInt(val))};
                case(#Int(val)){Int32.fromInt(val)};//will throw on overflow
                case(#Nat8(val)){Int32.fromNat32(valueToNat32(#Nat8(val)))};
                case(#Nat(val)){Int32.fromNat32(valueToNat32(#Nat(val)))};//will throw on overflow
                case(#Nat16(val)){Int32.fromNat32(valueToNat32(#Nat16(val)))};
                case(#Nat32(val)){Int32.fromNat32(val)};
                case(#Nat64(val)){Int32.fromNat32(valueToNat32(#Nat64(val)))};//will throw on overflow
                case(#Float(val)){Int32.fromInt(Float.toInt(Float.nearest(val)))};//will throw on overflow
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueToInt64(val : CandyValue) : Int64 {
            switch(val){
                case(#Int64(val)){ val};
                case(#Int32(val)){ Int64.fromInt(Int32.toInt(val))};
                case(#Int16(val)){ Int64.fromInt(Int16.toInt(val))};
                case(#Int8(val)){ Int64.fromInt(Int8.toInt(val))};
                case(#Int(val)){ Int64.fromInt(val)};//will throw on overflow
                case(#Nat8(val)){Int64.fromNat64(valueToNat64(#Nat8(val)))};
                case(#Nat(val)){Int64.fromNat64(valueToNat64(#Nat(val)))};//will throw on overflow
                case(#Nat16(val)){Int64.fromNat64(valueToNat64(#Nat16(val)))};
                case(#Nat32(val)){Int64.fromNat64(valueToNat64(#Nat32(val)))};//will throw on overflow
                case(#Nat64(val)){ Int64.fromNat64(val)};
                case(#Float(val)){ Float.toInt64(Float.nearest(val))};
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueToFloat(val : CandyValue) : Float {
            switch(val){
                case(#Float(val)){ val};
                case(#Int64(val)){ Float.fromInt64(val)};
                case(#Int32(val)){valueToFloat(#Int(Int32.toInt(val)))};
                case(#Int16(val)){valueToFloat(#Int(Int16.toInt(val)))};
                case(#Int8(val)){valueToFloat(#Int(Int8.toInt(val)))};
                case(#Int(val)){ Float.fromInt(val)};
                case(#Nat8(val)){valueToFloat(#Int(Nat8.toNat(val)))};
                case(#Nat(val)){valueToFloat(#Int(val))};//will throw on overflow
                case(#Nat16(val)){valueToFloat(#Int(Nat16.toNat(val)))};
                case(#Nat32(val)){valueToFloat(#Int(Nat32.toNat(val)))};//will throw on overflow
                case(#Nat64(val)){valueToFloat(#Int(Nat64.toNat(val)))};
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueToText(val : CandyValue) : Text {
            switch(val){
                case(#Text(val)){ val};
                case(#Nat64(val)){ Nat64.toText(val)};
                case(#Nat32(val)){ Nat32.toText(val)};
                case(#Nat16(val)){ Nat16.toText(val)};
                case(#Nat8(val)){ Nat8.toText(val)};
                case(#Nat(val)){ Nat.toText(val)};
                case(#Int64(val)){ Int64.toText(val)};
                case(#Int32(val)){ Int32.toText(val)};
                case(#Int16(val)){ Int16.toText(val)};
                case(#Int8(val)){ Int8.toText(val)};
                case(#Int(val)){ Int.toText(val)};
                case(#Bool(val)){ Bool.toText(val)};
                case(#Float(val)){ Float.format(#exact, val)};
                case(#Option(val)){
                    switch(val){
                        case(null){ "null"};
                        case(?val){valueToText(val)};
                    };
                };
                //blob
                case(#Blob(val)){
                    valueToText(#Bytes(#frozen(Blob.toArray(val))));
                };
                //class
                case(#Class(val)){ //this is currently not parseable and should probably just be used for debuging. It would be nice to output candid.

                    var t = "{";
                    for(thisItem in val.vals()){
                        t := t # thisItem.name # ":" # (if(thisItem.immutable == false){"var "}else{""}) # valueToText(thisItem.value) # "; ";
                    };
                    
                    return Text.trimEnd(t, #text(" ")) # "}";


                };
                //principal
                case(#Principal(val)){ Principal.toText(val)};
                //array
                case(#Array(val)){
                    switch(val){
                        case(#frozen(val)){
                            var t = "[";
                            for(thisItem in val.vals()){
                                t := t # "{" # valueToText(thisItem) # "} ";
                            };
                            
                            return Text.trimEnd(t, #text(" ")) # "]";
                        };
                        case(#thawed(val)){
                            var t = "[";
                            for(thisItem in val.vals()){
                                t := t # "{" #valueToText(thisItem) # "} ";
                            };
                            
                            return Text.trimEnd(t, #text(" ")) # "]";
                        };
                    };
                };
                //floats
                case(#Floats(val)){
                    switch(val){
                        case(#frozen(val)){
                            var t = "[";
                            for(thisItem in val.vals()){
                                t := t # Float.format(#exact, thisItem) # " ";
                            };
                            
                            return Text.trimEnd(t, #text(" ")) # "]";
                        };
                        case(#thawed(val)){
                            var t = "[";
                            for(thisItem in val.vals()){
                                t := t # Float.format(#exact, thisItem) # " ";
                            };
                            
                            return Text.trimEnd(t, #text(" ")) # "]";
                        };
                    };
                };
                //bytes
                case(#Bytes(val)){
                    switch(val){
                        case(#frozen(val)){
                            
                            return Hex.encode(val);
                        };
                        case(#thawed(val)){
                            
                            return Hex.encode(val);
                        };
                    };
                };
                case(_){assert(false);/*unreachable*/"";};
            };
        };

        public func valueToPrincipal(val : CandyValue) : Principal {
            
            switch(val){
                case(#Principal(val)){val};
                case(_){assert(false);/*unreachable*/Principal.fromText("");};
            };
        };

        public func valueToBool(val : CandyValue) : Bool {
            
            switch(val){
                case(#Bool(val)){val};
                case(_){assert(false);/*unreachable*/false;};
            };
        };

        public func valueToBlob(val : CandyValue) : Blob {

            switch(val){
                case(#Blob(val)){val};
                case(#Bytes(val)){Blob.fromArray(

                    switch(val){
                        case(#frozen(val)){ val;};
                        case(#thawed(val)){ val};

                    }
                )};
                case(#Text(val)){
                    Blob.fromArray(textToBytes(val))
                };
                case(#Int(val)){
                    Blob.fromArray(intToBytes(val))
                };
                case(#Nat(val)){
                    Blob.fromArray(natToBytes(val))
                };
                case(#Nat8(val)){
                    
                    Blob.fromArray([val])
                };
                case(#Nat16(val)){
                    Blob.fromArray(nat16ToBytes(val))
                };
                case(#Nat32(val)){
                    Blob.fromArray(nat32ToBytes(val))
                };
                case(#Nat64(val)){
                    Blob.fromArray(nat64ToBytes(val))
                };
                case(#Principal(val)){
                    
                    Principal.toBlob(val);
                };
                //todo: could add all conversions here
                case(_){assert(false);/*unreachable*/"\00";};
            };
        };

        //gets the array of candy values out of an array
        public func valueToValueArray(val : CandyValue) : [CandyValue] {

            switch(val){
                case(#Array(val)){
                    switch(val){
                        case(#frozen(val)){val};
                        case(#thawed(val)){val};
                    };
                };
                //todo: could add all conversions here
                case(_){assert(false);/*unreachable*/[];};
            };
        };

        //unstable getters
        public func valueUnstableToNat(val : CandyValueUnstable) : Nat {

            switch(val){
                case(#Nat(val)){ val};
                case(#Nat8(val)){ Nat8.toNat(val)};
                case(#Nat16(val)){ Nat16.toNat(val)};
                case(#Nat32(val)){Nat32.toNat(val)};
                case(#Nat64(val)){ Nat64.toNat(val)};
                case(#Float(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat(#Int(Float.toInt(Float.nearest(val))))};
                case(#Int(val)){
                    if(val < 0){assert false;};//will throw on negative
                    
                    Int.abs(val)};
                case(#Int8(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
                case(#Int16(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
                case(#Int32(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
                case(#Int64(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueUnstableToNat8(val : CandyValueUnstable) : Nat8 {

            switch(val){
                case(#Nat8(val)){ val};
                case(#Nat(val)){ Nat8.fromNat(val)};//will throw on overflow
                case(#Nat16(val)){ Nat8.fromNat(Nat16.toNat(val))};//will throw on overflow
                case(#Nat32(val)){ Nat8.fromNat(Nat32.toNat(val))};//will throw on overflow
                case(#Nat64(val)){ Nat8.fromNat(Nat64.toNat(val))};//will throw on overflow
                case(#Float(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat8(#Int(Float.toInt(Float.nearest(val))))};
                case(#Int(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat8(#Nat(Int.abs(val)))};
                case(#Int8(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat8(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
                case(#Int16(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat8(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
                case(#Int32(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat8(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
                case(#Int64(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat8(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueUnstableToNat16(val : CandyValueUnstable) : Nat16 {

            switch(val){
                case(#Nat16(val)){ val};
                case(#Nat8(val)){ Nat16.fromNat(Nat8.toNat(val))};
                case(#Nat(val)){ Nat16.fromNat(val)};//will throw on overflow
                case(#Nat32(val)){ Nat16.fromNat(Nat32.toNat(val))};//will throw on overflow
                case(#Nat64(val)){ Nat16.fromNat(Nat64.toNat(val))};//will throw on overflow
                case(#Float(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat16(#Int(Float.toInt(Float.nearest(val))))};
                case(#Int(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat16(#Nat(Int.abs(val)))};
                case(#Int8(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat16(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
                case(#Int16(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat16(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
                case(#Int32(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat16(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
                case(#Int64(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat16(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueUnstableToNat32(val : CandyValueUnstable) : Nat32 {

            switch(val){
                case(#Nat32(val)){val};
                case(#Nat16(val)){Nat32.fromNat(Nat16.toNat(val))};
                case(#Nat8(val)){ Nat32.fromNat(Nat8.toNat(val))};
                case(#Nat(val)){ Nat32.fromNat(val)};//will throw on overflow
                case(#Float(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat32(#Int(Float.toInt(Float.nearest(val))))};
                case(#Int(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat32(#Nat(Int.abs(val)))};
                case(#Int8(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat32(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
                case(#Int16(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat32(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
                case(#Int32(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat32(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
                case(#Int64(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat32(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueUnstableToNat64(val : CandyValueUnstable) : Nat64 {

            switch(val){
                case(#Nat64(val)){ val};
                case(#Nat32(val)){ Nat64.fromNat(Nat32.toNat(val))};
                case(#Nat16(val)){ Nat64.fromNat(Nat16.toNat(val))};
                case(#Nat8(val)){ Nat64.fromNat(Nat8.toNat(val))};
                case(#Nat(val)){ Nat64.fromNat(val)};
                case(#Float(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat64(#Int(Float.toInt(Float.nearest(val))))};
                case(#Int(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat64(#Nat(Int.abs(val)))};
                case(#Int8(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat64(#Int(Int8.toInt(Int8.abs(val))))};//will throw on overflow
                case(#Int16(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat64(#Int(Int16.toInt(Int16.abs(val))))};//will throw on overflow
                case(#Int32(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat64(#Int(Int32.toInt(Int32.abs(val))))};//will throw on overflow
                case(#Int64(val)){
                    if(val < 0){assert false;};//will throw on negative
                    valueUnstableToNat64(#Int(Int64.toInt(Int64.abs(val))))};//will throw on overflow
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueUnstableToInt(val : CandyValueUnstable) : Int {

            switch(val){
                case(#Int(val)){val};
                case(#Int8(val)){ Int8.toInt(val)};
                case(#Int16(val)){ Int16.toInt(val)};
                case(#Int32(val)){ Int32.toInt(val)};
                case(#Int64(val)){ Int64.toInt(val)};
                case(#Nat(val)){ val};
                case(#Nat8(val)){Nat8.toNat(val)};
                case(#Nat16(val)){Nat16.toNat(val)};
                case(#Nat32(val)){Nat32.toNat(val)};
                case(#Nat64(val)){Nat64.toNat(val)};
                case(#Float(val)){Float.toInt(Float.nearest(val))};//will throw on overflow
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueUnstableToInt8(val : CandyValueUnstable) : Int8 {

            switch(val){
                case(#Int8(val)){ val};
                case(#Int(val)){ Int8.fromInt(val)};//will throw on overflow
                case(#Int16(val)){ Int8.fromInt(Int16.toInt(val))};//will throw on overflow
                case(#Int32(val)){ Int8.fromInt(Int32.toInt(val))};//will throw on overflow
                case(#Int64(val)){ Int8.fromInt(Int64.toInt(val))};//will throw on overflow
                case(#Nat8(val)){ Int8.fromNat8(val)};
                case(#Nat(val)){Int8.fromNat8(valueUnstableToNat8(#Nat(val)))};//will throw on overflow
                case(#Nat16(val)){Int8.fromNat8(valueUnstableToNat8(#Nat16(val)))};//will throw on overflow
                case(#Nat32(val)){Int8.fromNat8(valueUnstableToNat8(#Nat32(val)))};//will throw on overflow
                case(#Nat64(val)){Int8.fromNat8(valueUnstableToNat8(#Nat64(val)))};//will throw on overflow
                case(#Float(val)){ Int8.fromInt(Float.toInt(Float.nearest(val)))};//will throw on overflow
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueUnstableToInt16(val : CandyValueUnstable) : Int16 {

            switch(val){
                case(#Int16(val)){ val};
                case(#Int8(val)){ Int16.fromInt(Int8.toInt(val))};
                case(#Int(val)){ Int16.fromInt(val)};//will throw on overflow
                case(#Int32(val)){ Int16.fromInt(Int32.toInt(val))};//will throw on overflow
                case(#Int64(val)){ Int16.fromInt(Int64.toInt(val))};//will throw on overflow
                case(#Nat8(val)){Int16.fromNat16(valueUnstableToNat16(#Nat8(val)))};
                case(#Nat(val)){Int16.fromNat16(valueUnstableToNat16(#Nat(val)))};//will throw on overflow
                case(#Nat16(val)){ Int16.fromNat16(val)};
                case(#Nat32(val)){Int16.fromNat16(valueUnstableToNat16(#Nat32(val)))};//will throw on overflow
                case(#Nat64(val)){Int16.fromNat16(valueUnstableToNat16(#Nat64(val)))};//will throw on overflow
                case(#Float(val)){ Int16.fromInt(Float.toInt(Float.nearest(val)))};//will throw on overflow
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueUnstableToInt32(val : CandyValueUnstable) : Int32 {
            switch(val){
                case(#Int32(val)){ val};
                case(#Int16(val)){ Int32.fromInt(Int16.toInt(val))};
                case(#Int8(val)){ Int32.fromInt(Int8.toInt(val))};
                case(#Int(val)){ Int32.fromInt(val)};//will throw on overflow
                case(#Nat8(val)){Int32.fromNat32(valueUnstableToNat32(#Nat8(val)))};
                case(#Nat(val)){Int32.fromNat32(valueUnstableToNat32(#Nat(val)))};//will throw on overflow
                case(#Nat16(val)){Int32.fromNat32(valueUnstableToNat32(#Nat16(val)))};
                case(#Nat32(val)){ Int32.fromNat32(val)};
                case(#Nat64(val)){Int32.fromNat32(valueUnstableToNat32(#Nat64(val)))};//will throw on overflow
                case(#Float(val)){ Int32.fromInt(Float.toInt(Float.nearest(val)))};//will throw on overflow
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueUnstableToInt64(val : CandyValueUnstable) : Int64 {
            switch(val){
                case(#Int64(val)){ val};
                case(#Int32(val)){ Int64.fromInt(Int32.toInt(val))};
                case(#Int16(val)){ Int64.fromInt(Int16.toInt(val))};
                case(#Int8(val)){ Int64.fromInt(Int8.toInt(val))};
                case(#Int(val)){ Int64.fromInt(val)};//will throw on overflow
                case(#Nat8(val)){Int64.fromNat64(valueUnstableToNat64(#Nat8(val)))};
                case(#Nat(val)){Int64.fromNat64(valueUnstableToNat64(#Nat(val)))};//will throw on overflow
                case(#Nat16(val)){Int64.fromNat64(valueUnstableToNat64(#Nat16(val)))};
                case(#Nat32(val)){Int64.fromNat64(valueUnstableToNat64(#Nat32(val)))};//will throw on overflow
                case(#Nat64(val)){ Int64.fromNat64(val)};
                case(#Float(val)){ Float.toInt64(Float.nearest(val))};
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueUnstableToFloat(val : CandyValueUnstable) : Float {
            switch(val){
                case(#Float(val)){ val};
                case(#Int64(val)){ Float.fromInt64(val)};
                case(#Int32(val)){valueUnstableToFloat(#Int(Int32.toInt(val)))};
                case(#Int16(val)){valueUnstableToFloat(#Int(Int16.toInt(val)))};
                case(#Int8(val)){valueUnstableToFloat(#Int(Int8.toInt(val)))};
                case(#Int(val)){ Float.fromInt(val)};
                case(#Nat8(val)){valueUnstableToFloat(#Int(Nat8.toNat(val)))};
                case(#Nat(val)){valueUnstableToFloat(#Int(val))};//will throw on overflow
                case(#Nat16(val)){valueUnstableToFloat(#Int(Nat16.toNat(val)))};
                case(#Nat32(val)){valueUnstableToFloat(#Int(Nat32.toNat(val)))};//will throw on overflow
                case(#Nat64(val)){valueUnstableToFloat(#Int(Nat64.toNat(val)))};
                case(_){assert(false);/*unreachable*/0;};
            };
        };

        public func valueUnstableToText(val : CandyValueUnstable) : Text {
            switch(val){
                case(#Text(val)){ val};
                case(#Nat64(val)){ Nat64.toText(val)};
                case(#Nat32(val)){ Nat32.toText(val)};
                case(#Nat16(val)){ Nat16.toText(val)};
                case(#Nat8(val)){ Nat8.toText(val)};
                case(#Nat(val)){ Nat.toText(val)};
                case(#Int64(val)){ Int64.toText(val)};
                case(#Int32(val)){ Int32.toText(val)};
                case(#Int16(val)){ Int16.toText(val)};
                case(#Int8(val)){ Int8.toText(val)};
                case(#Int(val)){ Int.toText(val)};
                case(#Bool(val)){ Bool.toText(val)};
                case(#Float(val)){ Float.format(#exact, val)};
                case(#Option(val)){
                    switch(val){
                        case(null){ "null"};
                        case(?val){valueUnstableToText(val)};
                    };
                };
                //blob
                case(#Blob(val)){
                    valueUnstableToText(#Bytes(#frozen(Blob.toArray(val))));
                };
                //class
                case(#Class(val)){ //this is currently not parseable and should probably just be used for debuging. It would be nice to output candid.

                    var t = "{";
                    for(thisItem in val.vals()){
                        t := t # thisItem.name # ":" # (if(thisItem.immutable == false){"var "}else{""}) # valueUnstableToText(thisItem.value) # "; ";
                    };
                    
                    return Text.trimEnd(t, #text(" ")) # "}";


                };
                //principal
                case(#Principal(val)){ Principal.toText(val)};
                //array
                case(#Array(val)){
                    switch(val){
                        case(#frozen(val)){
                            var t = "[";
                            for(thisItem in val.vals()){
                                t := t # "{" # valueUnstableToText(thisItem) # "} ";
                            };
                            
                            return Text.trimEnd(t, #text(" ")) # "]";
                        };
                        case(#thawed(val)){
                            var t = "[";
                            for(thisItem in val.vals()){
                                t := t # "{" #valueUnstableToText(thisItem) # "} ";
                            };
                            
                            return Text.trimEnd(t, #text(" ")) # "]";
                        };
                    };
                };
                //floats
                case(#Floats(val)){
                    switch(val){
                        case(#frozen(val)){
                            var t = "[";
                            for(thisItem in val.vals()){
                                t := t # Float.format(#exact, thisItem) # " ";
                            };
                            
                            return Text.trimEnd(t, #text(" ")) # "]";
                        };
                        case(#thawed(val)){
                            var t = "[";
                            for(thisItem in val.vals()){
                                t := t # Float.format(#exact, thisItem) # " ";
                            };
                            
                            return Text.trimEnd(t, #text(" ")) # "]";
                        };
                    };
                };
                //bytes
                case(#Bytes(val)){
                    switch(val){
                        case(#frozen(val)){
                            
                            return Hex.encode(val);
                        };
                        case(#thawed(val)){
                            
                            return Hex.encode(val.toArray());
                        };
                    };
                };
                case(_){assert(false);/*unreachable*/"";};
            };
        };

        public func valueUnstableToPrincipal(val : CandyValueUnstable) : Principal {
            switch(val){
                case(#Principal(val)){ val};
                case(_){assert(false);/*unreachable*/Principal.fromText("");};
            };
        };

        public func valueUnstableToBool(val : CandyValueUnstable) : Bool {
            switch(val){
                case(#Bool(val)){ val};
                case(_){assert(false);/*unreachable*/false;};
            };
        };

        public func valueUnstableToBlob(val : CandyValueUnstable) : Blob {
            switch(val){

                case(#Blob(val)){ val};
                case(#Bytes(val)){
                    
                    Blob.fromArray(
                    switch(val){
                        case(#frozen(val)){val;};
                        case(#thawed(val)){val.toArray()};

                    }
                )};
                  case(#Text(val)){
                    Blob.fromArray(textToBytes(val))
                };
                case(#Int(val)){
                    Blob.fromArray(intToBytes(val))
                };
                case(#Nat(val)){
                    Blob.fromArray(natToBytes(val))
                };
                case(#Nat8(val)){
                    
                    Blob.fromArray([val])
                };
                case(#Nat16(val)){
                    Blob.fromArray(nat16ToBytes(val))
                };
                case(#Nat32(val)){
                    Blob.fromArray(nat32ToBytes(val))
                };
                case(#Nat64(val)){
                    Blob.fromArray(nat64ToBytes(val))
                };
                case(#Principal(val)){
                    
                    Principal.toBlob(val);
                };
                //todo: could add all conversions here
                case(_){assert(false);/*unreachable*/"\00";};
            };
        };

        //gets the array of candy values out of an array
        public func valueUnstableToValueArray(val : CandyValueUnstable) : [CandyValueUnstable] {

            switch(val){
                case(#Array(val)){
                    switch(val){
                        case(#frozen(val)){val};
                        case(#thawed(val)){val.toArray()};
                    };
                };
                //todo: could add all conversions here
                case(_){assert(false);/*unreachable*/[];};
            };
        };

        public func valueToBytes(val : CandyValue) : [Nat8]{
            switch(val){
                case(#Int(val)){intToBytes(val)};
                case(#Int8(val)){valueToBytes(#Int(valueToInt(#Int8(val))))};
                case(#Int16(val)){valueToBytes(#Int(valueToInt(#Int16(val))))};
                case(#Int32(val)){valueToBytes(#Int(valueToInt(#Int32(val))))};
                case(#Int64(val)){valueToBytes(#Int(valueToInt(#Int64(val))))};
                case(#Nat(val)){natToBytes(val)};
                case(#Nat8(val)){ [val]};
                case(#Nat16(val)){nat16ToBytes(val)};
                case(#Nat32(val)){nat32ToBytes(val)};
                case(#Nat64(val)){nat64ToBytes(val)};
                case(#Float(val)){Prelude.nyi()};
                case(#Text(val)){textToBytes(val)};
                case(#Bool(val)){boolToBytes(val)};
                case(#Blob(val)){ Blob.toArray(val)};
                case(#Class(val)){Prelude.nyi()};
                case(#Principal(val)){principalToBytes(val)};
                case(#Option(val)){Prelude.nyi()};
                case(#Array(val)){Prelude.nyi()};
                case(#Bytes(val)){
                    switch(val){
                        case(#frozen(val)){ val};
                        case(#thawed(val)){ val};
                    };
                };
                case(#Floats(val)){Prelude.nyi()};
                case(#Nats(val)){Prelude.nyi()};
                case(#Empty){ []};
            }
        };

        public func valueUnstableToBytes(val : CandyValueUnstable) : [Nat8]{
            switch(val){
                case(#Int(val)){intToBytes(val)};
                case(#Int8(val)){valueUnstableToBytes(#Int(valueUnstableToInt(#Int8(val))))};
                case(#Int16(val)){valueUnstableToBytes(#Int(valueUnstableToInt(#Int16(val))))};
                case(#Int32(val)){valueUnstableToBytes(#Int(valueUnstableToInt(#Int32(val))))};
                case(#Int64(val)){valueUnstableToBytes(#Int(valueUnstableToInt(#Int64(val))))};
                case(#Nat(val)){ natToBytes(val)};
                case(#Nat8(val)){ [val]};
                case(#Nat16(val)){nat16ToBytes(val)};
                case(#Nat32(val)){nat32ToBytes(val)};
                case(#Nat64(val)){nat64ToBytes(val)};
                case(#Float(val)){Prelude.nyi()};
                case(#Text(val)){textToBytes(val)};
                case(#Bool(val)){boolToBytes(val)};
                case(#Blob(val)){ Blob.toArray(val)};
                case(#Class(val)){Prelude.nyi()};
                case(#Principal(val)){principalToBytes(val)};
                case(#Option(val)){Prelude.nyi()};
                case(#Array(val)){Prelude.nyi()};
                case(#Bytes(val)){
                    switch(val){
                        case(#frozen(val)){ val};
                        case(#thawed(val)){ val.toArray()};
                    };
                };
                case(#Floats(val)){Prelude.nyi()};
                case(#Nats(val)){Prelude.nyi()};
                case(#Empty){ []};
            }
        };

        public func valueUnstableToBytesBuffer(val : CandyValueUnstable) : Buffer.Buffer<Nat8>{
            switch (val){
                case(#Bytes(val)){
                    switch(val){
                        case(#frozen(val)){
                            
                            return toBuffer<Nat8>(val);

                        };
                        case(#thawed(val)){ val};
                    };
                };
                case(_){
                    toBuffer<Nat8>(valueUnstableToBytes(val));//may throw for uncovertable types
                };
            };
        };

        public func valueUnstableToFloatsBuffer(val : CandyValueUnstable) : Buffer.Buffer<Float>{
            switch (val){
                case(#Floats(val)){
                    switch(val){
                        case(#frozen(val)){
                            
                            toBuffer(val);
                        };
                        case(#thawed(val)){ val};
                    };
                };
                case(_){
                    toBuffer([valueUnstableToFloat(val)]); //may throw for unconvertable types
                };
            };
        };

        public func valueUnstableToNatsBuffer(val : CandyValueUnstable) : Buffer.Buffer<Nat>{
            switch (val){
                case(#Nats(val)){
                    switch(val){
                        case(#frozen(val)){
                            toBuffer(val);
                        };
                        case(#thawed(val)){val};
                    };
                };
                case(_){
                    toBuffer([valueUnstableToNat(val)]); //may throw for unconvertable types
                };
            };
        };

        


        //////////////////////////////////////////////////////////////////////
        // The following functions easily creates a buffer from an arry of any type
        //////////////////////////////////////////////////////////////////////

        public func toBuffer<T>(x :[T]) : Buffer.Buffer<T>{
            
            let thisBuffer = Buffer.Buffer<T>(x.size());
            for(thisItem in x.vals()){
                thisBuffer.add(thisItem);
            };
            return thisBuffer;
        };

        //////////////////////////////////////////////////////////////////////
        // The following functions converst standard types to Byte arrays
        // From there you can easily get to blobs if necessary with the Blob package
        //////////////////////////////////////////////////////////////////////

        public func nat64ToBytes(x : Nat64) : [Nat8] {
            
            [ Nat8.fromNat(Nat64.toNat((x >> 56) & (255))),
            Nat8.fromNat(Nat64.toNat((x >> 48) & (255))),
            Nat8.fromNat(Nat64.toNat((x >> 40) & (255))),
            Nat8.fromNat(Nat64.toNat((x >> 32) & (255))),
            Nat8.fromNat(Nat64.toNat((x >> 24) & (255))),
            Nat8.fromNat(Nat64.toNat((x >> 16) & (255))),
            Nat8.fromNat(Nat64.toNat((x >> 8) & (255))),
            Nat8.fromNat(Nat64.toNat((x & 255))) ];
        };

        public func nat32ToBytes(x : Nat32) : [Nat8] {
            
            [ Nat8.fromNat(Nat32.toNat((x >> 24) & (255))),
            Nat8.fromNat(Nat32.toNat((x >> 16) & (255))),
            Nat8.fromNat(Nat32.toNat((x >> 8) & (255))),
            Nat8.fromNat(Nat32.toNat((x & 255))) ];
        };

        /// Returns [Nat8] of size 4 of the Nat16
        public func nat16ToBytes(x : Nat16) : [Nat8] {
            
            [ Nat8.fromNat(Nat16.toNat((x >> 8) & (255))),
            Nat8.fromNat(Nat16.toNat((x & 255))) ];
        };

        public func bytesToNat16(bytes: [Nat8]) : Nat16{
            
            (Nat16.fromNat(Nat8.toNat(bytes[0])) << 8) +
            (Nat16.fromNat(Nat8.toNat(bytes[1])));
        };

        public func bytesToNat32(bytes: [Nat8]) : Nat32{
            
            (Nat32.fromNat(Nat8.toNat(bytes[0])) << 24) +
            (Nat32.fromNat(Nat8.toNat(bytes[1])) << 16) +
            (Nat32.fromNat(Nat8.toNat(bytes[2])) << 8) +
            (Nat32.fromNat(Nat8.toNat(bytes[3])));
        };

        public func bytesToNat64(bytes: [Nat8]) : Nat64{
            
            (Nat64.fromNat(Nat8.toNat(bytes[0])) << 56) +
            (Nat64.fromNat(Nat8.toNat(bytes[0])) << 48) +
            (Nat64.fromNat(Nat8.toNat(bytes[1])) << 40) +
            (Nat64.fromNat(Nat8.toNat(bytes[2])) << 32) +
            (Nat64.fromNat(Nat8.toNat(bytes[0])) << 24) +
            (Nat64.fromNat(Nat8.toNat(bytes[1])) << 16) +
            (Nat64.fromNat(Nat8.toNat(bytes[2])) << 8) +
            (Nat64.fromNat(Nat8.toNat(bytes[3])));
        };


        public func natToBytes(n : Nat) : [Nat8] {
            
            var a : Nat8 = 0;
            var b : Nat = n;
            var bytes = List.nil<Nat8>();
            var test = true;
            while test {
                a := Nat8.fromNat(b % 256);
                b := b / 256;
                bytes := List.push<Nat8>(a, bytes);
                test := b > 0;
            };
            List.toArray<Nat8>(bytes);
        };

        public func bytesToNat(bytes : [Nat8]) : Nat {
            
            var n : Nat = 0;
            var i = 0;
            Array.foldRight<Nat8, ()>(bytes, (), func (byte, _) {
                n += Nat8.toNat(byte) * 256 ** i;
                i += 1;
                return;
            });
            return n;
        };

        public func textToByteBuffer(_text : Text) : Buffer.Buffer<Nat8>{
            
            let result : Buffer.Buffer<Nat8> = Buffer.Buffer<Nat8>((_text.size() * 4) +4);
            for(thisChar in _text.chars()){
                for(thisByte in nat32ToBytes(Char.toNat32(thisChar)).vals()){
                    result.add(thisByte);
                };
            };
            return result;
        };

        public func textToBytes(_text : Text) : [Nat8]{
            
            return textToByteBuffer(_text).toArray();
        };

        public func bytesToText(_bytes : [Nat8]) : Text{
            
            var result : Text = "";
            var aChar : [var Nat8] = [var 0, 0, 0, 0];

            for(thisChar in Iter.range(0,_bytes.size())){
                if(thisChar > 0 and thisChar % 4 == 0){
                    aChar[0] := _bytes[thisChar-4];
                    aChar[1] := _bytes[thisChar-3];
                    aChar[2] := _bytes[thisChar-2];
                    aChar[3] := _bytes[thisChar-1];
                    result := result # Char.toText(Char.fromNat32(bytesToNat32(Array.freeze<Nat8>(aChar))));
                };
            };
            return result;
        };

        public func principalToBytes(_principal: Principal) : [Nat8]{
            
            return Blob.toArray(Principal.toBlob(_principal));
        };

        public func bytesToPrincipal(_bytes: [Nat8]) : Principal{
            
            return Principal.fromBlob(Blob.fromArray(_bytes));
        };

        public func boolToBytes(_bool : Bool) : [Nat8]{
            
            if(_bool == true){
                return [1:Nat8];
            } else {
                return [0:Nat8];
            };
        };

        public func bytesToBool(_bytes : [Nat8]) : Bool{
            
            if(_bytes[0] == 0){
                return false;
            } else {
                return true;
            };
        };

        public func intToBytes(n : Int) : [Nat8]{
            
            var a : Nat8 = 0;
            var c : Nat8 = if(n < 0){1}else{0};
            var b : Nat = Int.abs(n);
            var bytes = List.nil<Nat8>();
            var test = true;
            while test {
                a := Nat8.fromNat(b % 128);
                b := b / 128;
                bytes := List.push<Nat8>(a, bytes);
                test := b > 0;
            };

            Array.append<Nat8>([c],List.toArray<Nat8>(bytes));
        };

        public func bytesToInt(_bytes : [Nat8]) : Int{
            
            var n : Int = 0;
            var i = 0;
            let natBytes = Array.tabulate<Nat8>(_bytes.size() - 2, func(idx){_bytes[idx+1]});

            Array.foldRight<Nat8, ()>(natBytes, (), func (byte, _) {
                n += Nat8.toNat(byte) * 128 ** i;
                i += 1;
                return;
            });
            if(_bytes[0]==1){
                n *= -1;
            };
            return n;
        };

        

        public func unwrapOptionValue(val : CandyValue): CandyValue{
            
            switch(val){
                case(#Option(val)){
                    switch(val){
                        case(null){
                            return #Empty;
                        };
                        case(?val){
                            return val;
                        }
                    };
                };
                case(_){val};
            };
        };

        public func unwrapOptionValueUnstable(val : CandyValueUnstable): CandyValueUnstable{
            
            switch(val){
                case(#Option(val)){
                    switch(val){
                        case(null){
                            return #Empty;
                        };
                        case(?val){
                            return val;
                        }
                    };
                };
                case(_){val};
            };
        };

}