///////////////////////////////
//
// ©2021 @aramakme
//
// This code is released with an ARAMAKME SOFTWARE License v0.1.  The ARAMAKME SOFTWARE license v0.1 provides the following rights:
//    Usage: You may use this library provided that you follow the following restrictions:
//         - you do not remove or modify the license payment code
//         - you do not modify the receiving license_canister configuration except to indicate a selected distribution license
//         - you pay the license_check_cycles fee via code operation at least once every license_rate_reset nanoseconds
//         - you pay the license_check_cycles fee via code operation at least once every license_overrun_grace_periods
//    Commercial Use: You may use this library commercially provided you follow all stipulations under Usage
//    Modifications: You may modify this code as long as any modified libraries are also released under the
//         ARAMAKME v0.1 license and maintain sending a license_follow_rights_pecent to the stipulated license_canister configuration
//         and as long as no future modifier demands more than the license_follow_rights_percent remaining rights.
//    Merging: You may merge this library with another library provided you follow the following restrictions:
//         - you do not remove or modify the license payment code for existing functions
//         - you do not modify the receiving license_canister configuration
//         - you pay the license_check_cycles fee via code operation at least once every license_rate_reset nanoseconds for existing functions
//         - you pay the license_check_cycles fee via code operation at least once every min_license_rate, or rate dictated by the existing code execution for existing functions
//         - any new functions follow the license stipulations under "Modifications"
//    Publishing and distribution:  You may publish and distribute this library as text and source code as long as this license is included in the text.  Any binary
//         publication must include this license in the documentation. Any user leveraging the published library must also adhere to this
//         license.
//    Selling Copies:  You may sell copies of this library as long as this license is disclosed to any buyer and provided that the buyer
//         agrees, subject to the penalty of law, to adhere to this license. The seller must provide a schedule to the buyer of expected ongoing
//         costs expected in the operation of the code.
//    Sublicensing: This software may be sub-licensed as part of a larger license provided this license is disclosed to any licensee and provided that the licensee
//         agrees, subject to the penalty of law, to adhere to this license. The licensor must provide a schedule to the buyer of expected ongoing
//         costs expected in the operation of the code.
//    Canister Upgrades:  Canister upgrades will reset the library to the min_license_rate and require a update_license call.
//    Usage tracking: You grant the canisters in license_canister the right to track calls and data about calls to the
//          update_license function. This data may be used to track usage and provide refunds based on that usage.
//    License Updates: The licensor reserves the right to change the configuration of the parameters of this license if the cost structure or topography of
//          of the Internet Computer changes.
//    Redistribution: 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the
//          disclaimer at the end of the license.  2. Redistributions in binary form must reproduce the above copyright notice,
//          this list of conditions and the following disclaimer in the documentation and/or other materials provided with the
//          distribution.
//    Payment for Use: The use of this software requires the periodic payment of license fees to a licensors and an optional distribution licensor.
//          Licensors have the responsibility of ensuring the continued operation of, improvement of, and promotion of the software.  Any transfer of a Licensor's distribution license
//          requires that the transfer of all responsibilities and obligations to the new owner.  Distribution licensors are expected to propose and support
//          improvements to the library. Original licensors are expected to update and improve the library as is necessary for technical operation and commercial usefulness of
//          the library.
//    Completeness:  This library is considered complete.  Any payments for distribution licenses should be considered to be for the restricted operation of this current library
//          and there should be no expectation of remuneration beyond what is required for the fulfillment of the distribution laid out in the ARAMAKME DISTRIBUTION LICENSE v0.1 license.
//          Future improvements to the library and operation rights are not guaranteed.
//    Collusion: The licensee agrees to not collude with other license holders to bypass the code or payment requirements of this license.
//
// This library is released withe ARAMAKME license v0.1 with the following parameters:
// license_check_cycles: 714_285_714_286
// license_rate_reset: 2_628_000_000_000_000
// min_license_rate: 100_000
// canister_min_cycles: 10_000_000_000_000
// license_discount_per_check_percent: 25
// license_follow_rights_percent: 20
// license_overrun_grace_periods: 100
// license_canister:
//      (q4eej-kyaaa-aaaaa-aaaha-cai, null) : 100

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

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
import Principal "mo:principal/Principal";
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
import Hex "./hex";
import LicenseManager "./licenseManager";

