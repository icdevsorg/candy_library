
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
import Candid "../src/candid";




shared (deployer) actor class test_runner() = this {
    let it = C.Tester({ batchSize = 8 });

    

    public shared func test() : async {#success; #fail : Text} {

        let suite = S.suite("test nft", [
                    //test getting witness returns empty if no witness
                    S.test("testOwner", switch(await testConversions()){case(#success){true};case(_){false};}, M.equals<Bool>(T.bool(true))),
                    
                ]);
        S.run(suite);

        return #success;
    };

    // US.2
    // US.3
    public shared func testConversions() : async {#success; #fail : Text} {
        Debug.print("running testOwner");

        let owner = Principal.toText(deployer.caller);

        let suite = S.suite("test conversion", [

            S.test("Nat32 is Nat", Conversion.candySharedToNat(#Nat32(10)), M.equals<Nat>(T.nat(10)))
        ]);

        S.run(suite);

        return #success;
        

        return #success;
          

    };

    public shared func testRefernece() : async Types.CandyShared {
        Debug.print("running testRefernece");

     
        

        return #Option(null);
          

    };

    
}