import ballerina/io;
import ballerina/http;

public client class DBClient {
    public string url;
    public string username;
    public string password;
    http:Client dbClient;
    
    public function init(DBConfiguration conf){
        self.username = conf.username;
        self.password = conf.password;
        self.url = conf.url;
        self.dbClient = new(self.url);
    }

    public function getCustomerbyId(int customerId) returns @tainted json|error {
        http:Response? result = new;

        result = <http:Response> self.dbClient->get(string `/customer/${customerId}`);

        io:println(result.toString());

        if result is http:Response{
            
                json|error payload = result.getJsonPayload();
                if payload is json {
                    if(result.statusCode == http:STATUS_OK){
                        return payload;
                    }
                    else{
                        return InvalidResponseError(INVALID_RESPONSE, statusCode = result.statusCode, message = payload);
                    }
                    
                }
                else{
                    return RequestFailedError(REQUEST_FAILED, message = payload.toString());
                }
        }
        else{
            return RequestFailedError(REQUEST_FAILED, message = result.toString());
        }
    }

    public remote function addCustomer(Customer customer) returns @tainted json|error{
        http:Response? result = new;
        http:Request request = new;

        json jsonRequest = {"Id" : customer.Id, "Name" : customer.Name, "Email" : customer.Email};

        request.setJsonPayload(jsonRequest);

        result = <http:Response> self.dbClient -> post("/customer", request);

        if result is http:Response{
            
                json|error payload = result.getJsonPayload();
                if payload is json {
                    if(result.statusCode == 201){
                        return payload;
                    }
                    else{
                        return InvalidResponseError(INVALID_RESPONSE, statusCode = result.statusCode, message = payload);
                    }
                }
                else{
                    return RequestFailedError(REQUEST_FAILED, message = payload.toString());
                }
        }
        else{
            return RequestFailedError(REQUEST_FAILED, message = result.toString());
        }
    }

    public remote function updateCustomer (Customer customer) returns @tainted json|error{
        http:Response? result = new;
        http:Request request = new;

        json jsonRequest = {"Id" : customer.Id, "Name" : customer.Name, "Email" : customer.Email};

        request.setJsonPayload(jsonRequest);

        result = <http:Response> self.dbClient -> put("/customer", request);

        if result is http:Response{
            
                json|error payload = result.getJsonPayload();
                if payload is json {
                    if(result.statusCode == http:STATUS_OK){
                        return payload;
                    }
                    else{
                        return InvalidResponseError(INVALID_RESPONSE, statusCode = result.statusCode, message = payload);
                    }
                    
                }
                else{
                    return RequestFailedError(REQUEST_FAILED, message = payload.toString());
                }
        }
        else{
            return RequestFailedError(REQUEST_FAILED, message = result.toString());
        }
    }

    public remote function deleteCustomer (int customerId) returns @tainted json|error{
        http:Response? result = new;

        result = <http:Response> self.dbClient->delete(string `/customer/${customerId}`);

        io:println(result.toString());

        if result is http:Response{
            
                json|error payload = result.getJsonPayload();
                if payload is json {
                    if(result.statusCode == http:STATUS_OK){
                        return payload;
                    }
                    else{
                        return InvalidResponseError(INVALID_RESPONSE, statusCode = result.statusCode, message = payload);
                    }
                    
                }
                else{
                    return RequestFailedError(REQUEST_FAILED, message = payload.toString());
                }
        }
        else{
            return RequestFailedError(REQUEST_FAILED, message = result.toString());
        }
    }
}