*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
    };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
    };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
    };

    //a data chunk should be no larger than 2MB so that it can be shipped to other canisters
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

    //stable
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };
*********  This line has not been unlocked  **********
    };

    //unstable
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };
*********  This line has not been unlocked  **********
    };

    ////////////////////////////////////
    //
    // The the following stable types were copied from departurelabs' property.mo.  They work as a plug and play
    // here with CandyValue.
    //
    // https://github.com/DepartureLabsIC/non-fungible-token/blob/main/src/property.mo
    //
    // The following section is issued under the MIT License Copyright (c) 2021 Departure Labs:
    ///////////////////////////////////

    public type Property = {name : Text; value : CandyValue; immutable : Bool};

*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
    };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
    };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
    };

    // Specifies the properties that should be updated to a certain value.
    public type UpdateRequest = {
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
    };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
    };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
    };

    ///////////////////////////////////
    //
    // End departurelabs' property.mo types
    //
    // Code below resumes the ARAMAKME SOFTWARE License
    //
    ///////////////////////////////////



*********  This line has not been unlocked  **********


        // set up the licenseManager for the ARAMAKME License
        public let __licenseManager = LicenseManager.LicenseManager(licenseConfig);


*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
            m;
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
*********  This line has not been unlocked  **********
        };


        // Returns a subset of from properties based on the given query.
        // NOTE: ignores unknown properties.
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        // Query contained an unknown property.
*********  This line has not been unlocked  **********
                    };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                                    // Return every sub-attribute attribute.
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                                    };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                                };
                            };
*********  This line has not been unlocked  **********
                                // Not possible to get sub-attribute of a non-class property.
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                                };
*********  This line has not been unlocked  **********
                            };
                        }
                    };
                };
            };
*********  This line has not been unlocked  **********
        };

        // Updates the given properties based on the given update query.
        // NOTE: creates unknown properties.
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        // Update contained an unknown property, so it gets created.
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
                        };
                    };
*********  This line has not been unlocked  **********
                        // Can not update immutable property.
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                                        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                                    };
*********  This line has not been unlocked  **********
                                        // Not possible to update sub-attribute of a non-class property.
*********  This line has not been unlocked  **********
                                    };
                                };
*********  This line has not been unlocked  **********
                            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
                        };
                    };
                };
            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };



        //todo: generic accesors

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                };
                //blob
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
                //class
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********


                };
                //principal
*********  This line has not been unlocked  **********
                //array
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
                    };
                };
                //floats
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
                    };
                };
                //bytes
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
                    };
                };
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                case(#Bool(val)){val};
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

                    }
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
                //todo: could add all conversions here
*********  This line has not been unlocked  **********
            };
        };

        //gets the array of candy values out of an array
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                };
                //todo: could add all conversions here
*********  This line has not been unlocked  **********
            };
        };

        //unstable getters
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                };
                //blob
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
                //class
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********


                };
                //principal
*********  This line has not been unlocked  **********
                //array
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
                    };
                };
                //floats
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
                    };
                };
                //bytes
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
                    };
                };
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

                    }
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
                //todo: could add all conversions here
*********  This line has not been unlocked  **********
            };
        };

        //gets the array of candy values out of an array
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                };
                //todo: could add all conversions here
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            }
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            }
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

                        };
*********  This line has not been unlocked  **********
                    };
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
*********  This line has not been unlocked  **********
                    };
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
            };
        };


*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
                    }
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                }
            };
        };


*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        }
                    };
                };
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        }
                    };
                };
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            }
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            }
        };

        public func stabalizeValue(item : CandyValueUnstable) : CandyValue{
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                };
*********  This line has not been unlocked  **********
            }
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                };
*********  This line has not been unlocked  **********
            }
        };

        //////////////////////////////////////////////////////////////////////
        // The following functions easily creates a buffer from an arry of any type
        //////////////////////////////////////////////////////////////////////

        public func toBuffer<T>(x :[T]) : Buffer.Buffer<T>{
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
*********  This line has not been unlocked  **********
        };

        //////////////////////////////////////////////////////////////////////
        // The following functions converst standard types to Byte arrays
        // From there you can easily get to blobs if necessary with the Blob package
        //////////////////////////////////////////////////////////////////////

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };

        /// Returns [Nat8] of size 4 of the Nat16
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };


