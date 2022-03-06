import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Char "mo:base/Char";


module Format{
    type Types = {
        #nat: Nat;
        #natArray: [Nat];
        #natArrayMut: [var Nat];

        #char: Char;
        #charArray: [Char];
        #charArrayMut: [var Char];

        #text: Text;
        #textArray: [Text];
        #textArrayMut: [var Text];

        #array: [Types];
        #bool: Bool;
    };

    public func format(fstring: Text, varArgs: [Types]): Text {
        var result: Text = "";
        var i = 0;
        let argsLen = varArgs.size();

        for (fstr in Text.split(fstring, #text "{}")){
            result := result # fstr # (if (i < argsLen) { serialize(varArgs[i])} else {""}) ; 
            i:= i+1;
        };

        return result;
    };

    private func serialize(varArg: Types): Text {

        switch varArg {
            case (#text(t)) t;
            case (#bool(b)) if(b){"true"}else{"false"};
            case (#nat(n)) Nat.toText(n);
            case (#char(ch)) Char.toText(ch);
            case (#array(arr)) {
                var str = "[";

                for (elem in arr.vals()){
                    str:= str # " " # serialize(elem) # ",";
                };

                 str # "]"
            };

            case (#textArray(arr)) {
                var str = "[";

                for (elem in arr.vals()){
                    str:= str # " " # elem # ",";
                };

                 str # "]"
            };

            case (#natArray(arr)) {
                var str = "[";

                for (elem in arr.vals()){
                    str:= str # " " # Nat.toText(elem) # ",";
                };

                 str # "]"
            };

            case (#natArrayMut(arr)) {
                var str = "[";

                for (elem in arr.vals()){
                    str:= str # " " # Nat.toText(elem) # ",";
                };

                 str # "]"
            };
        }
    }
}