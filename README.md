# candy_library
Library for Converting Types and Creating Workable Motoko Collections

This library provides for both Stable and Unstable collections and conversions.  These methods help with keeping data in unstable workable runtime memory while providing methods to convert those objects to stable collections that can be put into upgrade variables for persistence across upgrades or for shipping the objects to other canisters and returning them as async functions. 

I have refactored the files into separate libraries to silo some of the functionality.

type.mo - holds most types and few conversion functions to stabilize/destabilize candy values, properties, and workspace types.

conversion.mo - holds most of the conversion functions

clone.mo - has some clone functions for deep cloning classes

properties.mo - property and class functions for updating and manipulating classes

workspace.mo - useful for keeping workable data in chunks that can be moved around canisters.

CandyValue and CandyValueUnstable allow you to specify your variables in a variant class that makes keeping arrays and buffers of different types managable.  ie stable var myCollection : [CandyValueStable] = [#Int(0), #Text("second value"), #Float(3.14)]

The property objects (adapted from https://github.com/DepartureLabsIC/non-fungible-token/blob/main/src/property.mo with copyright DepartureLabs and under MIT License, included here for compilability reasons.) allow for Key/Value collections that can be easily created, queried, and updated.  We include conversions between stable and unstable properties.

We provide the following conversion methods.  Most will assert(false if you try to output an impossible conversion.):

* CandyValue -> Nat
* CandyValue -> Nat8
* CandyValue -> Nat16
* CandyValue -> Nat32
* CandyValue -> Nat64
* CandyValue -> Int
* CandyValue -> Int8
* CandyValue -> Int16
* CandyValue -> Int32
* CandyValue -> Int64
* CandyValue -> Float
* CandyValue -> Text
* CandyValue -> Principal
* CandyValue -> Bool
* CandyValue -> Blob
* CandyValue -> CandyValue Array
* CandyValue -> Byte Array [Nat8]

* CandyValueUnstable -> Nat
* CandyValueUnstable -> Nat8
* CandyValueUnstable -> Nat16
* CandyValueUnstable -> Nat32
* CandyValueUnstable -> Nat64
* CandyValueUnstable -> Int
* CandyValueUnstable -> Int8
* CandyValueUnstable -> Int16
* CandyValueUnstable -> Int32
* CandyValueUnstable -> Int64
* CandyValueUnstable -> Float
* CandyValueUnstable -> Text
* CandyValueUnstable -> Principal
* CandyValueUnstable -> Bool
* CandyValueUnstable -> Blob
* CandyValueUnstable -> CandyValueUnstable Array
* CandyValueUnstable -> Byte Array [Nat8]
* CandyValueUnstable -> Byte Buffer Buffer.Buffer<Nat8>
* CandyValueUnstable -> Float Buffer Buffer.Buffer<Float>

Clone Functions exist to clone unstable values into new variables, 

#Option variant types can be unwrapped with unwrapOptionValue and unwrapOptionValueUnstable and will return #Empty if the option was null.

Stabalize and Destablaize functions are provided for both CandyValue <> CandyValueUnstable, Properties <> PropertyUnstable, [CandyValue] <> [CandyValueUnstable].

A toBuffer function will convert an Array to a Buffer of the same type.  The is a n on n function and will iterate through each item in the array.

We provide a number of functions that convert base types to byte arrays and back that can easily be converted to blobs using the Blob base library.  Supports: Nat, Nat[64,32,16], Text, Principal, Bool, Int

Workspace collections help manage data and can help chunk data into chunks sized to send across another canister or return to a calling client.  These calls are limited to ~2MB and this library can help you keep chunks of data together for easy monitoring. Workspaces can be deconstructed into AddressedChunckArrays that can be shipped elsewhere and reassembled using the address of the chunks on the other side of an async call.For more information and helper libraries see the pipelinify project. 

* workspaceToAddressedChunkArray - convert a workspace to an AddressedChunkArray
* workspaceDeepClone - clone a workspace
* fromAddressedChunks - reconsitute a workspace from and AddressedChunkArray
* getDataZoneSize - inspects the size of the datazone. 
* getWorkspaceChunkSize - Gets the number of chunks a workspace will be split into given a max chunk size
* getWorkspaceChunk - gets the nth chunk given a max chunk size(recomended 2MB)
* getAddressedChunkArraySize - returns the size of an AddressedChunkArray
* getDataChunkFromAddressedChunkArray - returns the addressed chunk out of an AddresedChunkArray
* byteBufferDataZoneToBuffer - specifically converts a DataZone containing a ByteBuffer into a ByteBuffer
* byteBufferChunksToValueUnstableBufferDataZone - converts a ByteBuffer into a DataZone
* initDataZone - initializes a datazone
* flattenAddressedChunkArray - Converts an addressed chunk array into a pure byte array. Breaks after 256 Zones or 256 Chunks.

Todo: Tests, examples

Note: This project was a part of the [ARAMAKME expirament](https://hwqwz-ryaaa-aaaai-aasoa-cai.raw.ic0.app/) and an example of how to integrate an ARAMAKME license into a library can be found in the /Example_Aramakme_License folder.  The ARAMAKME license has since been removed from this library and it is licensed under the MIT License.  Until they are all distributed, the ARAMAKME NFTs are still for sale as a nastalgoic piece of memorobilia, and all profits will be locked into an 8 year neuron benifiting [ICDevs.org](https://icdevs.org) who are sheparding this library as it moves forward and improves.


## Testing

    printf "yes" | bash test_runner.sh

