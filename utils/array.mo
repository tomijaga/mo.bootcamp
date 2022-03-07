module array{
    public func swapElemsInArray<T>(arr: [var T], i: Nat, j: Nat): Bool{
        let size = arr.size();

        if ( i >= size or j >= size  ) return false;

        let temp = arr[i];
        arr[i]:= arr[j];
        arr[j]:= temp;

        return true;
    }
}