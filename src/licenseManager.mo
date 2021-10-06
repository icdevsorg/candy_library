///////////////////////////////
//
// ©2021 @aramakme
//
// This code is released with an ARAMAKME SUPPORT license v0.1.  The ARAMAKME SUPPORT license v0.1 provides the following rights:
//    Usage: You may use this library provided that you follow the following restrictions:
//         - you use it in support of an ARAMAKME license v0.1 or later
//         - use of this library outside of an ARAMAKME license is prohibited without the express written and cryptographically signed consent of the copyright holder
//    Commercial Use: You may use this library commecially provided you follow all stipulations under Usage
//    Modificatoins: You may modify this code as long as any modified libraries are also released under the
//         ARAMAKME SUPPORT v0.1 license and maintain sending a license_follow_rights_pecent to the stipulated license_canister configuration
//         and as long as no future modifier demands more than the license_follow_rights_percent remaining rights.
//    Merging: You may merge this code with another library as long as both are released with an ARAMAKME SUPPORT v0.1 liscense
//    License Version Update: Only the copyright holder may update the license.
//    Publishing and distribution:  You may publish and distribute this library as text and source code as long as this license in included in the text.  Any binary
//         publication must include this license in the documentation. Any user levraging the published library must also adhere to this
//         license.
//    Selling Copies:  You may sell copies of this library as long as this license is disclosed to any buyer and provided that the buyer
//         agrees, subject to penalty of law, to adhere to this license. The seller must provide a schedule to the buyer of expected ongoing
//         costs expected in the operation of the code.
//    Sublicensing: This software may be sub-licenesed as part of a larger license provided this license is disclosed to any licesee and provided that the licesee
//         agrees, subject to penalty of law, to adhere to this license. The licensor must provide a schedule to the buyer of expected ongoing
//         costs expected in the operation of the code.
//    Usage tracking: You grant the canisters in license_canister the right to track calls and data about calls to the
//          update_license function. This data may be used to track usage and provide refunds based on that usage.
//    License Updates: The liscensor reserves the right to change the configuration of the parameters of this license if the cost structure or topograph of
//          of the Internet Computer changes.
//    Redistribution: 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the
//          disclaimer at the end of the license.  2. Redistributions in binary form must reproduce the above copyright notice,
//          this list of conditions and the following disclaimer in the documentation and/or other materials provided with the
//          distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,
// BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
// SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
// OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// OFAC Compliance: Licensee agrees that they are currently in compliance with and shall at all times during the term of this Agreement (including any extension thereof) remain in
// compliance with the regulations of OFAC (including those named on OFAC’s Specially Designated Nationals and Blocked Persons List) and any statute, executive order (including the
// September 24, 2001, Executive Order Blocking Property and Prohibiting Transactions with Persons Who Commit, Threaten to Commit, or Support Terrorism), or other governmental action
// relating thereto. Further licensee will apply this same OFAC compliance clause to any distribution partner or user of this software. Violation of this clause will result in a license
// restriction and revocation.
///////////////////////////////

import Debug "mo:base/Debug";
import Hash "mo:base/Hash";
import Int "mo:base/Int";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Principal "mo:principal/Principal";
import Time "mo:base/Time";
import Cycles "mo:base/ExperimentalCycles";

