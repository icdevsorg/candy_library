# ICRC16 CandyShared

## Context

The proposed ICRC16 CandyShared standard defines a Candid interface for unstructured data that canisters can use to exchange document-style data in a standardized way. This standard aims to facilitate the exchange of unstructured data between canisters and improve interoperability between different systems.

## Data details

* icrc: 16
* title: ICRC16 CandyShared
* author: Austin Fatheree - austin dot fatheree at gmail dot come or @afat on twitter
* status: Draft
* category: ICRC
* requires: None
* created: 2023-Mar-10
* updated: [Current date]

## Summary

The ICRC16 standard proposes a Candid interface for unstructured data to facilitate data exchange between canisters in a standardized way.

## Introduction

The proposed standard describes the Candid interface for unstructured data that canisters can use to exchange data in a flexible and interoperable way. This interface is built upon the [Candid serialization format](https://github.com/dfinity/candid) and defines a set of types can be used to handle various types of unstructured data.

## Goals

The main goals of this standard are to:

* Establish a standard interface for exchanging unstructured data between canisters
* Facilitate the development of standard libraries in Rust, Motoko, Azel, and Kybra that can convert unstructured data into optimized objects
* Improve the interoperability of different systems by enabling a standardized approach to unstructured data exchange
* Simplify the certification and serving of unstructured data, such as JSON data that needs to be served from an Internet Computer canister

## Candid Interface Definition

The ICRC16 CandyShared standard defines a Candid interface for unstructured data that includes the following type:

```
type CandyShared =
  variant {
    Array: vec CandyShared;
    Blob: blob;
    Bool: bool;
    Bytes: vec nat8;
    Class: vec PropertyShared;
    Float: float64;
    Floats: vec float64;
    Int: int;
    Int16: int16;
    Int32: int32;
    Int64: int64;
    Int8: int8;
    Ints: vec int;
    Map: vec record {
      CandyShared;
      CandyShared;
    };
    Nat: nat;
    Nat16: nat16;
    Nat32: nat32;
    Nat64: nat64;
    Nat8: nat8;
    Nats: vec nat;
    Option: opt CandyShared;
    Principal: principal;
    Set: vec CandyShared;
    Text: text;
};
```

This type defines a set of variants that can be used to represent different types of unstructured data, including arrays, blobs, booleans, bytes, classes, floats, integers, maps, naturals, options, principals, sets, and text.


## Complementary standards

This standard can be used by other ICRC standards that require metadata or unstructured data exchange, such as:

 * ICRC-12 - Event Publishers can specify that their data - vec Nat8 - is ICRC16 compliant and can be deserialized using from_candid.
 * ICRC-14 for game stats - The Value type is already very close to CandyShared.
 * ICRC-7 for NFT and other Token standards for metadata. By using ICRC16, these standards would make them selves future compatible.

 ## Possible Extensions and Use Cases

 * ICDevs has developed a motoko library that uses CandyShared and unshares these values into useful structures that can improve the data access and conversion for varius types.  These values are stable and can survive upgrades without having to implement pre or post upgrade.  https://github.com/icdevs/candy_library/tree/0.2.0 
 * The Origyn_NFT standard uses the this format for its metadata.  It allows the NFT creator maximum freedom in defining the fields they want in their NFT metadata fields. see https://github.com/ORIGYN-SA/origyn_nft/blob/f3d50ec079ec113932d8f67450d67da5df9993fd/src/tests/test_utils.mo#L83 for an example.
 * [Zhenya Usenko](https://github.com/ZhenyaUsenko) has  the beginning of a library for querying the data structures called CandyPath which could become an addon standard. We should make an ICRC called CandyPath to standardize this and it should be as close to GraphQL as possible. https://github.com/ZhenyaUsenko/motoko-candy-utils
 * We should create an ICRC called CandySchema that allows a service to provide a schema for their CandyShared structures that can be validated.


 ## Implementation

The ICRC16 standard can be implemented in any language that supports Candid serialization, such as Rust, Motoko, Azel, or Kybra. Implementers can use the standard type and service method to handle unstructured data in a consistent and efficient way. The ICRC16 standard also encourages the development of standard libraries that can convert unstructured data into optimized objects, such as the Candy_Library example provided in the use case section.

## Rationale
The need for a standard Candid interface for unstructured data arises from the fact that unstructured data is ubiquitous in many systems, including the Internet Computer. Unstructured data can come in many forms, such as JSON, XML, YAML, or even binary data, and can be used for various purposes, such as exchanging documents, files, or metadata. However, the lack of a standardized approach to unstructured data exchange can create interoperability issues and make it difficult for developers to handle unstructured data in a consistent and efficient way.

By defining a Candid interface for unstructured data, the ICRC16 standard aims to provide a common ground for canisters to exchange unstructured data in a flexible and interoperable way. This standard defines a set of types that can be used to represent and access different types of unstructured data, including arrays, blobs, maps, and text. The standard also complements other Candid-related standards, such as ICRC-12 for Candid extensions, and can be used by other ICRC standards that require metadata or unstructured data exchange.


## Security Considerations

The ICRC16 standard defines a Candid interface for unstructured data that can be used to exchange data between canisters. However, care should be taken to ensure that the exchanged data is secure and does not pose a security risk to the system. In particular, canisters should validate the data they receive from other canisters to ensure that it conforms to the expected format and does not contain malicious code or data.

Implementers of the ICRC16 standard should also consider the security implications of their implementation and follow best practices for secure software development. This includes using secure coding practices, validating user input, sanitizing data, and following the principle of least privilege. Implementers should also consider the potential impact of denial-of-service attacks or other forms of attacks that can exploit vulnerabilities in the system.

In particular, the size of a CandyShared object could be used in an attack. Depending on your use case, you may want to check the size of the object before storing or processing it to make sure it doesn't violate rational use cases.

# Conclusion

The proposed ICRC16 CandyShared standard defines a Candid interface for unstructured data that canisters can use to exchange data in a flexible and interoperable way. This standard aims to simplify the exchange of unstructured data and improve interoperability between different systems. We believe that this standard will be useful for developers who need to handle unstructured data in a consistent and efficient way and that it will facilitate the development of standard libraries and tools that can work with unstructured data.

We welcome feedback and contributions from the community to help refine and improve this standard.