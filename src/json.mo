/// JSON support for the candy library.
///
/// This module contains the utilities useful for handling JSON values.

import Buffer "mo:base/Buffer";
import Nat "mo:base/Nat";
import Nat16 "mo:base/Nat16";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Nat8 "mo:base/Nat8";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Int8 "mo:base/Int8";
import Int16 "mo:base/Int16";
import Int32 "mo:base/Int32";
import Int64 "mo:base/Int64";
import Bool "mo:base/Bool";
import Blob "mo:base/Blob";
import Principal "mo:base/Principal";
import Text "mo:base/Text";

import Types "types";
import Hex "mo:encoding_0_4_1/Hex";

module {
  /// Convert `CandyShared` to JSON format as `Text`.
  ///
  /// Example:
  /// ```motoko include=import
  /// let val: CandyShared = #Option(?#Principal(Principal.fromText("xyz")));
  /// let val_as_json = Json.value_to_json(val);
  /// ```
  public func value_to_json(val: Types.CandyShared): Text {
      switch(val){
        //nat
        case(#Nat(val)){ Nat.toText(val)};
        case(#Nat64(val)){ Nat64.toText(val)};
        case(#Nat32(val)){ Nat32.toText(val)};
        case(#Nat16(val)){ Nat16.toText(val)};
        case(#Nat8(val)){ Nat8.toText(val)};
        //text
        case(#Text(val)){ "\"" # val # "\""; };
        //class
        case(#Class(val)){
          var body: Buffer.Buffer<Text> = Buffer.Buffer<Text>(1);
          for(this_item in val.vals()){
              body.add("\"" # this_item.name # "\"" # ":" # value_to_json(this_item.value));
          };
          return "{" # Text.join(",", body.vals()) # "}";
        };
        //array
        case(#Array(val)){
          var body: Buffer.Buffer<Text> = Buffer.Buffer<Text>(1);
          for(this_item in val.vals()){
              body.add(value_to_json(this_item));
          };
          return "[" # Text.join(",", body.vals()) # "]";  
        };
        case(#Option(val)){
          switch(val){
            case(null){"null";};
            case(?val){value_to_json(val);}
          }
        };
        case(#Nats(val)){
          var body: Buffer.Buffer<Text> = Buffer.Buffer<Text>(1);
          for(this_item in val.vals()){
              body.add(Nat.toText(this_item));
          };
          return "[" # Text.join(",", body.vals()) # "]";
        };
        case(#Ints(val)){
          var body: Buffer.Buffer<Text> = Buffer.Buffer<Text>(1);
          for(this_item in val.vals()){
              body.add(Int.toText(this_item));
          };
          return "[" # Text.join(",", body.vals()) # "]";
        };
        case(#Floats(val)){
          var body: Buffer.Buffer<Text> = Buffer.Buffer<Text>(1);
          for(this_item in val.vals()){
            body.add(Float.format(#exact, this_item));
          };
          return "[" # Text.join(",", body.vals()) # "]";
        };
        //bytes
        case(#Bytes(val)){
          return "\"" # Hex.encode(val) # "\"";//CandyHex.encode(val);
        };
        //bytes
        case(#Blob(val)){
          return "\"" # Hex.encode(Blob.toArray(val)) # "\"";//CandyHex.encode(val);
        };
        //principal
        case(#Principal(val)){ "\"" # Principal.toText(val) # "\"";};
        //bool	
        case(#Bool(val)){ "\"" # Bool.toText(val) # "\"";};	
        //float	
        case(#Float(val)){ Float.format(#exact, val)};
        case(#Int(val)){Int.toText(val);};
        case(#Int64(val)){Int64.toText(val);};
        case(#Int32(val)){Int32.toText(val);};
        case(#Int16(val)){Int16.toText(val);};
        case(#Int8(val)){Int8.toText(val);};
        case(_){"";};
      };
  };
};
