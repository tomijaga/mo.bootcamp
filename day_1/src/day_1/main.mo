import Iter "mo:base/Iter";
import Buffer "mo:base/Buffer";
import List "mo:base/List";
import Nat_Lb "mo:base/Nat";
import Debug "mo:base/Debug";
import Array "mo:base/Array";

import Format "../../../utils/src/utils/format";

actor {
    // challenge 1
    public query func  add(n1: Nat, n2: Nat): async Nat {
        return n1 + n2;
    };

    // challenge 2
    public query func  square(n: Nat32): async Nat32 {
        return n * n;
    };

    // challenge 3
    public query func  days_to_second(days: Nat): async Nat {
        return days * 24 * 3600;
    };

    // challenge 4
    var count: Nat = 0;

    public func increment_counter(): async Nat {
        count:= count + 1;
        return count;
    };

    public func clear_counter(): async Nat {
        count:=0;
        return count;
    };

    // challenge 5
    private func divisible(n: Nat, divisor: Nat): Bool{
        return n% divisor == 0;
    };

    public query func divide(n: Nat, divisor: Nat): async Bool {
        return divisible(n, divisor);
    };

    // challenge 6
    public query func is_even(n: Nat): async Bool {
        return divisible(n, 2);
    };

    // challenge 7
    public query func sum_of_array(arr: [Nat]): async Nat {
        if (arr.size() == 0) return 0;

        var sum  = 0;

        for (n in arr.vals()) {
            sum := sum + n;
        };

        return sum;
    };

    // challenge 8
    public query func maximum(arr: [Nat]): async Nat {
        var max:Nat = 0;

        for (n in arr.vals()) {
            if (n > max){
                max := n;
            }
        };

        return max;
    };

    // challenge 9
    public query func remove_from_array(arr: [Nat], n: Nat): async [Nat] {
        var newBuf:Buffer.Buffer<Nat> = Buffer.Buffer<Nat>(arr.size());

        for (n1 in arr.vals()) {
            if (n1 != n){
                newBuf.add(n1);
            }
        };

        return newBuf.toArray();
    };

    // challenge 10
     public query func selection_sort(arr: [Nat]): async [Nat] {
        let n = arr.size();
        if (n < 2) return arr ;

        var arrMut = List.toVarArray<Nat>(List.fromArray<Nat>(arr));

        func swap(arr: [var Nat], i: Nat, j: Nat){
            let temp = arr[i];
            arr[i]:= arr[j];
            arr[j]:= temp;
        };

        let lastIndex =  arr.size()-1;

        for (i in Iter.range(0, lastIndex)) {
            var min:Nat = arrMut[i];
            var minIndex:Nat = i;

            let n1 = arrMut[i];

                for (j in Iter.range(i + 1, lastIndex)) {
                    let n = arrMut[j];
                    
                    if (n <  min) {
                        min:= n;
                        minIndex:= j;
                    };
                };  
                
            swap(arrMut, i, minIndex);
            Debug.print(Format.format("i = {}, min = {}, arr = {}", [#nat i, #nat minIndex, #natArrayMut arrMut]));

        };

        return Array.freeze(arrMut);
    };
};
