// Vendored into candy 0.3.2 from https://github.com/gekctek/motoko_candid at v1.0.1 (commit 4f0c445a4f998d4d07b616fafd463eea8f52e4bc), file src/Value.mo.
// MIT License -- Copyright Ethan Celletti (gekctek / edjCase). The full license text is in NOTICE at the root of the candy package.
// Only `mo:` package imports were rewritten to relative paths; the code is otherwise unchanged.

import Array "mo:base/Array";
import FloatX "../xtended_numbers_1_0_2/FloatX";
import InternalTypes "InternalTypes";
import Iter "mo:base/Iter";
import Order "mo:base/Order";
import Tag "./Tag";
import TransparencyState "./TransparencyState";

module {
  type Tag = Tag.Tag;
  type TransparencyState<T> = TransparencyState.TransparencyState<T>;

  public type RecordFieldValue = {
    tag: Tag;
    value: Value;
  };

  public type Func = {
    service : TransparencyState<Principal>;
    method : Text;
  };

  public type VariantOptionValue = RecordFieldValue;

  public type Value = {
    #int : Int;
    #int8 : Int8;
    #int16 : Int16;
    #int32 : Int32;
    #int64 : Int64;
    #nat : Nat;
    #nat8 : Nat8;
    #nat16 : Nat16;
    #nat32 : Nat32;
    #nat64 : Nat64;
    #_null;
    #bool : Bool;
    #float32 : Float;
    #float64 : Float;
    #text : Text;
    #reserved;
    #empty;
    #opt : ?Value;
    #vector : [Value];
    #record : [RecordFieldValue];
    #variant : VariantOptionValue;
    #_func : TransparencyState<Func>;
    #service : TransparencyState<Principal>;
    #principal : TransparencyState<Principal>;
  };

  public func equal(v1: Value, v2: Value): Bool {
    switch (v1) {
      case (#float32(f1)) {
        let f2 = switch (v2) {
          case(#float32(f2)) f2;
          case(#float64(f2)) f2;
          case (_) return false;
        };
        FloatX.nearlyEqual(f1, f2, 0.0000001, 0.000001);
      };
      case (#float64(f1)) {
        let f2 = switch (v2) {
          case(#float32(f2)) f2;
          case(#float64(f2)) f2;
          case (_) return false;
        };
        FloatX.nearlyEqual(f1, f2, 0.0000001, 0.000001);
      };
      case (#opt(o1)) {
        let o2 = switch (v2) {
          case(#opt(o2)) o2;
          case (_) return false;
        };
        switch (o1) {
          case (null) return o2 == null;
          case (?o1) {
            switch(o2) {
              case (null) return false;
              case (?o2) equal(o1, o2);
            }
          }
        };
      };
      case (#vector(ve1)) {
        let ve2 = switch (v2) {
          case(#vector(ve)) ve;
          case (_) return false;
        };
        InternalTypes.arraysAreEqual(
          ve1,
          ve2,
          null, // Dont reorder
          equal
        );
      };
      case (#record(r1)) {
        let r2 = switch (v2) {
          case(#record(r2)) r2;
          case (_) return false;
        };

        InternalTypes.arraysAreEqual(
          r1,
          r2,
          ?(func (t1: RecordFieldValue, t2: RecordFieldValue) : Order.Order {
            Tag.compare(t1.tag, t2.tag)
          }),
          func (t1: RecordFieldValue, t2: RecordFieldValue) : Bool {
            if (not Tag.equal(t1.tag, t2.tag)) {
              return false;
            };
            equal(t1.value, t2.value);
          }
        );
      };
      case (#variant(va1)) {
        let va2 = switch (v2) {
          case(#variant(va2)) va2;
          case (_) return false;
        };
        if (not Tag.equal(va1.tag, va2.tag)) {
          return false;
        };
        if (not equal(va1.value, va2.value)) {
          return false;
        };
        true;
      };
      case (#_func(f1)) {
        let f2 = switch (v2) {
          case(#_func(f2)) f2;
          case (_) return false;
        };
        switch (f1){
          case (#opaque) f2 == #opaque;
          case (#transparent(t1)) {
            switch (f2) {
              case (#opaque) false;
              case (#transparent(t2)) {
                if (t1.method != t2.method) {
                  false;
                } else {
                  t1.service == t2.service
                }
              };
            }
          }
        }
      };
      case (#service(s1)) {
        let s2 = switch (v2) {
          case(#service(s2)) s2;
          case (_) return false;
        };
        s1 == s2
      };
      case (a) a == v2;
    };
  };
}