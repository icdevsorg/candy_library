// Vendored into candy 0.3.2 from https://github.com/gekctek/motoko_candid at v1.0.1 (commit 4f0c445a4f998d4d07b616fafd463eea8f52e4bc), file src/Type.mo.
// MIT License -- Copyright Ethan Celletti (gekctek / edjCase). The full license text is in NOTICE at the root of the candy package.
// Only `mo:` package imports were rewritten to relative paths; the code is otherwise unchanged.

import Array "mo:base/Array";
import FuncMode "./FuncMode";
import Hash "mo:base/Hash";
import Int "mo:base/Int";
import Nat32 "mo:base/Nat32";
import InternalTypes "./InternalTypes";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Order "mo:base/Order";
import Tag "./Tag";
import Text "mo:base/Text";
import TypeCode "./TypeCode";
import Util "InternalTypes";

module {
  public type FuncType = {
    modes : [FuncMode.FuncMode];
    argTypes : [Type];
    returnTypes : [Type];
  };

  public type RecordFieldType = {
    tag : Tag.Tag;
    _type : Type;
  };

  public type VariantOptionType = RecordFieldType;

  public type ServiceType = {
    methods : [(Text, FuncType)];
  };

  public type PrimitiveType = {
    #int;
    #int8;
    #int16;
    #int32;
    #int64;
    #nat;
    #nat8;
    #nat16;
    #nat32;
    #nat64;
    #_null;
    #bool;
    #float32;
    #float64;
    #text;
    #reserved;
    #empty;
    #principal;
  };

  public type CompoundType = {
    #opt : Type;
    #vector : Type;
    #record : [RecordFieldType];
    #variant : [VariantOptionType];
    #_func : FuncType;
    #service : ServiceType;
    #recursiveType : {id: Text; _type: CompoundType};
    #recursiveReference : Text;
  };

  public type Type = CompoundType or PrimitiveType;


  public func equal(v1: Type, v2: Type): Bool {
    switch (v1) {
      case (#opt(o1)) {
        let o2 = switch (v2) {
          case(#opt(o2)) o2;
          case (_) return false;
        };
        equal(o1, o2);
      };
      case (#vector(ve1)) {
        let ve2 = switch (v2) {
          case(#vector(ve)) ve;
          case (_) return false;
        };
        equal(ve1, ve2);
      };
      case (#record(r1)) {
        let r2 = switch (v2) {
          case(#record(r2)) r2;
          case (_) return false;
        };

        InternalTypes.arraysAreEqual(
          r1,
          r2,
          ?(func (t1: RecordFieldType, t2: RecordFieldType) : Order.Order {
            Tag.compare(t1.tag, t2.tag)
          }),
          func (t1: RecordFieldType, t2: RecordFieldType) : Bool {
            if (not Tag.equal(t1.tag, t2.tag)) {
              return false;
            };
            equal(t1._type, t2._type);
          }
        );
      };
      case (#variant(va1)) {
        let va2 = switch (v2) {
          case(#variant(va2)) va2;
          case (_) return false;
        };
        InternalTypes.arraysAreEqual(
          va1,
          va2,
          ?(func (t1: VariantOptionType, t2: VariantOptionType) : Order.Order {
            Tag.compare(t1.tag, t2.tag)
          }),
          func (t1: VariantOptionType, t2: VariantOptionType) : Bool {
            if (not Tag.equal(t1.tag, t2.tag)) {
              return false;
            };
            equal(t1._type, t2._type);
          }
        );
      };
      case (#_func(f1)) {
        let f2 = switch (v2) {
          case(#_func(f2)) f2;
          case (_) return false;
        };

        // Mode Types
        let getModeValue = func (m: FuncMode.FuncMode) : Nat {
          switch (m){
            case (#oneWay) 2;
            case (#_query) 1;
          }
        };
        let modesAreEqual = InternalTypes.arraysAreEqual(
          f1.modes,
          f2.modes,
          ?(func (m1: FuncMode.FuncMode, m2: FuncMode.FuncMode) : Order.Order {
            let mv1: Nat = getModeValue(m1);
            let mv2: Nat = getModeValue(m2);
            Nat.compare(mv1, mv2); 
          }),
          func (m1: FuncMode.FuncMode, m2: FuncMode.FuncMode) : Bool {
            m1 == m2
          }
        );
        if (not modesAreEqual) {
          return false;
        };
        // Arg Types
        let argTypesAreEqual = InternalTypes.arraysAreEqual(
          f1.argTypes,
          f2.argTypes,
          null, // Dont reorder
          equal
        );
        if (not argTypesAreEqual) {
          return false;
        };
        // Return types
        InternalTypes.arraysAreEqual(
          f1.returnTypes,
          f2.returnTypes,
          null, // Dont reorder
          equal
        );
      };
      case (#service(s1)) {
        let s2 = switch (v2) {
          case(#service(s2)) s2;
          case (_) return false;
        };
        Util.arraysAreEqual(
          s1.methods,
          s2.methods,
          ?(func (t1: (Text, FuncType), t2: (Text, FuncType)) : Order.Order{
            Text.compare(t1.0, t2.0)
          }),
          func (t1: (Text, FuncType), t2: (Text, FuncType)) : Bool {
            if (t1.0 != t1.0) {
              false;
            } else {
              equal(#_func(t1.1), #_func(t2.1));
            }
          }
        )
      };
      case (#recursiveType(r1)) {
        let r2 = switch (v2) {
          case(#recursiveType(r2)) r2;
          case (_) return false;
        };
        equal(r1._type, r2._type);
      };
      case (#recursiveReference(r1)) {
        let r2 = switch (v2) {
          case(#recursiveReference(r2)) r2;
          case (_) return false;
        };
        true;
      };
      case (a) a == v2;
    };
  };

  public func hash(t : Type) : Hash.Hash {
    switch (t) {
      case (#opt(o)) {
        let h = hashTypeCode(TypeCode.opt);
        let innerHash = hash(o);
        combineHash(h, innerHash);
      };
      case (#vector(v)) {
        let h = hashTypeCode(TypeCode.vector);
        let innerHash = hash(v);
        combineHash(h, innerHash);
      };
      case (#record(r)) {
        let h = hashTypeCode(TypeCode.record);
        Array.foldLeft<RecordFieldType, Hash.Hash>(r, h, func (v: Hash.Hash, f: RecordFieldType) : Hash.Hash {
          let innerHash = hash(f._type);
          combineHash(combineHash(v, Tag.hash(f.tag)), innerHash);
        });
      };
      case (#_func(f)) {
        let h = hashTypeCode(TypeCode._func);
        let h2 = Array.foldLeft<Type, Hash.Hash>(f.argTypes, h, func (v: Hash.Hash, f: Type) : Hash.Hash {
          combineHash(v, hash(f));
        });
        let h3 = Array.foldLeft<Type, Hash.Hash>(f.returnTypes, h2, func (v: Hash.Hash, f: Type) : Hash.Hash {
          combineHash(v, hash(f));
        });
        Array.foldLeft<FuncMode.FuncMode, Hash.Hash>(f.modes, h3, func (v: Hash.Hash, f: FuncMode.FuncMode) : Hash.Hash {
          combineHash(v, switch(f){
            case (#_query) 1;
            case (#oneWay) 2;
          });
        });
      };
      case (#service(s)) {
        let h = hashTypeCode(TypeCode.service);
        Array.foldLeft<(Text, FuncType), Hash.Hash>(s.methods, h, func (v: Hash.Hash, f: (Text, FuncType)) : Hash.Hash {
          combineHash(h, combineHash(Text.hash(f.0), hash(#_func(f.1))));
        });
      };
      case (#variant(v)) {
        var h = hashTypeCode(TypeCode.variant);
        Array.foldLeft<VariantOptionType, Hash.Hash>(v, 0, func (h: Hash.Hash, o: VariantOptionType) : Hash.Hash {
          let innerHash = hash(o._type);
          combineHash(combineHash(h, Tag.hash(o.tag)), innerHash);
        });
      };
      case (#recursiveType(rT)) {
        hash(rT._type);
      };
      case (#recursiveReference(r)) {
        Text.hash(r);
      };
      case (#int) hashTypeCode(TypeCode.int);
      case (#int8) hashTypeCode(TypeCode.int8);
      case (#int16) hashTypeCode(TypeCode.int16);
      case (#int32) hashTypeCode(TypeCode.int32);
      case (#int64) hashTypeCode(TypeCode.int64);
      case (#nat) hashTypeCode(TypeCode.nat);
      case (#nat8) hashTypeCode(TypeCode.nat8);
      case (#nat16) hashTypeCode(TypeCode.nat16);
      case (#nat32) hashTypeCode(TypeCode.nat32);
      case (#nat64) hashTypeCode(TypeCode.nat64);
      case (#_null) hashTypeCode(TypeCode._null);
      case (#bool) hashTypeCode(TypeCode.bool);
      case (#float32) hashTypeCode(TypeCode.float32);
      case (#float64) hashTypeCode(TypeCode.float64);
      case (#text) hashTypeCode(TypeCode.text);
      case (#reserved) hashTypeCode(TypeCode.reserved);
      case (#empty) hashTypeCode(TypeCode.empty);
      case (#principal) hashTypeCode(TypeCode.principal);
    };
  };

  private func hashTypeCode(i: Int) : Hash.Hash {
    Nat32.fromNat(Int.abs(i));
  };

  private func combineHash(seed: Hash.Hash, value: Hash.Hash) : Hash.Hash {
    // From `C++ Boost Hash Combine`
    seed ^ (value +% 0x9e3779b9 +% (seed << 6) +% (seed >> 2));
  };

}