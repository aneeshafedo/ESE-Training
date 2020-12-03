import ballerina/io;
import ballerina/test;


DBConfiguration config = {
    username: "<your username>",
    password: "<your password>",
    url: "http://localhost:9090"
};

Customer testCustomer = {
    Id:303,
    Name: "Steve Rogers",
    Email: "steve@gmail.com"
};

Customer updateCustomer = {
    Id:303,
    Name: "Captain america",
    Email: "steve@gmail.com"
};

DBClient dbClient = new(config);

@test:Config{}

function testAddCustomer(){
    json|error result = dbClient->addCustomer(testCustomer);

    if result is json{
        io:println(result.toString());

    }else{
        io:println(result.toString());
        test:assertFail(result.message());
    }
}

@test:Config{
    dependsOn:["testAddCustomer"]
}
function testRetrieveCustomerbyId(){

    json|error result = dbClient->getCustomerbyId(testCustomer.Id);

    if result is json{
        io:println(result.toString());

    }else{
        io:println(result.toString());
        test:assertFail(result.message());
    }
}

@test:Config{
    dependsOn:["testAddCustomer"]
}
function testUpdateCustomer(){

    json|error result = dbClient->updateCustomer(updateCustomer);

    if result is json{
        io:println(result.toString());

    }else{
        io:println(result.toString());
        test:assertFail(result.message());
    }
}
