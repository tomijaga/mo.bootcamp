import Buffer "mo:base/Buffer";
import Iter "mo:base/Iter";
import Option "mo:base/Option";
import Array "mo:base/Array";


actor {

    // challenge 1
    func swap<T>(arr: [var T], i: Nat, j: Nat): [var T] {
        let temp = arr[i];
        arr[i] := arr[j];
        arr[j] := temp;

        return arr;
    };

    // challenge 2
    public query func init_count(n: Nat): async [Nat]{
       return Iter.toArray<Nat>(Iter.range(0, n-1));
    };

    // challenge 3
    public query func seven(arr: [Nat]): async Text{
        for (i in arr.vals()){
            if ( i == 7){
                return "Seven is found";
            };
        };

        return "Seven not found";
    };

    // challenge 4
    public query func nat_opt_to_nat(n:?Nat, m: Nat): async Nat{
        return Option.get(n, m);
    };

    // challenge 5
    public query func day_of_the_week(n: Nat): async ?Text{
        if(n >= 1 and n <= 7){
            let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
            return ?days[n-1];
        };
        return null;
    };

    // challenge 6
    public query func populate_array(arr: [?Nat]): async [Nat]{
        let buffer = Buffer.Buffer<Nat>(arr.size());
        for (n in arr.vals()){
            buffer.add(Option.get(n, 0));
        };

        return buffer.toArray();
    };

    // challenge 7
    public query func sum_of_array(arr: [Nat]): async Nat{
        var sum = 0;
        Iter.iterate<Nat>(arr.vals(), func(n, i){
            sum := sum+ n;
        });

        return sum;
    };

    // challenge 8
    public query func squared_array(arr: [Nat]): async [Nat] {
        Array.map<Nat, Nat>(arr, func(n){
            return n * n;
        })
    };

    // challenge 9
    public query func increase_by_index(arr: [Nat]): async [Nat] {
        Array.mapEntries<Nat, Nat>(arr, func(n, i){
            return n + i;
        })
    };

    // challenge 10
     func contains<A>(arr: [A], a: A, f: ((A, A))-> Bool):  Bool{
        for (n in arr.vals()){
            if (f(n, a)){
                return true;
            };
        };
        return false;
    };

    public query func testContains(arr: [Nat], a: Nat): async Bool{
        return contains<Nat>(arr, a, func(a, b) {a==b});
    }
}