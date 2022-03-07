import Nat8 "mo:base/Nat8";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";
import Char "mo:base/Char";
import List "mo:base/List";
import Text "mo:base/Text";
import HashMap "mo:base/HashMap";

import Utils "../utils";

actor {
    // challenge 1
    public query func nat_to_nat8(n: Nat): async Nat8 {
        Nat8.fromNat(n %  2**8)
    };

    // challenge 2
    public query func max_number_with_n_bits(n: Nat8): async Nat {
        var as_nat: Nat = Nat8.toNat(n);

        return(2 ** as_nat) - 1;
    };


    // challenge 3
    public query func decimal_to_bits(n: Nat): async Text{
        var num = n;
        var binary = "";

        while(num > 0){
            binary :=   (if (num % 2 == 0) {"0"} else {"1"}) # binary;
            num:= num/2;
        };

        binary
    };


    func char_to_uppercase(c: Char): Char{
        if (Char.isLowercase(c)){
            let n = Char.toNat32(c);

            //difference between the nat32 values of 'a' and 'A'
            let diff:Nat32 = 32;
            return Char.fromNat32( n - diff);
        };
        return c;
    };

    // challenge 4
    public query func capitalize_character(c: Char): async Char{
        return char_to_uppercase(c);
    };

    // challenge 5
     public query func capitalize_text(t: Text): async Text{
         var cap = "";

        for (c in t.chars()){
            cap:= cap # Char.toText(char_to_uppercase(c));
        };

        return cap;
    };

    // challenge 6
     public query func is_inside(t: Text, c: Char): async Bool{

        for (char in t.chars()){
            if (c == char){
                return true;
            };
        };

        return false;
    };

    // challenge 7
     public query func trim_whitespace(t: Text): async Text{
        Text.trim(t, #char ' ')
    };
    
    // challenge 8
     public query func duplicated_character(t: Text): async Text{
        let n = t.size();

        var map = HashMap.HashMap<Char, Char>(
                    n, 
                    func (c1 : Char, c2 : Char) : Bool  = c1 == c2, 
                    Char.toNat32
                    );

        for (c in t.chars()){
            switch ( map.get(c)) {
                case (?char) return Char.toText(char);
                case (_) map.put(c, c);
            };
        };

        return t;
    };

    // challenge 9
    public query func size_in_bytes(t: Text):  async Nat{
        Text.encodeUtf8(t).size()
    };

    // challenge 10
    public query func bubble_sort(arr: [Nat]):async [Nat]{
        let size = arr.size();

        if (size < 2) return arr;

        var arrMut = List.toVarArray<Nat>(List.fromArray<Nat>(arr));


        for(_ in Iter.range(0, size-1)){
            for (i in Iter.range(0, size-2)){
                let j = i+1;

                if (arrMut[i] > arrMut[j]) {
                  let _ =  Utils.swapElemsInArray<Nat>(arrMut, i, j);
                };
            };
            // Debug.print(Utils.format("arr = {}", [#natArrayMut arrMut]));
        };

        Array.freeze(arrMut);
    }
}