*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
            };
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
            };
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };

*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
*********  This line has not been unlocked  **********
        };

        //////////////////////////////////////////////////////////////////////
        // The following functions enable the inspection and manipulation of workspaces
        // Workspaces are valueble when using orthogonal persistance to keep track of data
        // in a format that is easily transmitable across the wire given IC restrictions
        //////////////////////////////////////////////////////////////////////

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
*********  This line has not been unlocked  **********

        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };

        //variants take up 2 bytes as long as there are fewer than 32 item in the enum
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                    a;
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    }
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            var size = 0;
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
                    };
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                };
*********  This line has not been unlocked  **********
            };

*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                    a;
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    }
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
                    };
                };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };
                };
*********  This line has not been unlocked  **********
            };
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********


        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

        };

        public func workspaceToAddressedChunkArray(x : Workspace) : AddressedChunkArray {
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
        };

        public func workspaceDeepClone(x : Workspace) : Workspace {
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
            };
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
                    //zone exist
*********  This line has not been unlocked  **********
                    //append zone

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };

                };

*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
                    //zone exists
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    //append zone

*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
                        //we know the size

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
*********  This line has not been unlocked  **********
                    };
                    //return thisZone.get(thisChunk.1);
                };


            };

*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********


*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                //calc bytes
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        {
                            //went over bytes

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
                        };
                        //adding some bytes
*********  This line has not been unlocked  **********
                    };
                };

            };

*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********


        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                //calc bytes
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        {
                            //went over bytes
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
*********  This line has not been unlocked  **********
                            //add it to our return
*********  This line has not been unlocked  **********

                        };

*********  This line has not been unlocked  **********
                    };
                };

*********  This line has not been unlocked  **********
            };

*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                }
            };
*********  This line has not been unlocked  **********
        };



*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
                    };
                    //couldnt find name in class
*********  This line has not been unlocked  **********
                    //unreachable
*********  This line has not been unlocked  **********

                };
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
                    //unreachable
*********  This line has not been unlocked  **********
                }

            };

        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };

*********  This line has not been unlocked  **********
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };

        public func flattenAddressedChunkArray(data : AddressedChunkArray) : [Nat8]{
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                    };

            };
*********  This line has not been unlocked  **********


        };

        ////////////////////////////////////
        //
        // The following functions were copied from departurelabs' property.mo.  They work as a plug and play
        // here with CandyValue and CandyValueUnstable.
        //
        // https://github.com/DepartureLabsIC/non-fungible-token/blob/main/src/property.mo
        //
        // The following lines are issued under the MIT License Copyright (c) 2021 Departure Labs:
        //
        ///////////////////////////////////

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
            m;
        };

*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
            };
*********  This line has not been unlocked  **********
        };

        // Returns a subset of from properties based on the given query.
        // NOTE: ignores unknown properties.
        public func getProperties(properties : Properties, qs : [Query]) : Result.Result<Properties, PropertyError> {
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        // Query contained an unknown property.
*********  This line has not been unlocked  **********
                    };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                                    // Return every sub-attribute attribute.
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                                    };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                                };
                            };
*********  This line has not been unlocked  **********
                                // Not possible to get sub-attribute of a non-class property.
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                                };
*********  This line has not been unlocked  **********
                            };
                        }
                    };
                };
            };
*********  This line has not been unlocked  **********
        };

        // Updates the given properties based on the given update query.
        // NOTE: creates unknown properties.
        public func updateProperties(properties : Properties, us : [Update]) : Result.Result<Properties, PropertyError> {
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        // Update contained an unknown property, so it gets created.
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                                };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
                        };
                    };
*********  This line has not been unlocked  **********
                        // Can not update immutable property.
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                                        };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                                    };
*********  This line has not been unlocked  **********
                                        // Not possible to update sub-attribute of a non-class property.
*********  This line has not been unlocked  **********
                                    };
                                };
*********  This line has not been unlocked  **********
                            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
                            };
                        };
                    };
                };
            };
*********  This line has not been unlocked  **********
*********  This line has not been unlocked  **********
        };

        ////////////////////////////////////
        //
        // End code from Departure labs property.mo
        //
        ///////////////////////////////////
    };


};
