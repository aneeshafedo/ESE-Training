import ballerina/io;
import ballerina/http;


public type WeatherClientObj client object {
    string appid;
    string url;
    http:Client weatherClient;
    
    public remote function getWeatherByCity(string city,string? statecode, boolean isByName) returns @tainted json|error;
    public remote function getWeatherofMultipleCities(string  countries)returns @tainted json|error;
  
};

public client class WeatherClient {
    *WeatherClientObj;

    public function init(OpenWeatherConfiguration conf){
        self.appid = conf.appid;
        self.url = conf.url;
        self.weatherClient = new(self.url);
    }

    //function to get weather of a country by country name or id
    //@param: city - country name or country id
    //@param: statecode - code of a city of the country given; optional
    //@param: isByName - to indicate whether country name or the id given

    public remote function getWeatherByCity(string city,string? statecode, boolean isByName) returns @tainted json|error{
        http:Response? result = new;
        io:println("City : ", city, " api key : ", self.appid);

        if(isByName){
            if (statecode is string && city != "" && statecode != ""){
                result = <http:Response> self.weatherClient ->get(string `/weather?q=${city},${statecode}&appid=${self.appid}`);
            }
            else if(city != ""){
                result = <http:Response> self.weatherClient ->get(string `/weather?q=${city}&appid=${self.appid}`);
            }
            else{
                result = ();
            }
        }
        else{
            if(city != ""){
                result = <http:Response> self.weatherClient ->get(string `/weather?id=${city}&appid=${self.appid}`);
            }
            else{
                result = ();
            }
        }

        

        if result is http:Response{
            if result.statusCode == 200{
                json payload = <json> result.getJsonPayload();
                json[] weatherResult = <json []> payload.weather;

                io:println("result : ", weatherResult);
                return weatherResult[0].description;

            }
            else{
                
                json|error payload = <json> result.getJsonPayload();
                if(payload is json){
                    io:println("Error : ", payload.message);

                    return APICallforSingleEntryError(payload.message.toString(), code = payload.cod.toString(), location = city);
                }
                else{
                    return InvalidPayloadError(NOT_FOUND, errormessage = payload.toString());
                }
                
                
            }
        }
        else{
            io:println("Error : ",result);
            return error(API_CALL_FAILED);
            
        }

    }

    //function to get weather of multiple countries countries
    //@param: countries- comma seperated string consist of Ids of multiple countries

    public remote function getWeatherofMultipleCities(string  countries)returns @tainted json|error{

        http:Response ? result = new;

        if (countries.length() > 0){
            result = <http:Response> self.weatherClient ->get(string `/group?id=${countries}&appid=${self.appid}`);
        }
        else{
            result = ();
        }

        if result is http:Response{
            if result.statusCode == 200{
                json payload = <json> result.getJsonPayload();
                json[] weatherResult = <json []> payload.list;

                return weatherResult;

            }
            else{
                
                json|error payload = <json> result.getJsonPayload();
                if(payload is json){
                    io:println("Error : ", payload.message);

                    return APICallforSingleEntryError(payload.message.toString(), code = payload.cod.toString(), location = countries);
                }
                else{
                    return InvalidPayloadError(NOT_FOUND, errormessage = payload.toString());
                }
                
                
            }
        }
        else{
            io:println("Error : ",result);
            return error(API_CALL_FAILED);
            
        }

    }

    //function to get weather by latitude and longitude

    public remote function getWeatherbyLatLon(string lat, string lon)returns @tainted json|error{
        http:Response ? result = new;

        if (lat != "" && lon != ""){
            result = <http:Response> self.weatherClient ->get(string `/weather?lat=${lat}&lon=${lon}&appid=${self.appid}`);
        }
        else{
            result = ();
        }

        if result is http:Response{
            if result.statusCode == 200{
                json payload = <json> result.getJsonPayload();
                json[] weatherResult = <json []> payload.weather;

                io:println("result : ", weatherResult);
                return weatherResult[0].main;

            }
            else{
                
                json|error payload = <json> result.getJsonPayload();
                if(payload is json){
                    io:println("Error : ", payload.message);

                    return APICallforSingleEntryError(payload.message.toString(), code = payload.cod.toString(), location = (lat+"&"+lon));
                }
                else{
                    return InvalidPayloadError(NOT_FOUND, errormessage = payload.toString());
                }
                
                
            }
        }
        else{
            io:println("Error : ",result);
            return error(API_CALL_FAILED);
            
        }
    }

}



