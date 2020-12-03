public const REQUEST_FAILED = "Data Request Failed";
public const INVALID_RESPONSE = "Invalid Response Received";
public const INVALID_PAYLOAD = "Invalid Payload Received";

public type DBConfiguration record {|
   string username;
   string password;
   string url; 
|};

public type Customer record {|
    int Id;
    string Name;
    string Email;
|};

public type CustomHttpErrorData record {|
    int statusCode;
    json message;
|};

public type RequestFailedErrorData record {|
    string message;
|};

type InvalidResponseError error<CustomHttpErrorData>;
type RequestFailedError distinct error <RequestFailedErrorData>;
type InvalidPayloadError distinct error <RequestFailedErrorData>;