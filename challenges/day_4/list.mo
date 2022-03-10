module{
    public type List<T> =  ?(T, List<T>);

    public func is_null<T>(l: List<T>): Bool{
        return switch(l){
            case (?l) false;
            case (_) true; 
        };
    };

    public func last<T>(l: List<T>): ?T {
        switch(l) { 
            case (?(curr, null)){ return ?curr; };
            case (?(_, next)){  last(next); };
            case (_){ return null; };
        };
    };

    public func size<T>(l:List<T>): Nat {
        var len = 0;
        var linked_list = l;

        loop {
            switch(linked_list){
                case (?(_, next)){
                    linked_list:= next;
                    len:= len +1;
                };

                case (null){
                    return len;
                };
            };
        };

    };

    public func get<T>(l:List<T>, n:Nat): ?T {
        var len = 0;
        var linked_list = l;

        loop {
            switch(linked_list){
                case (?(curr, next)){
                    if (n == len){
                        return ?curr;
                    };
                    linked_list:= next;
                    len:= len +1;
                };

                case (null){
                    return null;
                };
            };
        };

    };

    public func reverse<T>(l : List<T>) : List<T> {

        var r:List<T> = null;
        var list = l;

        loop {
            switch list {
                case (?(item, next)) { 
                        r:= ?(item, r);
                        list:= next;
                    };
                case null { return r; };
            };
        };
    };
}