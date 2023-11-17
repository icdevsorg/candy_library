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

/// Workspace utilities for the candy library.
///
/// This module contains the utilities useful for keeping workable data in
/// chunks that can be moved around canisters. They enable the inspection and
/// manipulation of workspaces.

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import StableBuffer "mo:stablebuffer_1_3_0/StableBuffer";
import Map "mo:map9/Map";
import Set "mo:map9/Set";

import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Types "types";
import Conversion "conversion";
import Clone "clone";

module {
  type CandyShared = Types.CandyShared;
  type Candy = Types.Candy;
  type Workspace = Types.Workspace;
  type DataZone = Types.DataZone;
  type AddressedChunkArray = Types.AddressedChunkArray;
  type AddressedChunk = Types.AddressedChunk;
  type AddressedChunkBuffer = Types.AddressedChunkBuffer;
  type DataChunk = Types.DataChunk;

  /// Get the count of addressed chunks in the given `Workspace`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let ws = Workspace.initWorkspace(3);
  /// StableBuffer.add<DataZone>(ws, StableBuffer.initPresized<DataChunk>(1));
  /// StableBuffer.add<DataZone>(ws, StableBuffer.initPresized<DataChunk>(5));
  /// StableBuffer.add<DataZone>(ws, StableBuffer.initPresized<DataChunk>(2));
  /// let count = Workspace.countAddressedChunksInWorkspace(ws); // 8.
  /// ```
  public func countAddressedChunksInWorkspace(x : Workspace) : Nat {
    var chunks = 0;
    for (thisZone in Iter.range(0, StableBuffer.size(x) - 1)) {
      chunks += StableBuffer.size(StableBuffer.get(x, thisZone));
    };
    chunks;
  };

  /// Create an empty `Workspace`.
  public func emptyWorkspace() : Workspace {
    return StableBuffer.init<DataZone>();
  };

  /// Initialize a `Workspace` with the given capacity.
  public func initWorkspace(size : Nat) : Workspace {
    return StableBuffer.initPresized<DataZone>(size);
  };

  /// Get the size in bytes taken up by the `Candy`.
  public func getCandySize(item : Candy) : Nat {
    let varSize = switch (item) {
      case (#Int(val)) {
        var a : Nat = 0;
        var b : Nat = Int.abs(val);
        var test = true;
        while test {
          a += 1;
          b := b / 256;
          test := b > 0;
        };
        a + 1; //add the sign
      };
      case (#Int8(val)) { 1 };
      case (#Int16(val)) { 2 };
      case (#Int32(val)) { 3 };
      case (#Int64(val)) { 4 };
      case (#Nat(val)) {
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
      case (#Nat8(val)) { 1 };
      case (#Nat16(val)) { 2 };
      case (#Nat32(val)) { 3 };
      case (#Nat64(val)) { 4 };
      case (#Float(val)) { 4 };
      case (#Text(val)) { (val.size() * 4) };
      case (#Bool(val)) { 1 };
      case (#Blob(val)) { val.size() };
      case (#Class(val)) {
        var size = 0;
        for (thisItem in Map.entries(val)) {
          size += 1 + (thisItem.1.name.size() * 4) + getCandySize(thisItem.1.value) + (thisItem.1.name.size() * 4); //name + name + value + bit
        };
        return size;
      };
      case (#Principal(val)) { Conversion.principalToBytes(val).size() }; //don't like this but need to confirm it is constant
      case (#Option(val)) {
        switch val {
          case (null) { 0 };
          case (?val) { getCandySize(val) };
        };
      };
      case (#Array(val)) {
        var size = 0;
        for (thisItem in StableBuffer.vals(val)) {
          size += 1 + getCandySize(thisItem);
        };
        return size;
      };
      case (#Bytes(val)) {
        StableBuffer.size(val) + 2;
      };
      case (#Floats(val)) {
        (StableBuffer.size(val) * 4) + 2;
      };
      case (#Nats(val)) {
        var size = 0;
        for (thisItem in StableBuffer.vals(val)) {
          size += 1 + getCandySize(#Nat(thisItem));
        };
        return size;
      };
      case (#Ints(val)) {
        var size = 0;
        for (thisItem in StableBuffer.vals(val)) {
          size += 1 + getCandySize(#Int(thisItem));
        };
        return size;
      };
      case (#ValueMap(val)) {
        var size = 0;
        for (thisItem in Map.entries(val)) {
          size += getCandySize(thisItem.0) + getCandySize(thisItem.1) + 2;
        };
        return size;
      };
      case (#Map(val)) {
        var size = 0;
        for (thisItem in Map.entries(val)) {
          size += (thisItem.0.size() * 4) + getCandySize(thisItem.1) + 2;
        };
        return size;
      };
      case (#Set(val)) {
        var size = 0;
        for (thisItem in Set.keys(val)) {
          size += getCandySize(thisItem) + 2;
        };
        return size;
      };
    };

    return varSize;
  };

  /// Get the size in bytes taken up by the `CandyShared`.
  public func getCandySharedSize(item : CandyShared) : Nat {
    let varSize = switch (item) {
      case (#Int(val)) {
        var a : Nat = 0;
        var b : Nat = Int.abs(val);
        var test = true;
        while test {
          a += 1;
          b := b / 256;
          test := b > 0;
        };
        a + 1; //add the sign
      };
      case (#Int8(val)) { 1 };
      case (#Int16(val)) { 2 };
      case (#Int32(val)) { 3 };
      case (#Int64(val)) { 4 };
      case (#Nat(val)) {
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
      case (#Nat8(val)) { 1 };
      case (#Nat16(val)) { 2 };
      case (#Nat32(val)) { 3 };
      case (#Nat64(val)) { 4 };
      case (#Float(val)) { 4 };
      case (#Text(val)) { val.size() * 4 };
      case (#Bool(val)) { 1 };
      case (#Blob(val)) { val.size() };
      case (#Class(val)) {
        var size = 0;
        for (thisItem in val.vals()) {
          size += 1 + (thisItem.name.size() * 4) + getCandySharedSize(thisItem.value);
        };

        return size;
      };
      case (#Principal(val)) { Conversion.principalToBytes(val).size() }; //don't like this but need to confirm it is constant
      case (#Option(val)) {
        switch val {
          case (null) { 0 };
          case (?val) { getCandySharedSize(val) };
        };
      };
      case (#Array(val)) {

        var size = 0;
        for (thisItem in val.vals()) {
          size += 1 + getCandySharedSize(thisItem);
        };

        return size;

      };
      case (#Bytes(val)) {
        val.size() + 2;
      };
      case (#Floats(val)) {
        (val.size() * 4) + 2;
      };
      case (#Nats(val)) {
        var size = 0;
        for (thisItem in val.vals()) {
          size += 1 + getCandySharedSize(#Nat(thisItem));
        };
        return size;
      };
      case (#Ints(val)) {
        var size = 0;
        for (thisItem in val.vals()) {
          size += 1 + getCandySharedSize(#Int(thisItem));
        };
        return size;
      };
      case (#ValueMap(val)) {
        var size = 0;
        for (thisItem in val.vals()) {
          size += getCandySharedSize(thisItem.0) + getCandySharedSize(thisItem.1) + 2;
        };

        return size;

      };
      case (#Map(val)) {
        var size = 0;
        for (thisItem in val.vals()) {
          size += (thisItem.0.size() *4) + getCandySharedSize(thisItem.1) + 2;
        };

        return size;

      };
      case (#Set(val)) {
        var size = 0;
        for (thisItem in val.vals()) {
          size += getCandySharedSize(thisItem) + 2;
        };
        return size;
      };
    };
    return varSize + 2;
  };

  /// Convert `Workspace` to `AddressedChunkArray`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let ws = Workspace.initWorkspace(3);
  /// StableBuffer.add<DataZone>(ws, StableBuffer.initPresized<DataChunk>(1));
  /// StableBuffer.add<DataZone>(ws, StableBuffer.initPresized<DataChunk>(5));
  /// StableBuffer.add<DataZone>(ws, StableBuffer.initPresized<DataChunk>(2));
  /// let addressed_chunk_array = Workspace.workspaceToAddressedChunkArray(ws);
  /// ```
  public func workspaceToAddressedChunkArray(x : Workspace) : AddressedChunkArray {
    var currentZone = 0;
    var currentChunk = 0;
    let result = Array.tabulate<AddressedChunk>(
      countAddressedChunksInWorkspace(x),
      func(thisChunk) {
        let thisChunk = (currentZone, currentChunk, Types.shareCandy(StableBuffer.get(StableBuffer.get(x, currentZone), currentChunk)));
        if (currentChunk == Nat.sub(StableBuffer.size(StableBuffer.get(x, currentZone)), 1)) {
          currentZone += 1;
          currentChunk := 0;
        } else {
          currentChunk += 1;
        };
        thisChunk;
      },
    );
    return result;
  };

  /// Get a deep clone of the given `Workspace`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let ws = Workspace.initWorkspace(3);
  /// StableBuffer.add<DataZone>(ws, StableBuffer.initPresized<DataChunk>(1));
  /// StableBuffer.add<DataZone>(ws, StableBuffer.initPresized<DataChunk>(5));
  /// StableBuffer.add<DataZone>(ws, StableBuffer.initPresized<DataChunk>(2));
  /// let ws_clone = Workspace.workspaceDeepClone(ws);
  /// ```
  public func workspaceDeepClone(x : Workspace) : Workspace {
    var currentZone = 0;
    var currentChunk = 0;
    let ws = StableBuffer.initPresized<DataZone>(StableBuffer.size(x));
    for (thisZone in StableBuffer.vals(x)) {
      let tz = StableBuffer.initPresized<DataChunk>(StableBuffer.size(thisZone));
      StableBuffer.add<DataZone>(ws, tz);
      for (thisDataChunk in StableBuffer.vals(thisZone)) {
        StableBuffer.add(tz, Clone.cloneCandy(thisDataChunk));
      };
    };
    return ws;
  };

  /// Create a `Workspace` from an `AddressedChunkArray`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let arr: AddressedChunkArray = [(1, 1, #Nat(10)), (8, 4, #Float(3.14))];
  /// let ws = Workspace.fromAddressedChunks(arr);
  /// ```
  public func fromAddressedChunks(x : AddressedChunkArray) : Workspace {
    let result = StableBuffer.initPresized<DataZone>(x.size());
    fileAddressedChunks(result, x);
    return result;
  };

  public func fileAddressedChunks(workspace : Workspace, x : AddressedChunkArray) {
    for (thisChunk : AddressedChunk in Array.vals<AddressedChunk>(x)) {
      let resultSize : Nat = StableBuffer.size(workspace);
      let targetZone = thisChunk.0 + 1;

      if (targetZone <= resultSize) {
        //zone exist
      } else {
        //append zone
        for (thisIndex in Iter.range(resultSize, targetZone -1)) {
          StableBuffer.add(workspace, StableBuffer.init<DataChunk>());
        };
      };

      let thisZone = StableBuffer.get(workspace, thisChunk.0);
      if (thisChunk.1 + 1 <= StableBuffer.size(thisZone)) {
        //zone exists
        StableBuffer.put(thisZone, thisChunk.1, Types.unshare(thisChunk.2));
      } else {
        //append zone
        for (newChunk in Iter.range(StableBuffer.size(thisZone), thisChunk.1)) {
          let newBuffer = if (thisChunk.1 == newChunk) {
            //we know the size
            Types.unshare(thisChunk.2);
          } else {
            #Option(null);
          };
          StableBuffer.add(thisZone, newBuffer);
        };
        //return thisZone.get(thisChunk.1);
      };
    };
    return;
  };

  /// Get the size in bytes taken up by all values in the `DataZone`.
  public func getDataZoneSize(dz : DataZone) : Nat {
    var size : Nat = 0;
    for (thisChunk in StableBuffer.vals(dz)) {
      size += getCandySize(thisChunk);
    };
    return size;
  };

  /// Get the number of chunks for `Workspace` when dividing into chunks of size <= _maxChunkSize .
  ///
  /// Example:
  /// ```motoko include=import
  /// let ws = Workspace.initWorkspace(3);
  /// StableBuffer.add<DataZone>(ws, StableBuffer.initPresized<DataChunk>(1));
  /// StableBuffer.add<DataZone>(ws, StableBuffer.initPresized<DataChunk>(5));
  /// StableBuffer.add<DataZone>(ws, StableBuffer.initPresized<DataChunk>(2));
  /// let chunk_size = Workspace.getWorkspaceChunkSize(ws, 2);
  /// ```
  public func getWorkspaceChunkSize(_workspace : Workspace, _maxChunkSize : Nat) : Nat {
    var currentChunk : Nat = 0;
    var handBrake = 0;
    var zoneTracker = 0;
    var chunkTracker = 0;

    label chunking while (1 == 1) {
      handBrake += 1;
      if (handBrake > 10000) { break chunking };
      var foundBytes = 0;
      //calc bytes
      for (thisZone in Iter.range(zoneTracker, StableBuffer.size(_workspace) -1)) {
        for (thisChunk in Iter.range(chunkTracker, StableBuffer.size(StableBuffer.get(_workspace, thisZone)) -1)) {
          let thisItem = StableBuffer.get(StableBuffer.get(_workspace, thisZone), thisChunk);
          let newSize = foundBytes + getCandySize(thisItem);
          if (newSize > _maxChunkSize) {
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

  public func getWorkspaceChunk(_workspace : Workspace, _chunkID : Nat, _maxChunkSize : Nat) : ({ #eof; #chunk }, AddressedChunkBuffer) {
    var currentChunk : Nat = 0;
    var handBrake = 0;
    var zoneTracker = 0;
    var chunkTracker = 0;

    let resultBuffer = StableBuffer.init<AddressedChunk>();
    label chunking while (1 == 1) {
      handBrake += 1;
      if (handBrake > 10000) { break chunking };
      var foundBytes = 0;
      //calc bytes
      for (thisZone in Iter.range(zoneTracker, StableBuffer.size(_workspace) -1)) {
        for (thisChunk in Iter.range(chunkTracker, StableBuffer.size(StableBuffer.get(_workspace, thisZone)) -1)) {
          let thisItem = StableBuffer.get(StableBuffer.get(_workspace, thisZone), thisChunk);

          let newSize = foundBytes + getCandySize(thisItem);
          if (newSize > _maxChunkSize) {
            //went over bytes
            if (currentChunk == _chunkID) {
              return (#chunk, resultBuffer);
            };
            currentChunk += 1;
            zoneTracker := thisZone;
            chunkTracker := thisChunk;
            continue chunking;
          };
          if (currentChunk == _chunkID) {
            //add it to our return
            StableBuffer.add(resultBuffer, (thisZone, thisChunk, Types.shareCandy(thisItem)));
          };

          foundBytes := newSize;
        };
      };
      return (#eof, resultBuffer);
    };
    return (#eof, resultBuffer);
  };

  /// Get the size of the `AddressedChunkArray`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let arr: AddressedChunkArray = [(1, 1, #Nat(10)), (8, 4, #Float(3.14))];
  /// let size = Workspace.getAddressedChunkArraySize(arr); // 21
  /// ```
  /// Note: This only works for up to 32 bytes addresses.
  public func getAddressedChunkArraySize(item : AddressedChunkArray) : Nat {
    var size : Nat = 0;
    for (thisItem in item.vals()) {
      size += getCandySharedSize(thisItem.2) + 4 + 4; //only works for up to 32 byte adresess...should be fine but verify and document.
    };
    return size;
  };

  /// Get the data chunk from a `AddressedChunkArray` at the given zone and chunk.
  ///
  /// Example:
  /// ```motoko include=import
  /// let arr: AddressedChunkArray = [(1, 1, #Nat(10)), (8, 4, #Float(3.14))];
  /// let chunk = Workspace.getDataChunkFromAddressedChunkArray(arr, 8, 4); // #Float(3.14)
  /// ```
  public func getDataChunkFromAddressedChunkArray(item : AddressedChunkArray, dataZone : Nat, dataChunk : Nat) : CandyShared {
    for (thisItem in item.vals()) {
      if (thisItem.0 == dataZone and thisItem.1 == dataChunk) {
        return thisItem.2;
      };
    };
    return #Option(null);
  };

  /// Convert the `DataZone` into a `Buffer<Buffer<Nat8>>`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let dz = Workspace.initDataZone(#Nat(24));
  /// let buff = Workspace.byteBufferDataZoneToBuffer(dz);
  /// ```
  public func byteBufferDataZoneToBuffer(dz : DataZone) : Buffer.Buffer<Buffer.Buffer<Nat8>> {
    let result = Buffer.Buffer<Buffer.Buffer<Nat8>>(StableBuffer.size(dz));
    for (thisItem in StableBuffer.vals(dz)) {
      result.add(Conversion.candyToBytesBuffer(thisItem));
    };
    return result;
  };

  public func byteBufferChunksToCandyBufferDataZone(buffer : Buffer.Buffer<Buffer.Buffer<Nat8>>) : DataZone {
    let result = StableBuffer.initPresized<Candy>(buffer.size());
    for (thisItem in buffer.vals()) {
      StableBuffer.add(result, #Bytes(Types.toBuffer<Nat8>(Buffer.toArray(thisItem))));
    };
    return result;
  };

  /// Initialize a `DataZone` with the given value.
  public func initDataZone(val : Candy) : DataZone {
    let result = StableBuffer.init<Candy>();
    StableBuffer.add(result, val);
    return result;
  };

  /// Flatten an `AddressedChunkArray` to produce `[Nat8]`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let arr: AddressedChunkArray = [(1, 1, #Nat(10)), (8, 4, #Float(3.14))];
  /// let bytes = Workspace.flattenAddressedChunkArray(arr);
  /// ```
  /// Note: Loses integrity after 256 Zones or 256 chunks.
  public func flattenAddressedChunkArray(data : AddressedChunkArray) : [Nat8] {
    let accumulator : Buffer.Buffer<Nat8> = Buffer.Buffer<Nat8>(getAddressedChunkArraySize(data));
    for (thisItem in data.vals()) {
      for (thisbyte in Conversion.natToBytes(thisItem.0).vals()) {
        accumulator.add(thisbyte);
      };
      for (thisbyte in Conversion.natToBytes(thisItem.1).vals()) {
        accumulator.add(thisbyte);
      };
      for (thisbyte in Conversion.candySharedToBytes(thisItem.2).vals()) {
        accumulator.add(thisbyte);
      };
    };
    return Buffer.toArray(accumulator);
  };
};
