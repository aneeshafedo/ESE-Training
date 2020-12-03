import ballerina/io;
import ballerina/test;

OpenWeatherConfiguration testConf = {
    appid: "<your api key>",
    url: "http://api.openweathermap.org/data/2.5"
};

string countryName = "London";
string statecode = "uk";
string countryId = "2172797";
string cities = "524901, 703448";

WeatherClient myclient = new WeatherClient(testConf);

@test:Config{

}

function testGetWeatherByCountryName(){
    
    
    
    json|error result = myclient->getWeatherByCity(countryName, (), true);
    
    if result is json{
            io:println("testGetWeatherByCountryName : ",result);

    }else{
        io:println(result.message());
        test:assertFail(result.toString());
    }
}
@test:Config{

}
function testGetWeatherByCountryId(){
    
    //WeatherClient myclient = new WeatherClient(testConf);
    
    json|error result = myclient->getWeatherByCity(countryId, (), false);
    
    if result is json{
        io:println("testGetWeatherByCountryId : ", result);

    }else{
        io:println("testGetWeatherByCountryId : ",result.message());
        test:assertFail(result.toString());
    }
}
@test:Config{

}
function testGetWeatherByStateName(){
    
    //WeatherClient myclient = new WeatherClient(testConf);
    
    json|error result = myclient->getWeatherByCity(countryName, statecode, true);
    
    if result is json{
            io:println("testGetWeatherByStateName : ",result);

    }else{
        io:println(result.message());
        test:assertFail(result.toString());
    }
}

@test:Config{

}
function testGetWeatherofMultipleCities(){
    //WeatherClient myclient = new WeatherClient(testConf);
    
    json|error result = myclient->getWeatherofMultipleCities(cities);
    
    if result is json{
            io:println("testGetWeatherofMultipleCities : ",result);

    }else{
        io:println(result.message());
        test:assertFail(result.toString());
    }
}

@test:Config{

}

function testGetWeatherbyLatLon(){
    json|error result = myclient->getWeatherbyLatLon("35", "139");
    
    if result is json{
            io:println("testGetWeatherofMultipleCities : ",result);

    }else{
        io:println(result.message());
        test:assertFail(result.toString());
    }

}





