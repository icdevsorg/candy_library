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
import Buffer "mo:base/Buffer";

import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Types "types";
import Conversion "conversion";
import Clone "clone";
import RB "mo:map/Map";
import SB "mo:stablebuffer/StableBuffer";

module {

        type CandyValue = Types.CandyValue;
        
        type Workspace = Types.Workspace;
        type DataZone = Types.DataZone;
        type AddressedChunkArray = Types.AddressedChunkArray;
        type AddressedChunk = Types.AddressedChunk;
        type AddressedChunkBuffer = Types.AddressedChunkBuffer;
        type DataChunk = Types.DataChunk;

        

        //////////////////////////////////////////////////////////////////////
        // The following functions enable the inspection and manipulation of workspaces
        // Workspaces are valueble when using orthogonal persistance to keep track of data
        // in a format that is easily transmitable across the wire given IC restrictions
        //////////////////////////////////////////////////////////////////////

        public func countAddressedChunksInWorkspace(x : Workspace) : Nat{
            
            var chunks = 0;
            for (thisZone in Iter.range(0, SB.size(x) - 1)){
                chunks += SB.size(SB.get<DataZone>(x, thisZone));
            };
            chunks;

        };

        public func emptyWorkspace() : Workspace {
            
            return SB.initPresized<DataZone>(1);
        };

        public func initWorkspace(size : Nat) : Workspace {
            
            return SB.initPresized<DataZone>(size);
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
                case(#Principal(val)){Conversion.principalToBytes(val).size()};//don't like this but need to confirm it is constant
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
                            //todo: add size from metadata
                            var size = 0;
                            for(thisItem in SB.vals(val)){
                                size += 1 + getValueSize(thisItem);
                            };
                            
                            return size;
                        };
                    };
                };
                case(#Bytes(val)){
                    switch(val){
                        case(#frozen(val)){val.size() + 2};
                        case(#thawed(val)){
                            //todo: add size from metadata
                            SB.size(val) + 2};
                    };
                };
                case(#Floats(val)){
                    switch(val){
                        case(#frozen(val)){(val.size() * 4) + 2};
                        case(#thawed(val)){
                            //todo: add size from metadata
                            (SB.size(val) * 4) + 2};
                    };
                };
                case(#Nats(val)){
                    switch(val){
                        case(#frozen(val)){
                            var size = 0;
                            for(thisItem in val.vals()){
                                size += 1 + getValueSize(#Nat(thisItem));
                            };
                            
                            return size;
                        };
                        case(#thawed(val)){
                            //todo: add size from metadata
                            var size = 0;
                            for(thisItem in SB.vals(val)){
                                size += 1 + getValueSize(#Nat(thisItem));
                            };
                            
                            return size;
                        };
                    };
                };
                case(#Dictionary(val)){
                    //todo: add size from metadata and pointers
                    var size = 0;
                    for(thisItem in RB.entries<CandyValue,CandyValue>(val)){
                        size += getValueSize(thisItem.0) + getValueSize(thisItem.1);
                    };
                    return size;
                };
                case(#Empty){0};
            };

            return varSize;
        };

        



        public func workspaceToAddressedChunkArray(x : Workspace) : AddressedChunkArray {
            
            var currentZone = 0;
            var currentChunk = 0;
            let result = Array.tabulate<AddressedChunk>(countAddressedChunksInWorkspace(x), func(thisChunk){
                let thisChunk = (currentZone, currentChunk, SB.get(SB.get(x, currentZone),currentChunk));
                 if(currentChunk == Nat.sub(SB.size(SB.get(x, currentZone)),1)){
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
            let ws = SB.initPresized<DataZone>(SB.size(x));
            for(thisZone in SB.vals(x)){

                let tz = SB.initPresized<DataChunk>(SB.size(thisZone));
                SB.add<DataZone>(ws,tz);
                for(thisDataChunk in SB.vals(thisZone)){
                    SB.add(tz, Clone.clone(thisDataChunk));
                };
                
            };
            return ws;
        };

        public func fromAddressedChunks(x : AddressedChunkArray) : Workspace {
            let result = SB.initPresized<DataZone>(x.size());
            fileAddressedChunks(result, x);
            return result;
        };

        public func fileAddressedChunks(workspace: Workspace, x : AddressedChunkArray) {
            
            for (thisChunk : AddressedChunk in Array.vals<AddressedChunk>(x)){

                let resultSize : Nat = SB.size(workspace);
                let targetZone = thisChunk.0 + 1;

                if(targetZone  <= resultSize){
                    //zone exist
                } else {
                    //append zone

                    for (thisIndex in Iter.range(resultSize, targetZone-1)){
                        SB.add(workspace, SB.initPresized<DataChunk>(1));
                    };

                };

                let thisZone = SB.get(workspace,thisChunk.0);

                if(thisChunk.1 + 1  <= SB.size(thisZone)){
                    //zone exists
                    SB.put(thisZone, thisChunk.1, thisChunk.2);
                } else {
                    //append zone

                    for (newChunk in Iter.range(SB.size(thisZone), thisChunk.1)){

                        let newBuffer = if(thisChunk.1 == newChunk){
                        //we know the size

                            thisChunk.2;
                        } else {
                            #Empty;
                        };
                        SB.add(thisZone,newBuffer);
                    };
                    //return thisZone.get(thisChunk.1);
                };


            };

            return ;
        };

        public func getDataZoneSize(dz: DataZone) : Nat {
            
            var size : Nat = 0;
            for(thisChunk in SB.vals(dz)){
                size += getValueSize(thisChunk);
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
                for(thisZone in Iter.range(zoneTracker, SB.size(_workspace)-1)){
                    for(thisChunk in Iter.range(chunkTracker, SB.size(SB.get(_workspace, thisZone)) - 1)){

                        let thisItem = SB.get(SB.get(_workspace,thisZone), thisChunk);

                        let newSize = foundBytes + getValueSize(thisItem);
                        
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

            let resultBuffer = SB.initPresized<AddressedChunk>(1);
            label chunking while (1==1){
                handBrake += 1;
                if(handBrake > 10000){ break chunking;};
                var foundBytes = 0;
                //calc bytes
                for(thisZone in Iter.range(zoneTracker, SB.size(_workspace)-1)){
                    for(thisChunk in Iter.range(chunkTracker, SB.size(SB.get(_workspace ,thisZone)) - 1)){

                        let thisItem = SB.get(SB.get(_workspace, thisZone), thisChunk);

                        let newSize = foundBytes + getValueSize(thisItem);
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
                            SB.add(resultBuffer, (thisZone, thisChunk, thisItem));

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



        public func byteBufferDataZoneToBuffer(dz : DataZone): SB.StableBuffer<SB.StableBuffer<Nat8>>{
            
            let result = SB.initPresized<SB.StableBuffer<Nat8>>(SB.size(dz));
            for(thisItem in SB.vals(dz)){
                SB.add(result, Conversion.valueToBytesBuffer(thisItem));
            };
            
            return result;
        };

        public func byteBufferChunksToValueUnstableBufferDataZone(buffer : SB.StableBuffer<SB.StableBuffer<Nat8>>): DataZone{
            
            let result = SB.initPresized<CandyValue>(SB.size(buffer));
            for(thisItem in SB.vals(buffer)){
                SB.add(result, #Bytes(#thawed(thisItem)));
            };

            return result;
        };

        public func initDataZone(val : CandyValue) : DataZone{
            
            let result = SB.initPresized<CandyValue>(1);
            SB.add(result, val);
            return result;
        };

        public func flattenAddressedChunkArray(data : AddressedChunkArray) : [Nat8]{
            //note loses integrity after 256 Zones or 256 chunks
            
            let accumulator : Buffer.Buffer<Nat8> = Buffer.Buffer<Nat8>(getAddressedChunkArraySize(data));
            for(thisItem in data.vals()){

                for(thisbyte in Conversion.natToBytes(thisItem.0).vals()){
                    accumulator.add(thisbyte);
                };
                for(thisbyte in Conversion.natToBytes(thisItem.1).vals()){
                    accumulator.add(thisbyte);
                };

                    for(thisbyte in Conversion.valueToBytes(thisItem.2).vals()){
                        accumulator.add(thisbyte);
                    };

            };
            return accumulator.toArray();


        };


}