import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Result "mo:base/Result";
import Principal "mo:base/Principal";
import Hash "mo:base/Hash";
import Iter "mo:base/Iter";
import Array "mo:base/Array";
import Text "mo:base/Text";

import Types "types"
actor {

    // challenge 1
    // ./types.mo

    private stable var registryEntries:[(Types.TokenIndex, Principal)]  = [];

    //challenge 2
    private let registry:HashMap.HashMap<Types.TokenIndex, Principal> = HashMap.fromIter(registryEntries.vals(), registryEntries.size(), Nat.equal, Hash.hash);

    // challenge 3
    private stable var nextTokenIndex: Nat = 0;

    private func incrementTokenId(): Nat{
        let n = nextTokenIndex;
        nextTokenIndex +=1;
        n
    };

    private func is_anonymous(p:Principal): Bool{
        Principal.toText(p) == "2vxsx-fae"
    };

    public shared ({caller}) func mint(): async Result.Result<Nat, Types.Error>{
        if (is_anonymous(caller)){
            return #err(#ZeroAddress);
        };

        let tokenId = incrementTokenId();
        registry.put(tokenId, caller);
        return #ok tokenId;
    };

// challenge 4
    public shared ({caller}) func transfer (to: Principal, tokenIndex: Nat): async Result.Result<(), Types.Error>{
        if(is_anonymous(caller)){
            return #err(#ZeroAddress);
        };

        switch(registry.get(tokenIndex)){
            case(null){return #err(#NotFound)};
            case(?owner) {
                if(owner != caller){
                    return #err(#Unauthorized);
                };

               #ok( registry.put(tokenIndex, to));
            };
        };
    };

    //challenge 5
    public shared ({caller}) func balance (): async  Result.Result<[Types.TokenIndex], Types.Error>{
        if(is_anonymous(caller)){
            return #err(#ZeroAddress);
        };
        
        let entries = Iter.toArray(registry.entries());

       #ok( Array.mapFilter<(Types.TokenIndex, Principal), Types.TokenIndex>(entries, func(entry){
            
            if (entry.1 == caller){
                return ?entry.0;
            };

            return null;
        }))
    };

    
    public query func http_request(): async Types.Response{
       let owner = switch(registry.get(if (nextTokenIndex > 0) {nextTokenIndex - 1 }else{0})){
                case (?owner) {
                    Principal.toText(owner)
                };
                case (_){"2vxsx-fae"}
            };
       
        let text:Text = 
        "<html><head><title>Motoko Bootcamp: Daily Challenge 6  </title></head><body><h1>Total Nfts Minted: " 
        # Nat.toText(nextTokenIndex) # 
        "</h1><br/><h2>Last Minter: "
        #  owner #"</h2></body></html>";

        return {
            status_code = 200;
            headers = [];
            body = Text.encodeUtf8(text);
            streaming_strategy = null;
        };
    };

    system func preupgrade(){
        registryEntries := Iter.toArray(registry.entries());
    };

    system func postupgrade(){
        registryEntries:= [];
    };
}