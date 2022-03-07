import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Char "mo:base/Char";
import Func "mo:base/Func";
import Bool "mo:base/Bool";
import Int "mo:base/Int";


module Format{
    type Types = {
        #num: Int;
        #numArray: [Int];

        // #numArrayMut: [var Int];
        #natArrayMut: [var Nat];
        #intArrayMut: [var Int];

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

    type ArrayType<T> ={
        #mut: [var T];
        #fixed: [T];
    };

    private func arrayToText<T>(input: ArrayType<T>, formatter: T -> Text): Text {
        var str = "[";

        switch input{
            case (#fixed arr) {
                let size:Int = arr.size();
                if (size == 0) return "[ ]";

                for (i in  Iter.range(0, size-1)){
                    str:= str # (if (i < size-1) {formatter(arr[i]) # ", "} else {""});
                };
            };

            case (#mut arr) {
                let size:Int = arr.size();
                if (size == 0) return "[ ]";

                for (i in  Iter.range(0, size-1)){
                    str:= str # (if (i < size-1) {formatter(arr[i]) # ", "} else {""});
                };
            };
        };
        
         str # "]"
    };

    private func serialize(varArg: Types): Text {

        switch varArg {
            case (#text(t)) t;
            case (#textArray(arr)) arrayToText(#fixed arr, func (t: Text):Text = t);
            case (#textArrayMut(arr)) arrayToText(#mut arr, func (t: Text):Text = t);

            case (#num(n)) Int.toText(n);
            case (#numArray(arr)) arrayToText(#fixed arr, Int.toText);
            // case (#numArrayMut(arr)) arrayToText<Int>(#mut arr, Int.toText);
            case (#natArrayMut(arr)) arrayToText<Nat>(#mut arr, Nat.toText);
            case (#intArrayMut(arr)) arrayToText<Int>(#mut arr, Int.toText);


            case (#char(ch)) Char.toText(ch);
            case (#charArray(arr)) arrayToText(#fixed arr, Char.toText);
            case (#charArrayMut(arr)) arrayToText(#mut arr, Char.toText);

            case (#bool(b)) Bool.toText(b);
            case (#array(arr)) arrayToText(#fixed arr, serialize);
        }
    }
}