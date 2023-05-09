# candy_library

v0.2.0

Library for Converting Types and Creating Workable Motoko Collections

This library provides for both Stable and Shared collections and conversions.  These methods help with keeping data in unstable workable runtime memory while providing methods to convert those objects to stable collections that can be put into upgrade variables for persistence across upgrades or for shipping the objects to other canisters and returning them as async functions.

#### Todo
- [ ] Tests  
- [ ] Examples

## Installation

```
mops candy
```

## Structure
The provided functionality is divided into separate libraries to silo some of the functionality.

#### type.mo
Holds most types and few conversion functions to stabilize/destabilize candy values, properties, and workspace types.

`CandyShared` and `Candy` allow you to specify your variables in a variant class that makes keeping arrays and buffers of different types managable.  i.e. stable var `myCollection : [CandySharedStable] = [#Int(0), #Text("second value"), #Float(3.14)]`.

Stabalize and Destablaize functions are provided for both `CandyShared <> Candy`, `Properties <> Property`, `[CandyShared] <> [Candy]`.

#### conversion.mo
Holds most of the conversion functions.

We provide the following conversion methods. Note that most of these will `assert(false)` if you try to output an impossible conversion.

* CandyShared -> Nat
* CandyShared -> Nat8
* CandyShared -> Nat16
* CandyShared -> Nat32
* CandyShared -> Nat64
* CandyShared -> Int
* CandyShared -> Int8
* CandyShared -> Int16
* CandyShared -> Int32
* CandyShared -> Int64
* CandyShared -> Float
* CandyShared -> Text
* CandyShared -> Principal
* CandyShared -> Bool
* CandyShared -> Blob
* CandyShared -> CandyShared Array
* CandyShared -> Byte Array [Nat8]

* Candy -> Nat
* Candy -> Nat8
* Candy -> Nat16
* Candy -> Nat32
* Candy -> Nat64
* Candy -> Int
* Candy -> Int8
* Candy -> Int16
* Candy -> Int32
* Candy -> Int64
* Candy -> Float
* Candy -> Text
* Candy -> Principal
* Candy -> Bool
* Candy -> Blob
* Candy -> Candy Array
* Candy -> Byte Array [Nat8]
* Candy -> Byte Buffer Buffer.Buffer<Nat8>
* Candy -> Float Buffer Buffer.Buffer<Float>

`#Option` variant types can be unwrapped with `unwrapOptionCandy` and `unwrapOptionCandyShared` and will return `#Empty` if the option was null.

A toBuffer function will convert an Array to a Buffer of the same type.  The is a n on n function and will iterate through each item in the array.

We provide a number of functions that convert base types to byte arrays and back that can easily be converted to blobs using the Blob base library. Supports: Nat, Nat[64,32,16], Text, Principal, Bool, Int

#### clone.mo 
Has some clone functions for deep cloning classes. The clone functions exist to clone unstable values into new variables.

#### properties.mo
Property and class functions for updating and manipulating classes.

The property objects (adapted from https://github.com/DepartureLabsIC/non-fungible-token/blob/main/src/property.mo with copyright DepartureLabs and under MIT License, included here for compilability reasons.) allow for Key/Value collections that can be easily created, queried, and updated.  We include conversions between stable and unstable properties.

#### workspace.mo
Useful for keeping workable data in chunks that can be moved around canisters.

Workspace collections help manage data and can help chunk data into chunks sized to send across another canister or return to a calling client. These calls are limited to ~2MB and this library can help you keep chunks of data together for easy monitoring. Workspaces can be deconstructed into `AddressedChunckArrays` that can be shipped elsewhere and reassembled using the address of the chunks on the other side of an async call. For more information and helper libraries see the pipelinify project. 

* `workspaceToAddressedChunkArray` - convert a workspace to an `AddressedChunkArray`
* `workspaceDeepClone` - clone a workspace
* `fromAddressedChunks` - reconsitute a workspace from and `AddressedChunkArray`
* `getDataZoneSize` - inspects the size of the datazone. 
* `getWorkspaceChunkSize` - Gets the number of chunks a workspace will be split into given a max chunk size
* `getWorkspaceChunk` - gets the nth chunk given a max chunk size(recomended 2MB)
* `getAddressedChunkArraySize` - returns the size of an `AddressedChunkArray`
* `getDataChunkFromAddressedChunkArray` - returns the addressed chunk out of an `AddresedChunkArray`
* `byteBufferDataZoneToBuffer` - specifically converts a `DataZone` containing a `ByteBuffer` into a `ByteBuffer`
* `byteBufferChunksToValueSharedBufferDataZone` - converts a `ByteBuffer` into a `DataZone`
* `initDataZone` - initializes a `Datazone`
* `flattenAddressedChunkArray` - Converts an addressed chunk array into a pure byte array. Breaks after 256 Zones or 256 Chunks.

## Testing
From the root directory of the project, execute the following command:

```bash
printf "yes" | bash test_runner.sh
```

## Releases

#### v0.2.0

* Major breaking changes
* Value is now CandyShared
* ValueUnstable is now Candy
* Added a stable hash
* Todo: fund a better eq function than to_candid, from_candid

#### v0.1.12

* Refactor - Cleaned up code
* JSON - added a library to dump values to JSON

## Note 
This project was a part of the [ARAMAKME expirament](https://hwqwz-ryaaa-aaaai-aasoa-cai.raw.ic0.app/) and an example of how to integrate an ARAMAKME license into a library can be found in the /Example_Aramakme_License folder.  The ARAMAKME license has since been removed from this library and it is licensed under the MIT License.  Until they are all distributed, the ARAMAKME NFTs are still for sale as a nastalgoic piece of memorobilia, and all profits will be locked into an 8 year neuron benifiting [ICDevs.org](https://icdevs.org) who are sheparding this library as it moves forward and improves.