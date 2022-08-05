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

import Map "mo:map/Map";
import SB "mo:stablebuffer/StableBuffer";



module {

    

    ////////////////////////////////////
    //
    // The the following stable types were copied from departurelabs' property.mo.  They work as a plug and play
    // here with CandyValue.
    //
    // https://github.com/DepartureLabsIC/non-fungible-token/blob/main/src/property.mo
    //
    // The following section is issued under the MIT License Copyright (c) 2021 Departure Labs:
    ///////////////////////////////////

    public type Properties = [Property];
    public type Property = {name : Text; value : CandyValue; immutable : Bool};

    public type UpdateRequest = {
        id     : Text;
        update : [Update];
    };

    public type Update = {
        name : Text;
        mode : UpdateMode;
    };

    public type UpdateMode = {
        #Set    : CandyValue;
        #Lock    : CandyValue;
        #Next   : [Update];
    };

    public type PropertyError = {
        #Unauthorized;
        #NotFound;
        #InvalidRequest;
        #AuthorizedPrincipalLimitReached : Nat;
        #Immutable;
    };

    public type Query = {
        name : Text;    // Target property name.
        next : [Query]; // Optional sub-properties in the case of a class value.
    };

    public type QueryMode = {
        #All;            // Returns all properties.
        #Some : [Query]; // Returns a select set of properties based on the name.
    };

    ///////////////////////////////////
    //
    // End departurelabs' property.mo types
    //
    ///////////////////////////////////

//stable
    public type CandyValue = {
        #Int : Int;
        #Int8: Int8;
        #Int16: Int16;
        #Int32: Int32;
        #Int64: Int64;
        #Nat : Nat;
        #Nat8 : Nat8;
        #Nat16 : Nat16;
        #Nat32 : Nat32;
        #Nat64 : Nat64;
        #Float : Float;
        #Text : Text;
        #Bool : Bool;
        #Blob : Blob;
        #Class : [Property];
        #Principal : Principal;
        #Option : ?CandyValue;
        #Dictionary : Map.Map<CandyValue,CandyValue>;
        #Array : {
            #frozen: [CandyValue];
            #thawed: SB.StableBuffer<CandyValue>;
        };
        #Nats: {
            #frozen: [Nat];
            #thawed: SB.StableBuffer<Nat>;
         };
        #Floats: {
            #frozen: [Float];
            #thawed: SB.StableBuffer<Float>;
        };
        #Bytes : {
            #frozen: [Nat8];
            #thawed: SB.StableBuffer<Nat8>;
        };
        #Empty;
    };

    //a data chunk should be no larger than 2MB so that it can be shipped to other canisters
    public type DataChunk = CandyValue;
    public type DataZone = SB.StableBuffer<DataChunk>;
    public type Workspace = SB.StableBuffer<DataZone>;

    public type AddressedChunk = (Nat, Nat, CandyValue);
    public type AddressedChunkArray = [AddressedChunk];
    public type AddressedChunkBuffer = SB.StableBuffer<AddressedChunk>;

    

        //////////////////////////////////////////////////////////////////////
        // The following functions easily creates a buffer from an arry of any type
        //////////////////////////////////////////////////////////////////////

        public func toBuffer<T>(x :[T]) : SB.StableBuffer<T>{
            
            var thisBuffer = SB.initPresized<T>(x.size());
            for(thisItem in x.vals()){
                SB.add<T>(thisBuffer, thisItem);
            };
            return thisBuffer;
        };

}