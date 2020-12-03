public const API_CALL_FAILED = "Api Call Failed!";
public const NOT_FOUND = "Not Found";

public type OpenWeatherConfiguration record {
    string appid;
    string url;
};

public type APICallErrorData record {|
   string code;
   string location;
   //string message; 
|};

public type InvalidPayloadData record{|
    string errormessage;
|};



type APICallforSingleEntryError error<APICallErrorData>;
type InvalidPayloadError error<InvalidPayloadData>;