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

/// Workspace for the candy library.
///
/// This module contains the utilities useful for keeping workable data in 
/// chunks that can be moved around canisters.

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import StableBuffer "mo:stable_buffer/StableBuffer";
import Map "mo:Map/Map";
import Set "mo:Map/Set";

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
    for (thisZone in Iter.range(0, StableBuffer.size(x) - 1)){
      chunks += StableBuffer.size(StableBuffer.get(x,thisZone));
    };
    chunks;

  };

  public func emptyWorkspace() : Workspace {
    
    return StableBuffer.init<DataZone>();
  };

  public func initWorkspace(size : Nat) : Workspace {
    
    return StableBuffer.initPresized<DataZone>(size);
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
       
            var size = 0;
            for(thisItem in val.vals()){
              size += 1 + getValueSize(thisItem);
            };
            
            return size;
          
      };
      case(#Bytes(val)){
        val.size() + 2
      };
      case(#Floats(val)){
        (val.size() * 4) + 2
      };
      case(#Nats(val)){
            var size = 0;
            for(thisItem in val.vals()){
              size += 1 + getValueSize(#Nat(thisItem));
            };
            
            return size;
      };
      case(#Map(val)){
        var size = 0;
        for(thisItem in val.vals()){
          size += getValueSize(thisItem.0) + getValueSize(thisItem.1) + 2;
        };
        
        return size;
          
      };
      case(#Set(val)){
        var size = 0;
        for(thisItem in val.vals()){
          size += getValueSize(thisItem) + 2;
        };
        return size;  
      };
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
        
        var size = 0;
        for(thisItem in StableBuffer.vals(val)){
          size += 1 + getValueUnstableSize(thisItem);
        };
        
        return size;
          
      };
      case(#Bytes(val)){
        StableBuffer.size(val) + 2;
      };
      case(#Floats(val)){
        (StableBuffer.size(val) * 4) + 2;
      };
      case(#Nats(val)){
        var size = 0;
        for(thisItem in StableBuffer.vals(val)){
          size += 1 + getValueUnstableSize(#Nat(thisItem));
        };
        return size;
      };
      case(#Map(val)){
        var size = 0;
        for(thisItem in Map.entries<CandyValueUnstable, CandyValueUnstable>(val)){
          size += getValueUnstableSize(thisItem.0) + getValueUnstableSize(thisItem.1) + 2;
        };
        
        return size;
          
      };
      case(#Set(val)){
        var size = 0;
        for(thisItem in Set.keys<CandyValueUnstable>(val)){
          size += getValueUnstableSize(thisItem) + 2;
        };
        return size;  
      };
    };
    return varSize + 2;
  };



  public func workspaceToAddressedChunkArray(x : Workspace) : AddressedChunkArray {
    
    var currentZone = 0;
    var currentChunk = 0;
    let result = Array.tabulate<AddressedChunk>(countAddressedChunksInWorkspace(x), func(thisChunk){
      let thisChunk = (currentZone, currentChunk, Types.stabalizeValue(StableBuffer.get(StableBuffer.get(x,currentZone),currentChunk)));
      if(currentChunk == Nat.sub(StableBuffer.size(StableBuffer.get(x, currentZone)),1)){
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
    let ws = StableBuffer.initPresized<DataZone>(StableBuffer.size(x));
    for(thisZone in StableBuffer.vals(x)){

      let tz = StableBuffer.initPresized<DataChunk>(StableBuffer.size(thisZone));
      StableBuffer.add<DataZone>(ws, tz);
      for(thisDataChunk in StableBuffer.vals(thisZone)){
        StableBuffer.add(tz,Clone.cloneValueUnstable(thisDataChunk));
      };
        
    };
    return ws;
  };

  public func fromAddressedChunks(x : AddressedChunkArray) : Workspace{
    let result = StableBuffer.initPresized<DataZone>(x.size());
    fileAddressedChunks(result, x);
    return result;
  };

  public func fileAddressedChunks(workspace: Workspace, x : AddressedChunkArray) {
    
    for (thisChunk : AddressedChunk in Array.vals<AddressedChunk>(x)){

      let resultSize : Nat = StableBuffer.size(workspace);
      let targetZone = thisChunk.0 + 1;

      if(targetZone  <= resultSize){
        //zone exist
      } else {
        //append zone

        for (thisIndex in Iter.range(resultSize, targetZone-1)){
          StableBuffer.add(workspace, StableBuffer.init<DataChunk>());
        };

      };

      let thisZone = StableBuffer.get(workspace,thisChunk.0);

      if(thisChunk.1 + 1  <= StableBuffer.size(thisZone)){
        //zone exists
        StableBuffer.put(thisZone, thisChunk.1, Types.destabalizeValue(thisChunk.2));
      } else {
        //append zone

        for (newChunk in Iter.range(StableBuffer.size(thisZone), thisChunk.1)){

          let newBuffer = if(thisChunk.1 == newChunk){
          //we know the size

            Types.destabalizeValue(thisChunk.2);
          } else {
            #Option(null);
          };
          StableBuffer.add(thisZone, newBuffer);
        };
        //return thisZone.get(thisChunk.1);
      };


    };

    return ;
  };

  public func getDataZoneSize(dz: DataZone) : Nat {
    
    var size : Nat = 0;
    for(thisChunk in StableBuffer.vals(dz)){
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
      for(thisZone in Iter.range(zoneTracker, StableBuffer.size(_workspace)-1)){
        for(thisChunk in Iter.range(chunkTracker, StableBuffer.size(StableBuffer.get(_workspace,thisZone))-1)){

          let thisItem = StableBuffer.get(StableBuffer.get(_workspace,thisZone),thisChunk);

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

    let resultBuffer = StableBuffer.init<AddressedChunk>();
    label chunking while (1==1){
      handBrake += 1;
      if(handBrake > 10000){ break chunking;};
      var foundBytes = 0;
      //calc bytes
      for(thisZone in Iter.range(zoneTracker, StableBuffer.size(_workspace)-1)){
          for(thisChunk in Iter.range(chunkTracker, StableBuffer.size(StableBuffer.get(_workspace, thisZone))-1)){

              let thisItem = StableBuffer.get(StableBuffer.get(_workspace, thisZone), thisChunk);

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
                  StableBuffer.add(resultBuffer, (thisZone, thisChunk, Types.stabalizeValue(thisItem)));

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
    return #Option(null);
  };



  public func byteBufferDataZoneToBuffer(dz : DataZone): Buffer.Buffer<Buffer.Buffer<Nat8>>{
    
    let result = Buffer.Buffer<Buffer.Buffer<Nat8>>(StableBuffer.size(dz));
    for(thisItem in StableBuffer.vals(dz)){
      result.add(Conversion.valueUnstableToBytesBuffer(thisItem));
    };
    
    return result;
  };

  public func byteBufferChunksToValueUnstableBufferDataZone(buffer : Buffer.Buffer<Buffer.Buffer<Nat8>>): DataZone {
    
    let result = StableBuffer.initPresized<CandyValueUnstable>(buffer.size());
    for(thisItem in buffer.vals()){
      StableBuffer.add(result, #Bytes(Types.toBuffer<Nat8>(thisItem.toArray())));
    };

    return result;
  };

  public func initDataZone(val : CandyValueUnstable) : DataZone{
    
    let result = StableBuffer.init<CandyValueUnstable>();
    StableBuffer.add(result, val);
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