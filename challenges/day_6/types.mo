import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Result "mo:base/Result";
import Principal "mo:base/Principal";
import Hash "mo:base/Hash";
import Iter "mo:base/Iter";
import Array "mo:base/Array";
import Text "mo:base/Text";

module{
    public type TokenIndex = Nat;
    public type Error = {
        #InvalidTokenId;
        #ZeroAddress;
        #Unauthorized;
        #NotFound
    };

    public type HeaderField = (Text, Text);
    public type Response = {
        body               : Blob;
        headers            : [HeaderField];
        status_code        : Nat16;
         streaming_strategy : ?StreamingStrategy;
    };

    public type StreamingStrategy = {
        #Callback: {
            callback : StreamingCallback;
            token    : StreamingCallbackToken;
        };
    };

    public type StreamingCallback = query (StreamingCallbackToken) -> async (StreamingCallbackResponse);

    public type StreamingCallbackToken =  {
        content_encoding : Text;
        index            : Nat;
        key              : Text;
    };

    public type StreamingCallbackResponse = {
        body  : Blob;
        token : ?StreamingCallbackToken;
    };

}