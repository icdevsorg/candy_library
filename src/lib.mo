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

import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Buffer "mo:base/Buffer";
import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Int "mo:base/Int";
import Int8 "mo:base/Int8";
import Int16 "mo:base/Int16";
import Int32 "mo:base/Int32";
import Int64 "mo:base/Int64";
import Bool "mo:base/Bool";
import Iter "mo:base/Iter";
import Float "mo:base/Float";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Nat16 "mo:base/Nat16";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Nat8 "mo:base/Nat8";
import Prelude "mo:base/Prelude";
import Principal "mo:principal/Principal";
import Result "mo:base/Result";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Cycles "mo:base/ExperimentalCycles";
import Hex "./hex";

module {

    public type PropertiesUnstable = [PropertyUnstable];
    public type PropertyUnstable = {name : Text; value : CandyValueUnstable; immutable : Bool};

    public type UpdateRequestUnstable = {
        id     : Text;
        update : [UpdateUnstable];
    };

    public type UpdateUnstable = {
        name : Text;
        mode : UpdateModeUnstable;
    };

    public type UpdateModeUnstable = {
        #Set    : CandyValueUnstable;
        #Next   : [UpdateUnstable];
    };

    //a data chunk should be no larger than 2MB so that it can be shipped to other canisters
    public type DataChunk = CandyValueUnstable;
    public type DataZone = Buffer.Buffer<DataChunk>;
    public type Workspace = Buffer.Buffer<DataZone>;

    public type AddressedChunk = (Nat, Nat, CandyValue);
    public type AddressedChunkArray = [AddressedChunk];
    public type AddressedChunkBuffer = Buffer.Buffer<AddressedChunk>;

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
        #Array : {
            #frozen: [CandyValue];
            #thawed: [CandyValue]; //need to thaw when going to CandyValueUnstable
        };
        #Floats: {
            #frozen: [Float];
            #thawed: [Float]; //need to thaw when going to CandyValueUnstable
        };
        #Bytes : {
            #frozen: [Nat8];
            #thawed: [Nat8]; //need to thaw when going to CandyValueUnstable
        };
        #Empty;
    };

    //unstable
    public type CandyValueUnstable = {
        #Int :  Int;
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
        #Class : [PropertyUnstable];
        #Principal : Principal;
        #Floats : {
            #frozen: [Float];
            #thawed: Buffer.Buffer<Float>;
        };
        #Array : {
            #frozen: [CandyValueUnstable];
            #thawed: Buffer.Buffer<CandyValueUnstable>; //need to thaw when going to CandyValueUnstable
        };
        #Option : ?CandyValueUnstable;
        #Bytes : {
            #frozen: [Nat8];
            #thawed: Buffer.Buffer<Nat8>; //need to thaw when going to CandyValueUnstable
        };
        #Empty;
    };

    ////////////////////////////////////
    //
    // The the following stable types were copied from departurelabs' property.mo.  They work as a plug and play
    // here with CandyValue.
    //
    // https://github.com/DepartureLabsIC/non-fungible-token/blob/main/src/property.mo
    //
    // The following section is issued under the MIT License Copyright (c) 2021 Departure Labs:
    ///////////////////////////////////

    public type Property = {name : Text; value : CandyValue; immutable : Bool};

    public type Properties = [Property];

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

    // Specifies the properties that should be updated to a certain value.
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
        #Next   : [Update];
    };

    ///////////////////////////////////
    //
    // End departurelabs' property.mo types
    //
    // Code below resumes the Copyright ARAMAKME
    //
    ///////////////////////////////////



    public class Candy(){


        private func toPropertyUnstableMap(ps : PropertiesUnstable) : HashMap.HashMap<Text,PropertyUnstable> {
            
            let m = HashMap.HashMap<Text,PropertyUnstable>(ps.size(), Text.equal, Text.hash);
            for (property in ps.vals()) {
                m.put(property.name, property);
            };
            m;
        };

        private func fromPropertyUnstableMap(m : HashMap.HashMap<Text,PropertyUnstable>) : PropertiesUnstable {
            
            var ps : PropertiesUnstable = [];
            for ((_, p) in m.entries()) {
                ps := Array.append(ps, [p]);
            };
            ps;
        };


        // Returns a subset of from properties based on the given query.
        // NOTE: ignores unknown properties.
        public func getPropertiesUnstable(properties : PropertiesUnstable, qs : [Query]) : Result.Result<PropertiesUnstable, PropertyError> {
            let m               = toPropertyUnstableMap(properties);
            var ps : PropertiesUnstable = [];
            for (q in qs.vals()) {
                switch (m.get(q.name)) {
                    case (null) {
                        // Query contained an unknown property.
                        return #err(#NotFound);
                    };
                    case (? p)  {
                        switch (p.value) {
                            case (#Class(c)) {
                                if (q.next.size() == 0) {
                                    // Return every sub-attribute attribute.
                                    ps := Array.append(ps, [p]);
                                } else {
                                    let sps = switch (getPropertiesUnstable(c, q.next)) {
                                        case (#err(e)) { return #err(e); };
                                        case (#ok(v))  { v; };
                                    };
                                    
                                    ps := Array.append(ps, [{
                                        name      = p.name;
                                        value     = #Class(sps);
                                        immutable = p.immutable;
                                    }]);
                                };
                            };
                            case (other) {
                                // Not possible to get sub-attribute of a non-class property.
                                if (q.next.size() != 0) {
                                    return #err(#NotFound);
                                };
                                ps := Array.append(ps, [p]);
                            };
                        }
                    };
                };
            };
            #ok(ps);
        };

        // Updates the given properties based on the given update query.
        // NOTE: creates unknown properties.
        public func updatePropertiesUnstable(properties : PropertiesUnstable, us : [UpdateUnstable]) : Result.Result<PropertiesUnstable, PropertyError> {
            let m = toPropertyUnstableMap(properties);
            for (u in us.vals()) {
                switch (m.get(u.name)) {
                    case (null) {
                        // Update contained an unknown property, so it gets created.
                        switch (u.mode) {
                            case (#Next(sus)) {
                                let sps = switch(updatePropertiesUnstable([], sus)) {
                                    case (#err(e)) { return #err(e); };
                                    case (#ok(v))  { v; };
                                };
                                
                                m.put(u.name, {
                                    name      = u.name;
                                    value     = #Class(sps);
                                    immutable = false;
                                });
                            };
                            case (#Set(v)) {
                                m.put(u.name, {
                                    name      = u.name;
                                    value     = v;
                                    immutable = false;
                                });
                            };
                        };
                    };
                    case (? p)  {
                        // Can not update immutable property.
                        if (p.immutable) {
                            return #err(#Immutable);
                        };
                        switch (u.mode) {
                            case (#Next(sus)) {
                                switch (p.value) {
                                    case (#Class(c)) {
                                        let sps = switch(updatePropertiesUnstable(c, sus)) {
                                            case (#err(e)) { return #err(e); };
                                            case (#ok(v))  { v; };
                                        };
                                        
                                        m.put(u.name, {
                                            name      = p.name;
                                            value     = #Class(sps);
                                            immutable = false;
                                        });
                                    };
                                    case (other) {
                                        // Not possible to update sub-attribute of a non-class property.
                                        return #err(#NotFound);
                                    };
                                };
                                return #err(#NotFound);
                            };
                            case (#Set(v)) {
                                m.put(u.name, {
                                    name      = p.name;
                                    value     = v;
                                    immutable = false;
                                });
                            };
                        };
                    };
                };
            };
            
            #ok(fromPropertyUnstableMap(m));
        };



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


        public func cloneValueUnstable(val : CandyValueUnstable) : CandyValueUnstable{
            switch(val){
                case(#Class(val)){

                    return #Class(Array.tabulate<PropertyUnstable>(val.size(), func(idx){
                        {name= val[idx].name; value=cloneValueUnstable(val[idx].value); immutable = val[idx].immutable};
                    }));
                };
                case(#Bytes(val)){
                    switch(val){
                        case(#frozen(val)){
                            
                            #Bytes(#frozen(val));
                        };
                        case(#thawed(val)){
                            
                            #Bytes(#thawed(val.clone()));
                        };
                    }
                };
                case(_){
                    
                    val;
                }
            };
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

        public func stabalizeProperty(item : PropertyUnstable) : Property{
            return {
                name = item.name;
                value = stabalizeValue(item.value);
                immutable = item.immutable;
            }
        };

        public func destabalizeProperty(item : Property) : PropertyUnstable{
            return {
                name = item.name;
                value = destabalizeValue(item.value);
                immutable = item.immutable;
            }
        };

        public func stabalizeValue(item : CandyValueUnstable) : CandyValue{
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

                case(#Class(val)){
                    #Class(
                        Array.tabulate<Property>(val.size(), func(idx){
                            stabalizeProperty(val[idx]);
                        }));
                };
                case(#Principal(val)){ #Principal(val)};
                case(#Array(val)){
                    switch(val){
                        case(#frozen(val)){#Array(#frozen(stabalizeValueArray(val)))};
                        case(#thawed(val)){#Array(#thawed(stabalizeValueArray(val.toArray())))};
                    };
                };
                case(#Option(val)){
                    switch(val){
                        case(null){ #Option(null)};
                        case(?val){#Option(?stabalizeValue(val))};
                    };
                };
                case(#Bytes(val)){
                    switch(val){
                        case(#frozen(val)){ #Bytes(#frozen(val))};
                        case(#thawed(val)){ #Bytes(#thawed(val.toArray()))};
                    };
                };
                case(#Floats(val)){
                    switch(val){
                        case(#frozen(val)){ #Floats(#frozen(val))};
                        case(#thawed(val)){ #Floats(#thawed(val.toArray()))};
                    };
                };
                case(#Empty){ #Empty};
            }
        };

        public func destabalizeValue(item : CandyValue) : CandyValueUnstable{
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
                case(#Class(val)){
                    #Class(
                        Array.tabulate<PropertyUnstable>(val.size(), func(idx){
                            destabalizeProperty(val[idx]);
                        }));
                };
                case(#Principal(val)){#Principal(val)};
                case(#Array(val)){
                    switch(val){
                        case(#frozen(val)){#Array(#frozen(destabalizeValueArray(val)))};
                        case(#thawed(val)){#Array(#thawed(toBuffer<CandyValueUnstable>(destabalizeValueArray(val))))};
                    };
                };
                case(#Option(val)){
                    switch(val){
                        case(null){ #Option(null)};
                        case(?val){#Option(?destabalizeValue(val))};
                    };
                };
                case(#Bytes(val)){
                    switch(val){
                        case(#frozen(val)){ #Bytes(#frozen(val))};
                        case(#thawed(val)){#Bytes(#thawed(toBuffer<Nat8>(val)))};
                    };
                };
                case(#Floats(val)){
                    switch(val){
                        case(#frozen(val)){ #Floats(#frozen(val))};
                        case(#thawed(val)){#Floats(#thawed(toBuffer<Float>(val)))};
                    };
                };
                case(#Empty){ #Empty};
            }
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

        //////////////////////////////////////////////////////////////////////
        // The following functions enable the inspection and manipulation of workspaces
        // Workspaces are valueble when using orthogonal persistance to keep track of data
        // in a format that is easily transmitable across the wire given IC restrictions
        //////////////////////////////////////////////////////////////////////

        public func countAddressedChunksInWorkspace(x : Workspace) : Nat{
            
            var chunks = 0;
            for (thisZone in Iter.range(0, x.size() - 1)){
                chunks += x.get(thisZone).size();
            };
            chunks;

        };

        public func emptyWorkspace() : Workspace {
            
            return Buffer.Buffer<DataZone>(1);
        };

        public func initWorkspace(size : Nat) : Workspace {
            
            return Buffer.Buffer<DataZone>(size);
        };

        //variants take up 2 bytes as long as there are fewer than 32 item in the enum
        public func getValueSize(item : CandyValue) : Nat{
            
            let varSize = switch(item){
                case(#Int(val)){
                    var a : Nat = 0;
                    var b : Nat = Int.abs(val);
                    var test = true;
                    while test {
                        a += 1;
                        b := b / 256;
                        test := b > 0;
                    };
                    a + 1;//add the sign
                };
                case(#Int8(val)){1};
                case(#Int16(val)){2};
                case(#Int32(val)){3};
                case(#Int64(val)){4};
                case(#Nat(val)){
                    var a : Nat = 0;
                    var b = val;
                    var test = true;
                    while test {
                        a += 1;
                        b := b / 256;
                        test := b > 0;
                    };
                    a;
                };
                case(#Nat8(val)){1};
                case(#Nat16(val)){2};
                case(#Nat32(val)){3};
                case(#Nat64(val)){4};
                case(#Float(val)){4};
                case(#Text(val)){(val.size()*4)};
                case(#Bool(val)){1};
                case(#Blob(val)){val.size()};
                case(#Class(val)){
                    var size = 0;
                    for(thisItem in val.vals()){
                        size += 1 + (thisItem.name.size() * 4) + getValueSize(thisItem.value);
                    };
                    
                    return size;
                };
                case(#Principal(val)){principalToBytes(val).size()};//don't like this but need to confirm it is constant
                case(#Option(val)){
                    switch val{
                        case(null){0};
                        case(?val){getValueSize(val)}
                    }
                };
                case(#Array(val)){
                    switch(val){
                        case(#frozen(val)){
                            var size = 0;
                            for(thisItem in val.vals()){
                                size += 1 + getValueSize(thisItem);
                            };
                            
                            return size;
                        };
                        case(#thawed(val)){
                            var size = 0;
                            for(thisItem in val.vals()){
                                size += 1 + getValueSize(thisItem);
                            };
                            
                            return size;
                        };
                    };
                };
                case(#Bytes(val)){
                    switch(val){
                        case(#frozen(val)){val.size() + 2};
                        case(#thawed(val)){val.size() + 2};
                    };
                };
                case(#Floats(val)){
                    switch(val){
                        case(#frozen(val)){(val.size() * 4) + 2};
                        case(#thawed(val)){(val.size() * 4) + 2};
                    };
                };
                case(#Empty){0};
            };

            return varSize;
        };

        public func getValueUnstableSize(item : CandyValueUnstable) : Nat{
            
            let varSize = switch(item){
                case(#Int(val)){
                    var a : Nat = 0;
                    var b : Nat = Int.abs(val);
                    var test = true;
                    while test {
                        a += 1;
                        b := b / 256;
                        test := b > 0;
                    };
                    a + 1;//add the sign
                };
                case(#Int8(val)){1};
                case(#Int16(val)){2};
                case(#Int32(val)){3};
                case(#Int64(val)){4};
                case(#Nat(val)){
                    var a : Nat = 0;
                    var b = val;
                    var test = true;
                    while test {
                        a += 1;
                        b := b / 256;
                        test := b > 0;
                    };
                    a;
                };
                case(#Nat8(val)){1};
                case(#Nat16(val)){2};
                case(#Nat32(val)){3};
                case(#Nat64(val)){4};
                case(#Float(val)){4};
                case(#Text(val)){val.size()*4};
                case(#Bool(val)){1};
                case(#Blob(val)){val.size()};
                case(#Class(val)){
                    var size = 0;
                    for(thisItem in val.vals()){
                        size += 1 + (thisItem.name.size() * 4) + getValueUnstableSize(thisItem.value);
                    };

                    return size;
                };
                case(#Principal(val)){principalToBytes(val).size()};//don't like this but need to confirm it is constant
                case(#Option(val)){
                    switch val{
                        case(null){0};
                        case(?val){ getValueUnstableSize(val)}
                    }
                };
                case(#Array(val)){
                    switch(val){
                        case(#frozen(val)){
                            var size = 0;
                            for(thisItem in val.vals()){
                                size += 1 + getValueUnstableSize(thisItem);
                            };
                            
                            return size;
                        };
                        case(#thawed(val)){
                            var size = 0;
                            for(thisItem in val.vals()){
                                size += 1 + getValueUnstableSize(thisItem);
                            };
                            
                            return size;
                        };
                    };
                };

                case(#Bytes(val)){
                    switch(val){
                        case(#frozen(val)){val.size() + 2};
                        case(#thawed(val)){val.size() + 2};
                    };
                };
                case(#Floats(val)){
                    switch(val){
                        case(#frozen(val)){(val.size() * 4) + 2};
                        case(#thawed(val)){(val.size() * 4) + 2};
                    };
                };
                case(#Empty){0};
            };
            return varSize + 2;
        };

        public func stabalizeValueArray(items : [CandyValueUnstable]) : [CandyValue]{
            
            let finalItems = Buffer.Buffer<CandyValue>(items.size());
            for(thisItem in items.vals()){
                finalItems.add(stabalizeValue(thisItem));
            };
            
            return finalItems.toArray();


        };

        public func destabalizeValueArray(items : [CandyValue]) : [CandyValueUnstable]{
            
            let finalItems = Buffer.Buffer<CandyValueUnstable>(items.size());
            for(thisItem in items.vals()){
                finalItems.add(destabalizeValue(thisItem));
            };
            
            return finalItems.toArray();
        };

        public func stabalizeValueBuffer(items : DataZone) : [CandyValue]{
            
            let finalItems = Buffer.Buffer<CandyValue>(items.size());
            for(thisItem in items.vals()){
                finalItems.add(stabalizeValue(thisItem));
            };
            
            return finalItems.toArray();

        };

        public func workspaceToAddressedChunkArray(x : Workspace) : AddressedChunkArray {
            
            var currentZone = 0;
            var currentChunk = 0;
            let result = Array.tabulate<AddressedChunk>(countAddressedChunksInWorkspace(x), func(thisChunk){
                let thisChunk = (currentZone, currentChunk, stabalizeValue(x.get(currentZone).get(currentChunk)));
                if(currentChunk == Nat.sub(x.get(currentZone).size(),1)){
                    currentZone += 1;
                    currentChunk := 0;
                } else {
                    currentChunk += 1;
                };
                thisChunk;
            });

            return result;
        };

        public func workspaceDeepClone(x : Workspace) : Workspace {
            
            var currentZone = 0;
            var currentChunk = 0;
            let ws = Buffer.Buffer<DataZone>(x.size());
            for(thisZone in x.vals()){

                let tz = Buffer.Buffer<DataChunk>(thisZone.size());
                ws.add(tz);
                for(thisDataChunk in thisZone.vals()){
                    tz.add(cloneValueUnstable(thisDataChunk));
                };
                
            };
            return ws;
        };

        public func fromAddressedChunks(x : AddressedChunkArray) : Workspace{
            let result = Buffer.Buffer<DataZone>(x.size());
            fileAddressedChunks(result, x);
            return result;
        };

        public func fileAddressedChunks(workspace: Workspace, x : AddressedChunkArray) {
            
            for (thisChunk : AddressedChunk in Array.vals<AddressedChunk>(x)){

                let resultSize : Nat = workspace.size();
                let targetZone = thisChunk.0 + 1;

                if(targetZone  <= resultSize){
                    //zone exist
                } else {
                    //append zone

                    for (thisIndex in Iter.range(resultSize, targetZone-1)){
                        workspace.add(Buffer.Buffer<DataChunk>(1));
                    };

                };

                let thisZone = workspace.get(thisChunk.0);

                if(thisChunk.1 + 1  <= thisZone.size()){
                    //zone exists
                    thisZone.put(thisChunk.1, destabalizeValue(thisChunk.2));
                } else {
                    //append zone

                    for (newChunk in Iter.range(thisZone.size(), thisChunk.1)){

                        let newBuffer = if(thisChunk.1 == newChunk){
                        //we know the size

                            destabalizeValue(thisChunk.2);
                        } else {
                            #Empty;
                        };
                        thisZone.add(newBuffer);
                    };
                    //return thisZone.get(thisChunk.1);
                };


            };

            return ;
        };

        public func getDataZoneSize(dz: DataZone) : Nat {
            
            var size : Nat = 0;
            for(thisChunk in dz.vals()){
                size += getValueUnstableSize(thisChunk);
            };
            
            return size;
        };

        public func getWorkspaceChunkSize(_workspace: Workspace,  _maxChunkSize : Nat) : Nat{
            
            var currentChunk : Nat = 0;
            var handBrake = 0;
            var zoneTracker = 0;
            var chunkTracker = 0;


            label chunking while (1==1){
                handBrake += 1;
                if(handBrake > 10000){ break chunking;};
                var foundBytes = 0;
                //calc bytes
                for(thisZone in Iter.range(zoneTracker, _workspace.size()-1)){
                    for(thisChunk in Iter.range(chunkTracker, _workspace.get(thisZone).size()-1)){

                        let thisItem = _workspace.get(thisZone).get(thisChunk);

                        let newSize = foundBytes + getValueUnstableSize(thisItem);
                        
                        if( newSize > _maxChunkSize)
                        {
                            //went over bytes

                            currentChunk += 1;
                            zoneTracker := thisZone;
                            chunkTracker := thisChunk;

                            continue chunking;
                        };
                        //adding some bytes
                        foundBytes := newSize;
                    };
                };

            };

            currentChunk += 1;

            return currentChunk;


        };

        public func getWorkspaceChunk(_workspace: Workspace, _chunkID : Nat, _maxChunkSize : Nat) : ({#eof; #chunk} , AddressedChunkBuffer){
            var currentChunk : Nat = 0;
            var handBrake = 0;
            var zoneTracker = 0;
            var chunkTracker = 0;

            let resultBuffer = Buffer.Buffer<AddressedChunk>(1);
            label chunking while (1==1){
                handBrake += 1;
                if(handBrake > 10000){ break chunking;};
                var foundBytes = 0;
                //calc bytes
                for(thisZone in Iter.range(zoneTracker, _workspace.size()-1)){
                    for(thisChunk in Iter.range(chunkTracker, _workspace.get(thisZone).size()-1)){

                        let thisItem = _workspace.get(thisZone).get(thisChunk);

                        let newSize = foundBytes + getValueUnstableSize(thisItem);
                        if( newSize > _maxChunkSize)
                        {
                            //went over bytes
                            if(currentChunk == _chunkID){
                                return (#chunk, resultBuffer);
                            };
                            currentChunk += 1;
                            zoneTracker := thisZone;
                            chunkTracker := thisChunk;
                            continue chunking;
                        };
                        if(currentChunk == _chunkID){
                            //add it to our return
                            resultBuffer.add((thisZone, thisChunk, stabalizeValue(thisItem)));

                        };

                        foundBytes := newSize;
                    };
                };

                return (#eof, resultBuffer);
            };

            return (#eof, resultBuffer);
        };

        public func getAddressedChunkArraySize(item : AddressedChunkArray) : Nat{
            
            var size : Nat = 0;
            for(thisItem in item.vals()){
                size += getValueSize(thisItem.2) + 4 + 4; //only works for up to 32 byte adresess...should be fine but verify and document.
            };
            
            return size;
        };

        public func getDataChunkFromAddressedChunkArray(item : AddressedChunkArray, dataZone: Nat, dataChunk: Nat) : CandyValue{
            
            var size : Nat = 0;
            for(thisItem in item.vals()){
                if(thisItem.0 == dataZone and thisItem.1 == dataChunk){
                    return thisItem.2;
                }
            };
            return #Empty;
        };



        public func getClassProperty(val: CandyValue, name : Text) : Property{
            
            switch(val){
                case(#Class(val)){
                    for(thisItem in val.vals()){
                        if(thisItem.name == name){
                            return thisItem;
                        };
                    };
                    //couldnt find name in class
                    assert(false);
                    //unreachable
                    return {name=""; value=#Empty; immutable=true};

                };
                case(_){

                    assert(false);
                    //unreachable
                    return {name=""; value=#Empty; immutable=true};
                }

            };

        };

        public func byteBufferDataZoneToBuffer(dz : DataZone): Buffer.Buffer<Buffer.Buffer<Nat8>>{
            
            let result = Buffer.Buffer<Buffer.Buffer<Nat8>>(dz.size());
            for(thisItem in dz.vals()){
                result.add(valueUnstableToBytesBuffer(thisItem));
            };
            
            return result;
        };

        public func byteBufferChunksToValueUnstableBufferDataZone(buffer : Buffer.Buffer<Buffer.Buffer<Nat8>>): DataZone{
            
            let result = Buffer.Buffer<CandyValueUnstable>(buffer.size());
            for(thisItem in buffer.vals()){
                result.add(#Bytes(#thawed(thisItem)));
            };

            return result;
        };

        public func initDataZone(val : CandyValueUnstable) : DataZone{
            
            let result = Buffer.Buffer<CandyValueUnstable>(1);
            result.add(val);
            return result;
        };

        public func flattenAddressedChunkArray(data : AddressedChunkArray) : [Nat8]{
            //note loses integrity after 256 Zones or 256 chunks
            
            let accumulator : Buffer.Buffer<Nat8> = Buffer.Buffer<Nat8>(getAddressedChunkArraySize(data));
            for(thisItem in data.vals()){

                for(thisbyte in natToBytes(thisItem.0).vals()){
                    accumulator.add(thisbyte);
                };
                for(thisbyte in natToBytes(thisItem.1).vals()){
                    accumulator.add(thisbyte);
                };

                    for(thisbyte in valueToBytes(thisItem.2).vals()){
                        accumulator.add(thisbyte);
                    };

            };
            return accumulator.toArray();


        };

        ////////////////////////////////////
        //
        // The following functions were copied from departurelabs' property.mo.  They work as a plug and play
        // here with CandyValue and CandyValueUnstable.
        //
        // https://github.com/DepartureLabsIC/non-fungible-token/blob/main/src/property.mo
        //
        // The following lines are issued under the MIT License Copyright (c) 2021 Departure Labs:
        //
        ///////////////////////////////////

        private func toPropertyMap(ps : Properties) : HashMap.HashMap<Text,Property> {
            
            let m = HashMap.HashMap<Text,Property>(ps.size(), Text.equal, Text.hash);
            for (property in ps.vals()) {
                m.put(property.name, property);
            };
            m;
        };

        private func fromPropertyMap(m : HashMap.HashMap<Text,Property>) : Properties {
            
            var ps : Properties = [];
            for ((_, p) in m.entries()) {
                ps := Array.append(ps, [p]);
            };
            ps;
        };

        // Returns a subset of from properties based on the given query.
        // NOTE: ignores unknown properties.
        public func getProperties(properties : Properties, qs : [Query]) : Result.Result<Properties, PropertyError> {
            let m               = toPropertyMap(properties);
            var ps : Properties = [];
            for (q in qs.vals()) {
                switch (m.get(q.name)) {
                    case (null) {
                        // Query contained an unknown property.
                        return #err(#NotFound);
                    };
                    case (? p)  {
                        switch (p.value) {
                            case (#Class(c)) {
                                if (q.next.size() == 0) {
                                    // Return every sub-attribute attribute.
                                    ps := Array.append(ps, [p]);
                                } else {
                                    let sps = switch (getProperties(c, q.next)) {
                                        case (#err(e)) { return #err(e); };
                                        case (#ok(v))  { v; };
                                    };
                                    
                                    ps := Array.append(ps, [{
                                        name      = p.name;
                                        value     = #Class(sps);
                                        immutable = p.immutable;
                                    }]);
                                };
                            };
                            case (other) {
                                // Not possible to get sub-attribute of a non-class property.
                                if (q.next.size() != 0) {
                                    return #err(#NotFound);
                                };
                                ps := Array.append(ps, [p]);
                            };
                        }
                    };
                };
            };
            #ok(ps);
        };

        // Updates the given properties based on the given update query.
        // NOTE: creates unknown properties.
        public func updateProperties(properties : Properties, us : [Update]) : Result.Result<Properties, PropertyError> {
            let m = toPropertyMap(properties);
            for (u in us.vals()) {
                switch (m.get(u.name)) {
                    case (null) {
                        // Update contained an unknown property, so it gets created.
                        switch (u.mode) {
                            case (#Next(sus)) {
                                let sps = switch(updateProperties([], sus)) {
                                    case (#err(e)) { return #err(e); };
                                    case (#ok(v))  { v; };
                                };
                                
                                m.put(u.name, {
                                    name      = u.name;
                                    value     = #Class(sps);
                                    immutable = false;
                                });
                            };
                            case (#Set(v)) {
                                m.put(u.name, {
                                    name      = u.name;
                                    value     = v;
                                    immutable = false;
                                });
                            };
                        };
                    };
                    case (? p)  {
                        // Can not update immutable property.
                        if (p.immutable) {
                            return #err(#Immutable);
                        };
                        switch (u.mode) {
                            case (#Next(sus)) {
                                switch (p.value) {
                                    case (#Class(c)) {
                                        let sps = switch(updateProperties(c, sus)) {
                                            case (#err(e)) { return #err(e); };
                                            case (#ok(v))  { v; };
                                        };
                                        
                                        m.put(u.name, {
                                            name      = p.name;
                                            value     = #Class(sps);
                                            immutable = false;
                                        });
                                    };
                                    case (other) {
                                        // Not possible to update sub-attribute of a non-class property.
                                        return #err(#NotFound);
                                    };
                                };
                                return #err(#NotFound);
                            };
                            case (#Set(v)) {
                                m.put(u.name, {
                                    name      = p.name;
                                    value     = v;
                                    immutable = false;
                                });
                            };
                        };
                    };
                };
            };
            
            #ok(fromPropertyMap(m));
        };

        ////////////////////////////////////
        //
        // End code from Departure labs property.mo
        //
        ///////////////////////////////////
    };


};
