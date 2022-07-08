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

import SB "mo:stablebuffer/StableBuffer";

module {

        type CandyValue = Types.CandyValue;
        type Property = Types.Property;


        public func clone(val : CandyValue) : CandyValue{
            switch(val){
                case(#Class(val)){

                    return #Class(Array.tabulate<Property>(val.size(), func(idx){
                        {name= val[idx].name; value=clone(val[idx].value); immutable = val[idx].immutable};
                    }));
                };
                case(#Bytes(val)){
                    switch(val){
                        case(#frozen(val)){
                            
                            #Bytes(#frozen(val));
                        };
                        case(#thawed(val)){
                            
                            #Bytes(#thawed(SB.clone<Nat8>(val)));
                        };
                    }
                };
                case(#Nats(val)){
                    switch(val){
                        case(#frozen(val)){
                            
                            #Nats(#frozen(val));
                        };
                        case(#thawed(val)){
                            
                            #Nats(#thawed(SB.clone<Nat>(val)));
                        };
                    }
                };
                case(#Floats(val)){
                    switch(val){
                        case(#frozen(val)){
                            
                            #Floats(#frozen(val));
                        };
                        case(#thawed(val)){
                            
                            #Floats(#thawed(SB.clone<Float>(val)));
                        };
                    }
                };
                case(#Array(val)){
                    switch(val){
                        case(#frozen(val)){
                            
                            #Array(#frozen(val));
                        };
                        case(#thawed(val)){
                            
                            #Array(#thawed(SB.clone<CandyValue>(val)));
                        };
                    }
                };
                case(_){
                    
                    val;
                }
            };
        };

}