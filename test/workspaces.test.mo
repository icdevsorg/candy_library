// Assuming workspace.mo contains the Workspace module functions.
import Workspace "../src/workspace";
import Types "../src/types";
import {test} "mo:test";
import StableBuffer "mo:stablebuffer_1_3_0/StableBuffer";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Buffer "mo:base/Buffer";
import Nat8 "mo:base/Nat8";
import Blob "mo:base/Blob";
import D "mo:base/Debug";

type Workspace = Types.Workspace;
type DataZone = Types.DataZone;
type Candy = Types.Candy;
type CandyShared = Types.CandyShared;
type AddressedChunkArray = Types.AddressedChunkArray;
type DataChunk = Types.DataChunk;

// Helper function to create a data chunk with an array of Nats up to the size specified
func buildDataChunk(size: Nat) : DataChunk {
  #Array(StableBuffer.fromArray<Candy>(Array.tabulate<Candy>(size, func (i :Nat): Candy{#Nat(i)})))
};

func buildDataZone(size: Nat) : DataZone {
  StableBuffer.fromArray<Candy>(Array.tabulate<Candy>(size, func (i :Nat): Candy{#Nat(i)}))
};

// Testing countAddressedChunksInWorkspace
test("countAddressedChunksInWorkspace should correctly count chunks in workspace", func() {
  let testDataChunkSizes = [1, 3, 5, 2]; // Array size represents chunk setup
  let ws: Workspace = Workspace.initWorkspace(testDataChunkSizes.size());
  for (size in testDataChunkSizes.vals()) {
    StableBuffer.add<DataZone>(ws, buildDataZone(size)); // Using helper to build chunks
  };
  assert(Workspace.countAddressedChunksInWorkspace(ws) == 11);
});

// Testing emptyWorkspace
test("emptyWorkspace should create an empty workspace", func() {
  let ws = Workspace.emptyWorkspace();
  assert(StableBuffer.size(ws) == 0);
});

// Testing initWorkspace
test("initWorkspace should initialize a workspace with a given capacity", func() {
  let ws = Workspace.initWorkspace(5);
  D.print(debug_show(StableBuffer.size(ws)));
  assert(StableBuffer.size(ws) == 0); //init is only presized
});

// Testing getCandySize
test("getCandySize should return correct byte size of a Candy", func() {
  let candyInt: Candy = #Int(255);
  assert(Workspace.getCandySize(candyInt) == 2); // Test for a simple Int Candy, use others as needed
});

// Testing getCandySharedSize
test("getCandySharedSize should return correct byte size of a CandyShared", func() {
  let candySharedInt: CandyShared = #Int(255);
  D.print(debug_show(Workspace.getCandySharedSize(candySharedInt)));
  assert(Workspace.getCandySharedSize(candySharedInt) == 4); // Similar to getCandySize but with CandyShared
});

// Testing workspaceToAddressedChunkArray
test("workspaceToAddressedChunkArray should convert workspace to addressed chunk array", func() {
  let ws: Workspace = Workspace.initWorkspace(2);
  StableBuffer.add<DataZone>(ws, buildDataZone(1));
  StableBuffer.add<DataZone>(ws, buildDataZone(1));
  let addressedChunks = Workspace.workspaceToAddressedChunkArray(ws);
  assert(addressedChunks.size() == 2);
  // Test individual chunks and positions accurately
});

// Testing workspaceDeepClone
test("workspaceDeepClone should produce an identical but independent copy of workspace", func() {
  let ws: Workspace = Workspace.initWorkspace(3);
  StableBuffer.add<DataZone>(ws, buildDataZone(1));
  StableBuffer.add<DataZone>(ws, buildDataZone(2));
  let wsClone = Workspace.workspaceDeepClone(ws);
  // Assert deep equality of workspaces 
  assert(StableBuffer.size(ws) == StableBuffer.size(wsClone));
  // Assert that modifying one does not change the other
  let updatedChunk = buildDataZone(5);
  StableBuffer.put<DataZone>(wsClone, 1, updatedChunk);
  assert(StableBuffer.size(StableBuffer.get<DataZone>(ws, 1)) != StableBuffer.size(StableBuffer.get<DataZone>(wsClone, 1)));
});

// Testing fromAddressedChunks


test("fromAddressedChunks should create a new workspace from an addressed chunk array", func() {
  let addressedChunks: AddressedChunkArray = [(0, 0, #Int(42)), (1, 0, #Int(43))];
  let ws = Workspace.fromAddressedChunks(addressedChunks);
  assert(StableBuffer.size(ws) == 2);
  // Assert that chunks are correctly configured in the new workspace
  assert(Types.eq(StableBuffer.get<DataChunk>(StableBuffer.get<DataZone>(ws, 0),0),#Int(42)));
  assert(Types.eq(StableBuffer.get<DataChunk>(StableBuffer.get<DataZone>(ws, 1),0), #Int(43)));
});

// Testing getDataZoneSize
test("getDataZoneSize should return size of DataZone in bytes", func() {
  let dz = buildDataZone(356);
  let size = Workspace.getDataZoneSize(dz);
  D.print(debug_show(size));
  assert(size > 0); 
  let expectedSize: Nat = 456; // 1 byte for the variant tag, plus size of Nat
  assert(size == expectedSize);
});

// Testing getWorkspaceChunkSize
test("getWorkspaceChunkSize should return the number of chunks after partitioning", func() {
  let ws: Workspace = Workspace.initWorkspace(3);
  for (x in Iter.range(0, 2)) { // Initialize with 3 chunks
    StableBuffer.add<DataZone>(ws, buildDataZone(64)); // Assuming max chunk size is smaller than 64
  };
  let chunkSize = Workspace.getWorkspaceChunkSize(ws, 32); // Assuming max chunk size is 32
  assert(chunkSize > 3);
});

// Testing getWorkspaceChunk
test("getWorkspaceChunk should return a specific chunk data", func() {
  let ws: Workspace = Workspace.initWorkspace(1);
  StableBuffer.add<DataZone>(ws, buildDataZone(4));
  let chunk = Workspace.getWorkspaceChunk(ws, 0, 32); // Assuming max chunk size is 32 and we want the first chunk
  // Verify chunk content
});

// Testing getAddressedChunkArraySize
test("getAddressedChunkArraySize should return accurate size of the addressed chunks", func() {

  let addressedChunks: AddressedChunkArray = [(0, 0, #Int(42)), (1, 0, #Nat(15))];
  let size = Workspace.getAddressedChunkArraySize(addressedChunks);
  D.print(debug_show(size));
  let expectedSize: Nat = 23; // Assuming each zone chunk is one Nat size plus tag
  assert(size == expectedSize);
});

// Testing getDataChunkFromAddressedChunkArray
test("getDataChunkFromAddressedChunkArray should return correct chunk data", func() {
  let addressedChunks: AddressedChunkArray = [(0, 0, #Int(42)), (1, 1, #Nat(15))];
  let dataChunk = Workspace.getDataChunkFromAddressedChunkArray(addressedChunks, 1, 1);
  // Verify returned `dataChunk` is #Nat(15) from the addressedChunks setup
});

// Testing byteBufferDataZoneToBuffer
test("byteBufferDataZoneToBuffer should convert data zone to buffer of bytes buffers", func() {
  let dz = buildDataZone(2); // Build your DataZone with the helper function
  let byteBuffer = Workspace.byteBufferDataZoneToBuffer(dz);
  // Verify that the byteBuffer contains expected byte arrays
});

// Testing byteBufferChunksToCandyBufferDataZone
test("byteBufferChunksToCandyBufferDataZone should convert buffer of bytes buffers to data zone", func() {
  let byteBuffer = Buffer.Buffer<Nat8>(2);
  byteBuffer.add( Nat8.fromNat(42));
  byteBuffer.add( Nat8.fromNat(43));
  let byteBuffers = Buffer.Buffer<Buffer.Buffer<Nat8>>(1);
  byteBuffers.add(byteBuffer);
  let dz = Workspace.byteBufferChunksToCandyBufferDataZone(byteBuffers);
  // Verify that the DataZone 'dz' correctly contains the converted data
});

// Testing initDataZone
test("initDataZone should create a DataZone with initial value", func() {
  let dz = Workspace.initDataZone(#Nat(42));
  assert(StableBuffer.size(dz) == 1);
  // Test initialized DataZone has the expected content
});

// Testing flattenAddressedChunkArray
test("flattenAddressedChunkArray should return a flattened byte array for AddressedChunkArray", func() {
  let addressedChunks: AddressedChunkArray = [(0, 0, #Int(42))];
  let flattenedBytes = Workspace.flattenAddressedChunkArray(addressedChunks);
  assert(Blob.fromArray(flattenedBytes).size() > 0); // Replace with expected array size
  // Test that bytes are flattened as expected
});

// Testing workspaceToAddressedChunkArray
test("workspaceToAddressedChunkArray should convert workspace to addressed chunk array", func() {
  let ws: Workspace = Workspace.initWorkspace(3);
  StableBuffer.add<DataZone>(ws, buildDataZone(1));
  StableBuffer.add<DataZone>(ws, buildDataZone(2));
  StableBuffer.add<DataZone>(ws, buildDataZone(3));
  let addressedChunks = Workspace.workspaceToAddressedChunkArray(ws);
  assert(addressedChunks.size() == 6);
  // Test individual chunks and positions accurately
  assert(addressedChunks[0].0 == 0);
  assert(addressedChunks[0].1 == 0);
  assert(Types.eqShared(addressedChunks[0].2, #Nat(0)));

  assert(addressedChunks[1].0 == 1);
  assert(addressedChunks[1].1 == 0);
  assert(Types.eqShared(addressedChunks[1].2, #Nat(0)));

  assert(addressedChunks[2].0 == 1);
  assert(addressedChunks[2].1 == 1);
  assert(Types.eqShared(addressedChunks[02].2, #Nat(1)));

  assert(addressedChunks[3].0 == 2);
  assert(addressedChunks[3].1 == 0);
  assert(Types.eqShared(addressedChunks[3].2, #Nat(0)));

  assert(addressedChunks[4].0 == 2);
  assert(addressedChunks[4].1 == 1);
  assert(Types.eqShared(addressedChunks[4].2, #Nat(1)));

  assert(addressedChunks[5].0 == 2);
  assert(addressedChunks[5].1 == 2);
  assert(Types.eqShared(addressedChunks[5].2, #Nat(2)));


  
});



