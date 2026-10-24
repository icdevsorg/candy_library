// Vendored into candy 0.3.2 from https://github.com/gekctek/motoko_candid at v1.0.1 (commit 4f0c445a4f998d4d07b616fafd463eea8f52e4bc), file src/Tag.mo.
// MIT License -- Copyright Ethan Celletti (gekctek / edjCase). The full license text is in NOTICE at the root of the candy package.
// Only `mo:` package imports were rewritten to relative paths; the code is otherwise unchanged.

import Order "mo:base/Order";
import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Text "mo:base/Text";
import Nat32 "mo:base/Nat32";
import NatX "../xtended_numbers_1_0_2/NatX";

module {
  public type Tag = {
    #name : Text;
    #hash : Nat32;
  };

  public func hashName(name : Text) : Nat32 {
    // hash(name) = ( Sum_(i=0..k) utf8(name)[i] * 223^(k-i) ) mod 2^32 where k = |utf8(name)|-1
    let bytes : [Nat8] = Blob.toArray(Text.encodeUtf8(name));
    Array.foldLeft<Nat8, Nat32>(bytes, 0, func (accum: Nat32, byte : Nat8) : Nat32 {
      (accum *% 223) +% NatX.from8To32(byte);
    });
  };

  public func hash(t : Tag) : Nat32 {
    switch (t) {
      case (#name(n)) hashName(n);
      case (#hash(h)) h;
    };
  };

  public func equal(t1: Tag, t2: Tag) : Bool {
    compare(t1, t2) == #equal;
  };

  public func compare(t1: Tag, t2: Tag) : Order.Order {
    Nat32.compare(hash(t1), hash(t2));
  };
}