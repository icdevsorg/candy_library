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

module {

        type CandyValue = Types.CandyValue;
        type CandyValueUnstable = Types.CandyValueUnstable;
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
                            var size = 0;
                            for(thisItem in val.vals()){
                                size += 1 + getValueSize(#Nat(thisItem));
                            };
                            
                            return size;
                        };
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
                case(#Principal(val)){Conversion.principalToBytes(val).size()};//don't like this but need to confirm it is constant
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
                case(#Nats(val)){
                    switch(val){
                        case(#frozen(val)){
                            var size = 0;
                            for(thisItem in val.vals()){
                                size += 1 + getValueUnstableSize(#Nat(thisItem));
                            };
                            
                            return size;
                        };
                        case(#thawed(val)){
                            var size = 0;
                            for(thisItem in val.vals()){
                                size += 1 + getValueUnstableSize(#Nat(thisItem));
                            };
                            
                            return size;
                        };
                    };
                };
                case(#Empty){0};
            };
            return varSize + 2;
        };



        public func workspaceToAddressedChunkArray(x : Workspace) : AddressedChunkArray {
            
            var currentZone = 0;
            var currentChunk = 0;
            let result = Array.tabulate<AddressedChunk>(countAddressedChunksInWorkspace(x), func(thisChunk){
                let thisChunk = (currentZone, currentChunk, Types.stabalizeValue(x.get(currentZone).get(currentChunk)));
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
                    tz.add(Clone.cloneValueUnstable(thisDataChunk));
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
                    thisZone.put(thisChunk.1, Types.destabalizeValue(thisChunk.2));
                } else {
                    //append zone

                    for (newChunk in Iter.range(thisZone.size(), thisChunk.1)){

                        let newBuffer = if(thisChunk.1 == newChunk){
                        //we know the size

                            Types.destabalizeValue(thisChunk.2);
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
                            resultBuffer.add((thisZone, thisChunk, Types.stabalizeValue(thisItem)));

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



        public func byteBufferDataZoneToBuffer(dz : DataZone): Buffer.Buffer<Buffer.Buffer<Nat8>>{
            
            let result = Buffer.Buffer<Buffer.Buffer<Nat8>>(dz.size());
            for(thisItem in dz.vals()){
                result.add(Conversion.valueUnstableToBytesBuffer(thisItem));
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