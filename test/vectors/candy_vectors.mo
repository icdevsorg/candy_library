// Byte-identity vectors for candy 0.3.2. This generator was run against candy 0.3.1 (with the old
// GitHub dependencies and a base-0.7.3 alias) and against 0.3.2; both printed the same 4,118 lines.
// check.sh reruns it and compares the SHA-256 of the output with the 0.3.1 digest.
import Types "mo:candy/types";
import Conv "mo:candy/conversion";
import C16 "mo:candy/icrc16/conversion";
import Json "mo:candy/json";
import Candid "mo:candy/candid";
import Clone "mo:candy/clone";
import Workspace "mo:candy/workspace";
import Properties "mo:candy/properties";
import Upgrade "mo:candy/upgrade";
import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Buffer "mo:base/Buffer";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";

var lines = 0;
func p(t : Text) { lines += 1; Debug.print(t) };

// ---------------------------------------------------------------- byte corpus (hex call sites)
let byteCases = Buffer.Buffer<[Nat8]>(300);
byteCases.add([]);
for (i in Iter.range(0, 255)) { byteCases.add([Nat8.fromNat(i)]) };
byteCases.add(Array.tabulate<Nat8>(256, func i = Nat8.fromNat(i)));
byteCases.add(Array.tabulate<Nat8>(256, func i = Nat8.fromNat(255 - i)));
byteCases.add([0x00, 0x00]);
byteCases.add([0xff, 0xff, 0xff, 0xff]);
byteCases.add([0x0f, 0xf0, 0xa5, 0x5a]);
var seed : Nat = 12345;
func next() : Nat8 { seed := (seed * 1103515245 + 12345) % 2147483648; Nat8.fromNat(seed / 65536 % 256) };
for (len in [2, 3, 7, 16, 31, 32, 33, 64, 100, 1000, 4096].vals()) {
  byteCases.add(Array.tabulate<Nat8>(len, func _ = next()));
};

