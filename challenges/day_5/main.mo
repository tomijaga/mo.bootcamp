import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Cycles "mo:base/ExperimentalCycles";

actor {
    // challenge 1
    public query ({caller}) func is_anonymous(): async Bool{
        Principal.toText(caller) == "2vxsx-fae"
    };

    // challenge 2
    let map = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

    // challenge 3
    public shared ({caller})  func add_favorite_number(n: Nat): async () {
         map.put(caller, n)
    };

    public query ({caller})  func show_favorite_number(): async ?Nat {
       switch(map.get(caller)){
           case (?num) ?num;
           case (_) null;
       }
    };

    // challenge 4
    public shared ({caller}) func add_favorite_number_2(n: Nat): async Text {
       switch(map.get(caller)){
           case (null) {map.put(caller, n); "Your number has been added"};
           case (?num) "You've already registered your number";
       }
    };

    // challenge 5
    public shared ({caller})  func update_favorite_number (n: Nat):  async Text{
        switch(map.get(caller)){
           case (?num) {map.put(caller, n); "Your number has been updated"};
           case (_) "You haven't registered your number";
       }
    };

     public shared ({caller})  func delete_favorite_number ():  async Text{
        switch(map.get(caller)){
           case (?num) {
               ignore map.remove(caller);
               "Your number has been deleted"
            };
           case (_) "You haven't registered your number";
       }
    };

    // challenge 6
    public shared func deposit_cycles(): async Nat{
        let msg_cycles = Cycles.available();
        Cycles.accept(msg_cycles);
    };

    // // challenge 7
    // public shared ({caller}) func withdraw_cycles(n: Nat):{
    //     deposit_cycles(n);
    // };

    stable var counter: Nat = 0;

    public func increment_counter(): async () {
        counter:= counter + 1;
    };

    public func show_counter(): async Nat{
        counter
    };

    stable var version_number = 0;

    system func postupgrade() {
        version_number:= version_number + 1;
    };
    
}

