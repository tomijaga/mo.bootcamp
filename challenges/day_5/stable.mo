import Iter "mo:base/Iter";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";

actor{

    //dfx deploy day_5_stable to run 

    stable var mapEntries: [(Principal, Nat)] = [];
    let map = HashMap.fromIter<Principal, Nat>(mapEntries.vals(), 0, Principal.equal, Principal.hash);

    // challenge 3
    public shared ({caller})  func add_favorite_number(n: Nat): async () {
         map.put(caller, n)
    };

    public shared ({caller})  func show_favorite_number(): async ?Nat {
       switch(map.get(caller)){
           case (?num) ?num;
           case (_) null;
       }
    };

    // challenge 5
    public shared ({caller}) func update_favorite_number (n: Nat):  async Text{
        
        switch(map.get(caller)){
           case (?num) {map.put(caller, n); "Your number has been updated"};
           case (_) "You haven't registered your number";
       }
    };

    system func preupgrade() {
        mapEntries := Iter.toArray(map.entries());

    };

    system func postupgrade() {
        mapEntries := [];
    };
}