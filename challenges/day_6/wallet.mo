import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Result "mo:base/Result";
import Principal "mo:base/Principal";

import Types "types";

actor {

    let nft_canister : actor { mint : () -> async Result.Result<Nat, Types.Error>} = actor("renrk-eyaaa-aaaaa-aaada-cai");
    
    public func mint() : async Result.Result<Nat, Types.Error> {
        return(await nft_canister.mint())
    };
}