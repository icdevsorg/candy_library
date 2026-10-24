// Vendored into candy 0.3.2 from https://github.com/gekctek/motoko_candid at v1.0.1 (commit 4f0c445a4f998d4d07b616fafd463eea8f52e4bc), file src/FuncMode.mo.
// MIT License -- Copyright Ethan Celletti (gekctek / edjCase). The full license text is in NOTICE at the root of the candy package.
// Only `mo:` package imports were rewritten to relative paths; the code is otherwise unchanged.

import Array "mo:base/Array";
import Blob "mo:base/Blob";
import FloatX "../xtended_numbers_1_0_2/FloatX";
import Iter "mo:base/Iter";
import Nat "mo:base/Blob";
import Nat32 "mo:base/Nat32";
import NatX "../xtended_numbers_1_0_2/NatX";
import Order "mo:base/Order";
import Text "mo:base/Text";

module {

  public type FuncMode = {
    #oneWay;
    #_query;
  };

}