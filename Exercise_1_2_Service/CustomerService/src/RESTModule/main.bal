import ballerina/log;
import ballerina/http;


listener http:Listener httpListener = new (9090);

map<json> customerDataMap = {};

@http:ServiceConfig {basePath: "/"}

service customerDataManagement on httpListener{

    @http:ResourceConfig {

        methods: ["POST"],
        path: "/customer"
    }

    resource function addCustomer (http:Caller caller, http:Request req){
        http:Response response = new;
        var customerDetailsReq = req.getJsonPayload();
        log:printInfo(customerDetailsReq.toString());

        if(customerDetailsReq is json){
            json|error customerIdReq = customerDetailsReq.Customer.Id;
            
            if customerIdReq is error{
                response.statusCode = 400;
                response.setPayload({message : "Invalid customer Id"}); 

                log:printError("Unable to add customer");
            }
            else{
                
                string customerId = customerIdReq.toString();

                customerDataMap[customerId] = <@untainted> customerDetailsReq;

                json payload = { message: "Customer Added", customerId: customerId };
                response.setJsonPayload(<@untainted>payload);
                response.statusCode = 201;

                response.setHeader("Location","http://localhost:9090/customer/" + customerId);
            }
        }
        else {
            response.statusCode = 400;
            response.setPayload({message : "Invalid payload received"});
        }

        var result = caller -> respond(response);
        if result is error {
            log:printError("Error sending response", err = result);
        }
    }

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/customer/{customerId}"
    }

    resource function getCustomerDetails (http:Caller caller, http:Request req, string customerId){
        json payload = customerDataMap[customerId];
        http: Response response = new;

        if(payload == null){
            payload = "Customer : " + customerId + " cannot be found !";
        }

        response.setJsonPayload(<@untainted> payload);
        var result = caller -> respond(response);

        if result is error{
            log:printError("Error sending response",err=result);
        }

    }

    @http:ResourceConfig {
            methods: ["PUT"],
            path: "/customer"
        }

    resource function updateCustomerDetails(http:Caller caller, http:Request req) {

        http:Response response = new;
        var customerDetailsReq = req.getJsonPayload();
        log:printInfo(customerDetailsReq.toString());

        if(customerDetailsReq is json){
            string|error customerId = <string> customerDetailsReq.Customer.Id;
            
            if customerId is error{
                log:printError("Invalid Customer Id");
                
                response.statusCode = 400;
                response.setPayload({message : "Invalid customer Id"});
            }
            else{
                json existingCustomer = customerDataMap[customerId.toString()];
            
                if (existingCustomer == null){
                    existingCustomer = "Customer : " + customerId + " cannot be found !";

                    response.statusCode = 400;
                    response.setJsonPayload({message: "Customer update failed", customer : <@untainted> existingCustomer});
                }
                else{
                    customerDataMap[customerId.toString()] = <@untainted> customerDetailsReq;
                    existingCustomer = customerDetailsReq;

                    response.statusCode = 200;
                    response.setJsonPayload({message: "Customer Updated", customer : <@untainted> existingCustomer});
                }           
            }
            
        }
        else {
            response.statusCode = 400;
            response.setPayload({message : "Invalid payload received"});
        }

        var result = caller -> respond(response);
        if result is error {
            log:printError("Error sending response", err = result);
        }
    }
}