
import C "mo:matchers/Canister";
import M "mo:matchers/Matchers";
import T "mo:matchers/Testable";
import S "mo:matchers/Suite";
import Debug "mo:base/Debug";
import Principal "mo:base/Principal";

import Types "../src/types";
import Clone "../src/clone";
import Conversion "../src/conversion";
import Properties "../src/properties";
import Workspace "../src/workspace";




shared (deployer) actor class test_runner() = this {
    let it = C.Tester({ batchSize = 8 });

    

    public shared func test() : async {#success; #fail : Text} {

        let suite = S.suite("test candy", [
                    //test getting witness returns empty if no witness
                    S.test("testConversions", switch(await testConversions()){case(#success){true};case(_){false};}, M.equals<Bool>(T.bool(true))),
                    
                ]);
        S.run(suite);

        return #success;
    };

    public shared func testConversions() : async {#success; #fail : Text} {
        Debug.print("running testConversions");

        let owner = Principal.toText(deployer.caller);

        let suite = S.suite("test conversion", [
            S.test("Nat8 is Nat", Conversion.valueToNat(#Nat8(10)), M.equals<Nat>(T.nat(10))),
            S.test("Nat16 is Nat", Conversion.valueToNat(#Nat16(10)), M.equals<Nat>(T.nat(10))),
            S.test("Nat32 is Nat", Conversion.valueToNat(#Nat32(10)), M.equals<Nat>(T.nat(10))),
            S.test("Nat64 is Nat", Conversion.valueToNat(#Nat64(10)), M.equals<Nat>(T.nat(10))),
            S.test("Nat8 is Text", Conversion.valueToText(#Nat8(10)), M.equals<Text>(T.text("10"))),
            S.test("Nat16 is Text", Conversion.valueToText(#Nat16(10)), M.equals<Text>(T.text("10"))),
            S.test("Nat32 is Text", Conversion.valueToText(#Nat32(10)), M.equals<Text>(T.text("10"))),
            S.test("Nat64 is Text", Conversion.valueToText(#Nat64(10)), M.equals<Text>(T.text("10")))
        ]);

        S.run(suite);

        return #success;
        

        return #success;
          

    };

    
}