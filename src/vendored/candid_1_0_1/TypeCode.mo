// Vendored into candy 0.3.2 from https://github.com/gekctek/motoko_candid at v1.0.1 (commit 4f0c445a4f998d4d07b616fafd463eea8f52e4bc), file src/TypeCode.mo.
// MIT License -- Copyright Ethan Celletti (gekctek / edjCase). The full license text is in NOTICE at the root of the candy package.
// Only `mo:` package imports were rewritten to relative paths; the code is otherwise unchanged.

module {
    public let _null = -1;
    public let bool = -2;
    public let nat = -3;
    public let int = -4;
    public let nat8 = -5;
    public let nat16 = -6;
    public let nat32 = -7;
    public let nat64 = -8;
    public let int8 = -9;
    public let int16 = -10;
    public let int32 = -11;
    public let int64 = -12;
    public let float32 = -13;
    public let float64 = -14;
    public let text = -15;
    public let reserved = -16;
    public let empty = -17;
    public let opt = -18;
    public let vector = -19;
    public let record = -20;
    public let variant = -21;
    public let _func = -22;
    public let service = -23;
    public let principal = -24;
}