var hexSites = 0;
for (b in byteCases.vals()) {
  let blob = Blob.fromArray(b);
  p("hex text/Bytes " # Conv.candySharedToText(#Bytes(b)));
  p("hex text/Blob " # Conv.candySharedToText(#Blob(blob)));
  p("hex candyToText/Bytes " # Conv.candyToText(Types.unshare(#Bytes(b))));
  p("hex candyToText/Blob " # Conv.candyToText(Types.unshare(#Blob(blob))));
  p("hex json/Bytes " # Json.value_to_json(#Bytes(b)));
  p("hex json/Blob " # Json.value_to_json(#Blob(blob)));
  p("hex c16 text/Bytes " # debug_show (C16.candySharedToText(#Bytes(b))));
  p("hex c16 text/Blob " # debug_show (C16.candySharedToText(#Blob(blob))));
  p("hex c16 candyToText/Bytes " # debug_show (C16.candyToText(Types.unshare(#Bytes(b)))));
  p("hex c16 candyToText/Blob " # debug_show (C16.candyToText(Types.unshare(#Blob(blob)))));
  hexSites += 10;
};

// ---------------------------------------------------------------- value corpus (every variant)
let pr = Principal.fromText("rrkah-fqaaa-aaaaa-aaaaq-cai");
let anon = Principal.fromText("2vxsx-fae");
let leaves : [(Text, Types.CandyShared)] = [
  ("Int0", #Int(0)), ("IntNeg", #Int(-1)), ("IntBig", #Int(-340282366920938463463374607431768211457)),
  ("IntPosBig", #Int(340282366920938463463374607431768211456)),
  ("Int8min", #Int8(-128)), ("Int8max", #Int8(127)), ("Int16min", #Int16(-32768)), ("Int16max", #Int16(32767)),
  ("Int32min", #Int32(-2147483648)), ("Int32max", #Int32(2147483647)),
  ("Int64min", #Int64(-9223372036854775808)), ("Int64max", #Int64(9223372036854775807)),
  ("Ints", #Ints([0, -1, 1, 128, -129, 1_000_000_000_000_000_000_000])), ("IntsEmpty", #Ints([])),
  ("Nat0", #Nat(0)), ("Nat127", #Nat(127)), ("Nat128", #Nat(128)), ("NatBig", #Nat(340282366920938463463374607431768211456)),
  ("Nat8", #Nat8(255)), ("Nat16", #Nat16(65535)), ("Nat32", #Nat32(4294967295)), ("Nat64", #Nat64(18446744073709551615)),
  ("Float0", #Float(0.0)), ("FloatNeg", #Float(-1.5)), ("FloatPi", #Float(3.141592653589793)), ("FloatTiny", #Float(5e-324)),
  ("TextEmpty", #Text("")), ("Text", #Text("hello \"candy\" \\ / \n\t é 漢字 🍬")),
  ("BoolT", #Bool(true)), ("BoolF", #Bool(false)),
  ("BlobEmpty", #Blob("")), ("Blob", #Blob("\00\01\7f\80\ff")),
  ("Principal", #Principal(pr)), ("PrincipalAnon", #Principal(anon)),
  ("OptionNull", #Option(null)), ("OptionSome", #Option(?#Nat(7))),
  ("Nats", #Nats([0, 1, 255, 256, 65536])), ("NatsEmpty", #Nats([])),
  ("Floats", #Floats([0.0, -2.25, 1e300])), ("FloatsEmpty", #Floats([])),
  ("Bytes", #Bytes([0, 1, 127, 128, 255])), ("BytesEmpty", #Bytes([])),
];
let nested : [(Text, Types.CandyShared)] = [
  ("Array", #Array([#Nat(1), #Text("two"), #Blob("\03"), #Array([#Bool(true)])])), ("ArrayEmpty", #Array([])),
  ("Class", #Class([{ name = "a"; value = #Nat(1); immutable = true }, { name = "b"; value = #Text("x"); immutable = false },
                    { name = "c"; value = #Class([{ name = "d"; value = #Bytes([9, 10]); immutable = false }]); immutable = true }])),
  ("ClassEmpty", #Class([])),
  ("Map", #Map([("k1", #Nat(1)), ("k2", #Text("v")), ("k3", #Blob("\de\ad"))])), ("MapEmpty", #Map([])),
  ("ValueMap", #ValueMap([(#Text("a"), #Nat(1)), (#Nat(2), #Bytes([2])), (#Blob("\ff"), #Bool(false))])), ("ValueMapEmpty", #ValueMap([])),
  ("Set", #Set([#Nat(1), #Text("s"), #Blob("\00")])), ("SetEmpty", #Set([])),
  ("Deep", #Option(?#Array([#Map([("x", #Option(?#ValueMap([(#Int(-5), #Floats([1.0]))])))]), #Set([#Ints([-1])])]))),
];
let corpus = Array.append(leaves, nested);

func safe(name : Text, label_ : Text, f : () -> Text) { p(name # " " # label_ # " " # f()) };

for ((name, v) in corpus.vals()) {
  safe(name, "debug", func() = debug_show v);
  safe(name, "text", func() = Conv.candySharedToText(v));
  safe(name, "value", func() = debug_show (Conv.CandySharedToValue(v)));
  safe(name, "json", func() = Json.value_to_json(v));
  safe(name, "candid", func() = debug_show (Candid.value_to_candid(v)));
  safe(name, "hashShared", func() = debug_show (Types.hashShared(v)));
  safe(name, "eqShared", func() = debug_show (Types.eqShared(v, v)));
  let u = Types.unshare(v);
  safe(name, "unshare->share", func() = debug_show (Types.shareCandy(u)));
  safe(name, "hash", func() = debug_show (Types.hash(u)));
  safe(name, "eq", func() = debug_show (Types.eq(u, u)));
  safe(name, "clone", func() = debug_show (Types.shareCandy(Clone.cloneCandy(u))));
  safe(name, "candyToText", func() = Conv.candyToText(u));
  safe(name, "CandyToValue", func() = debug_show (Conv.CandyToValue(u)));
  safe(name, "sizeShared", func() = debug_show (Workspace.getCandySharedSize(v)));
  safe(name, "size", func() = debug_show (Workspace.getCandySize(u)));
  safe(name, "c16 text", func() = debug_show (C16.candySharedToText(v)));
  safe(name, "c16 value", func() = debug_show (C16.candySharedToValue(v)));
  safe(name, "c16 bytes", func() = debug_show (C16.candySharedToBytes(v)));
  safe(name, "c16 nat", func() = debug_show (C16.candySharedToNat(v)));
  safe(name, "c16 int", func() = debug_show (C16.candySharedToInt(v)));
  safe(name, "c16 candyToText", func() = debug_show (C16.candyToText(u)));
  safe(name, "c16 candyToBytes", func() = debug_show (C16.candyToBytes(u)));
  safe(name, "c16 candyToValue", func() = debug_show (C16.candyToValue(u)));
  safe(name, "c16 props", func() = debug_show (C16.candySharedToProperties(v)));
};

// ---------------------------------------------------------------- byte encoders
for (n in [0, 1, 127, 128, 255, 256, 65535, 65536, 4294967295, 18446744073709551615, 340282366920938463463374607431768211456].vals()) {
  p("natToBytes " # debug_show (n, Conv.natToBytes(n), Conv.bytesToNat(Conv.natToBytes(n))));
};
for (i in [0, 1, -1, 127, -128, 128, -129, 9223372036854775807, -9223372036854775808, -340282366920938463463374607431768211457].vals()) {
  p("intToBytes " # debug_show (i, Conv.intToBytes(i), Conv.bytesToInt(Conv.intToBytes(i))));
};
for (t in ["", "a", "hello", "é漢字🍬"].vals()) {
  p("textToBytes " # debug_show (t, Conv.textToBytes(t), Conv.bytesToText(Conv.textToBytes(t))));
};
p("principalToBytes " # debug_show (Conv.principalToBytes(pr), Conv.bytesToPrincipal(Conv.principalToBytes(pr))));
p("boolToBytes " # debug_show (Conv.boolToBytes(true), Conv.boolToBytes(false)));

// ---------------------------------------------------------------- properties
let props : [Types.PropertyShared] = [
  { name = "a"; value = #Nat(1); immutable = false },
  { name = "b"; value = #Class([{ name = "c"; value = #Text("t"); immutable = false }]); immutable = false },
];
p("getPropertiesShared " # debug_show (Properties.getPropertiesShared(props, [{ name = "b"; next = [{ name = "c"; next = [] }] }])));
p("updatePropertiesShared " # debug_show (Properties.updatePropertiesShared(props, [{ name = "a"; mode = #Set(#Nat(2)) }])));
p("getClassPropertyShared " # debug_show (Properties.getClassPropertyShared(#Class(props), "a")));

// ---------------------------------------------------------------- upgrade paths (vendored old types)
  type CandyValue = {
    #Int : Int;
    #Int8: Int8;
    #Int16: Int16;
    #Int32: Int32;
    #Int64: Int64;
    #Nat : Nat;
    #Nat8 : Nat8;
    #Nat16 : Nat16;
    #Nat32 : Nat32;
    #Nat64 : Nat64;
    #Float : Float;
    #Text : Text;
    #Bool : Bool;
    #Blob : Blob;
    #Class : [PropertyV1];
    #Principal : Principal;
    #Option : ?CandyValue;
    #Array : {
      #frozen: [CandyValue];
      #thawed: [CandyValue]; //need to thaw when going to CandyValueUnstable
    };
    #Nats: {
      #frozen: [Nat];
      #thawed: [Nat]; //need to thaw when going to TrixValueUnstable
     };
    #Floats: {
      #frozen: [Float];
      #thawed: [Float]; //need to thaw when going to CandyValueUnstable
    };
    #Bytes : {
      #frozen: [Nat8];
      #thawed: [Nat8]; //need to thaw when going to CandyValueUnstable
    };
    #Empty;
  };
type PropertyV1 = {name : Text; value : CandyValue; immutable : Bool};
let v1Shared : [CandyValue] = [
  #Int(-3), #Int8(-1), #Int16(2), #Int32(3), #Int64(4), #Nat(5), #Nat8(6), #Nat16(7), #Nat32(8), #Nat64(9),
  #Float(1.25), #Text("t"), #Bool(true), #Blob("\01\02"), #Principal(pr), #Option(null), #Option(?#Nat(1)), #Empty,
  #Array(#frozen([#Nat(1), #Text("a")])), #Array(#thawed([#Nat(2)])),
  #Nats(#frozen([1, 2])), #Nats(#thawed([3])), #Floats(#frozen([1.0])), #Floats(#thawed([2.0])),
  #Bytes(#frozen([1, 255])), #Bytes(#thawed([0])),
  #Class([{ name = "p"; value = #Nat(1); immutable = true }, { name = "q"; value = #Bytes(#frozen([7])); immutable = false }]),
];
for (v in v1Shared.vals()) {
  let v2 = Upgrade.upgradeCandyShared0_1_2_to_0_2_0(v);
  p("upgradeShared v1->v2 " # debug_show (v2));
  p("upgradeShared v2->v3 " # debug_show (Upgrade.upgradeCandyShared0_2_0_to_0_3_0(v2)));
};
// Structural copy of candy 0.1.12 CandyValueUnstable (no import, so the harness is identical in both envs).
  type CandyValueUnstable = {
    #Int :  Int;
    #Int8: Int8;
    #Int16: Int16;
    #Int32: Int32;
    #Int64: Int64;
    #Nat : Nat;
    #Nat8 : Nat8;
    #Nat16 : Nat16;
    #Nat32 : Nat32;
    #Nat64 : Nat64;
    #Float : Float;
    #Text : Text;
    #Bool : Bool;
    #Blob : Blob;
    #Class : [PropertyUnstable];
    #Principal : Principal;
    #Floats : {
      #frozen: [Float];
      #thawed: Buffer.Buffer<Float>;
    };
    #Nats: {
        #frozen: [Nat];
        #thawed: Buffer.Buffer<Nat>; //need to thaw when going to TrixValueUnstable
     };
    #Array : {
      #frozen: [CandyValueUnstable];
      #thawed: Buffer.Buffer<CandyValueUnstable>; //need to thaw when going to CandyValueUnstable
    };
    #Option : ?CandyValueUnstable;
    #Bytes : {
      #frozen: [Nat8];
      #thawed: Buffer.Buffer<Nat8>; //need to thaw when going to CandyValueUnstable
    };
    #Empty;
  };
type PropertyUnstable = {name : Text; value : CandyValueUnstable; immutable : Bool};
func bufOf<X>(xs : [X]) : Buffer.Buffer<X> { let b = Buffer.Buffer<X>(xs.size()); for (x in xs.vals()) b.add(x); b };
let v1Unstable : [CandyValueUnstable] = [
  #Int(-3), #Nat(5), #Nat64(9), #Float(1.25), #Text("t"), #Bool(false), #Blob("\01\02"), #Principal(pr), #Empty,
  #Option(?#Text("o")), #Array(#frozen([#Nat(1)])), #Array(#thawed(bufOf<CandyValueUnstable>([#Nat(2), #Text("b")]))),
  #Nats(#frozen([1, 2])), #Nats(#thawed(bufOf<Nat>([3, 4]))), #Floats(#thawed(bufOf<Float>([2.5]))),
  #Bytes(#frozen([1, 255])), #Bytes(#thawed(bufOf<Nat8>([0, 9]))),
  #Class([{ name = "p"; value = #Nat(1); immutable = true }, { name = "q"; value = #Text("v"); immutable = false }]),
];
for (v in v1Unstable.vals()) {
  let v2 = Upgrade.upgradeCandy0_1_2_to_0_2_0(v);
  p("upgrade v1->v2->v3 " # debug_show (Types.shareCandy(Upgrade.upgradeCandy0_2_0_to_0_3_0(v2))));
};

Debug.print("TOTAL lines=" # debug_show (lines + 1) # " hexCallSiteVectors=" # debug_show hexSites # " byteCases=" # debug_show (byteCases.size()) # " corpus=" # debug_show (corpus.size()));
