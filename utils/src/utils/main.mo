import F "./format";

actor {
    public query func greet(name : Text) : async Text {
        var c = "";

        return F.format("children  = {}", [#natArray([1, 2, 3])]) ;
    };
};