module {
    public type LicenseCanisterEntry = {
        canister: Text;
        percent: Float;
        distribution_license: ?Text;
    };

    public type LicenseManagerConfig = {
        min_license_rate: Nat;
        license_discount_per_check_percent: Float;
        license_rate_reset : Nat;
        license_overrun_grace_periods: Nat;
        license_check_cycles : Nat;
        license_canister : [LicenseCanisterEntry];
    };

    public type LicenseInfo = {
        min_license_rate: Nat;
        license_discount_per_check_percent: Float;
        license_rate_reset : Nat;
        license_overrun_grace_periods: Nat;
        license_check_cycles : Nat;
        license_canister : [LicenseCanisterEntry];
        calls_since_license_check: Nat;
        license_check_at: Nat;
        license_check_reset_at: Int;
        bInit: Bool;
        cycles_sent_since_last_upgrade: Nat;
        cycles_refunded_since_last_upgrade: Nat;
    };

    public class LicenseManager(_config : LicenseManagerConfig){
        public let config = _config;

        private var calls_since_license_check : Nat = 0;
        private var license_check_at : Nat = config.min_license_rate;
        private var license_check_reset_at : Int = 0;
        private var bInit : Bool = false;
        private var cycles_refunded_since_last_upgrade : Nat = 0;
        private var cycles_sent_since_last_upgrade: Nat = 0;



        public func get_license_info() : LicenseInfo {
            {
                min_license_rate = config.min_license_rate;
                license_discount_per_check_percent = config.license_discount_per_check_percent ;
                license_rate_reset = config.license_rate_reset;
                license_overrun_grace_periods = config.license_overrun_grace_periods;
                license_check_cycles = config.license_check_cycles;
                license_canister = config.license_canister;
                calls_since_license_check = calls_since_license_check;
                license_check_at = license_check_at;
                license_check_reset_at = license_check_reset_at;
                bInit = bInit;
                cycles_sent_since_last_upgrade = cycles_sent_since_last_upgrade;
                cycles_refunded_since_last_upgrade = cycles_sent_since_last_upgrade;
            };
        };


        public func check_license(){
            //100x min_calls should be enough to fit inside of all possible messages
            //after 100x min_calls, the library will stop working
            assert(license_check_at * config.license_overrun_grace_periods > calls_since_license_check );
            calls_since_license_check += 1;
        };

        //allows for counting checks at a higher ratio
        public func check_license_n(x : Nat){
            //10_000_000 call should be enough to fit inside of all possible messages
            //after 10_000_000 calls, the library will stop working
            assert(license_check_at * config.license_overrun_grace_periods > calls_since_license_check );
            calls_since_license_check += x;
        };

        public func license_ready() : Bool{
            //will become true when you are eligible to get a discount on your next license block
            (calls_since_license_check  > license_check_at) or (bInit == false);
        };

        public func fix_checks(x : Nat){
            //some checks are greedy. Fix that
            if(calls_since_license_check > x){
                calls_since_license_check -= x;
            } else {
                calls_since_license_check := 0;
            };
        };

        public func update_license() : async (){
            //the more you call this, the more discount you get on your next chunk of calls

            //pick license server:
            //we are not using true randomness because it would cause an additional await
            //the likelyhood of a node exploiting this is low. If it becomes a problem, then change to use random beacon
            //It also assumes that the native hash function is equally distributed which I think I read is not the case.
            let rnd = Nat32.toNat(Hash.hash(Int.abs(Time.now()) % 4_294_967_295)) % 1_000_000;
            var tracker = 0;
            var license_server : actor {__updateLicense: (Nat, ?Text) -> async Bool} = actor(config.license_canister[0].canister);
            var distribution_license : ?Text = null;

            label selector for(thisItem in config.license_canister.vals()){
                let threshhold = tracker + Int.abs(Float.toInt(Float.floor((thisItem.percent * 10_000))));
                if(rnd < threshhold){
                    license_server := actor(thisItem.canister);
                    distribution_license := thisItem.distribution_license;
                    break selector;
                };
                tracker := threshhold;
            };

            if(bInit == false){
                //init the license
                license_check_reset_at := Time.now() + config.license_rate_reset : Int; //one month
                //first time through, send an amount
                Cycles.add(config.license_check_cycles);
                let result = license_server.__updateLicense(0, distribution_license);  //zero lets us know it was an upgrade
                cycles_sent_since_last_upgrade += config.license_check_cycles;
                cycles_refunded_since_last_upgrade += Cycles.refunded();
                bInit := true;
            };

            //called first in case we are closing out the month
            if(calls_since_license_check > license_check_at){
                //if you have gone over the license check, send us a buck for each multiple over
                Cycles.add((config.license_check_cycles * calls_since_license_check)/license_check_at);
                let result = license_server.__updateLicense(calls_since_license_check, distribution_license);
                cycles_sent_since_last_upgrade += (config.license_check_cycles * calls_since_license_check)/license_check_at;
                cycles_refunded_since_last_upgrade += Cycles.refunded();
                calls_since_license_check := 0;
                license_check_at := Int.abs(Float.toInt(Float.fromInt(license_check_at) * (1 + (config.license_discount_per_check_percent/100:Float))));
            };

            //called to start out a new month
            if(Time.now() > license_check_reset_at){
                //every month you pay about a buck and reset your call count and check_at
                if(calls_since_license_check < license_check_at){ calls_since_license_check := license_check_at};
                Cycles.add(config.license_check_cycles);

                let result = license_server.__updateLicense(calls_since_license_check, distribution_license);
                cycles_sent_since_last_upgrade += config.license_check_cycles;
                cycles_refunded_since_last_upgrade += Cycles.refunded();

                calls_since_license_check := 0;
                license_check_at := config.min_license_rate;
            };

            return;
        };
    };

};
