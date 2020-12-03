import ballerina/io;
import aneesha/SimpleWeatherConnector as weather;

public type OpenWeatherConfiguration record {
    string appid;
    string url;
};

OpenWeatherConfiguration testConf = {
    appid: "69b310f8d3233e106c8640b483bdea0e",
    url: "http://api.openweathermap.org/data/2.5"
};

string countryName = "London";
string statecode = "uk";
string countryId = "2172797";
string cities = "524901, 703448";


weather:WeatherClass myclass = new(testConf);

function testGetWeatherByCountryName(){
    
    
    json|error result = myclass->getWeatherByCity(countryName, (), true);
    
    if result is json{
            io:println("testGetWeatherByCountryName : ",result);

    }else{
        io:println(result.message());
    }
}

public function main(){
    testGetWeatherByCountryName();
}

