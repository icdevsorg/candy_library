/// Lowercase hexadecimal encoding of bytes -- exactly what `encoding` 0.4.1's `Hex.encode`
/// produced (two characters per byte, `0-9a-f`, in order). Candy used nothing else from that
/// package, and it pinned `mo:base-0.7.3`, which `mops sources` does not emit: every project
/// depending on candy (the ICRC-72 stack, among others) failed to build from a clean checkout.
import Array "mo:base/Array";
import Char "mo:base/Char";
import Nat8 "mo:base/Nat8";
import Text "mo:base/Text";

module {
  let digits : [Char] = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'];

  public func encode(bytes : [Nat8]) : Text {
    var out = "";
    for (b in bytes.vals()) {
      out #= Char.toText(digits[Nat8.toNat(b / 16)]) # Char.toText(digits[Nat8.toNat(b % 16)]);
    };
    out;
  };
};
