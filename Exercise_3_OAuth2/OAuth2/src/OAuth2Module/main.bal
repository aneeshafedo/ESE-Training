import ballerina/http;
import ballerina/log;
import ballerina/oauth2;

type User record {|
    string id;
    string name;
|};


//OAuth2 confihurations for facebook API
//if the access token expires or become invalid, then it will be automatically refreshed with the provided

oauth2:OutboundOAuth2Provider oauth2Provider = new ({
    accessToken: "<your FB grap API access key>",
    refreshConfig: {
        clientId: "<your client id>",
        clientSecret:"<your client secret>",
        refreshToken: "<Refresh token>",
        refreshUrl: "<Refresh token URL>",
        clientConfig: {
            secureSocket: {
                trustStore: {
                    path: "/usr/lib/ballerina/distributions/ballerina-slp5/bre/security/ballerinaTruststore.p12",
                    password: "ballerina"
                }
            }
        }
    }
});

http:BearerAuthHandler oauth2Handler = new (oauth2Provider);

http:Client clientEndPoint = new ("https://graph.facebook.com", {
    auth: {
        authHandler: oauth2Handler
    },
    secureSocket: {
        trustStore: {
            path: "/usr/lib/ballerina/distributions/ballerina-slp5/bre/security/ballerinaTruststore.p12",
            password: "ballerina"
        }
    }
});

public function main() {

    var response = clientEndPoint->get("/me");
    if (response is http:Response) {
        json|error result = response.getJsonPayload();
        if(result is json){
            User|error user= result.cloneWithType(User);
            if(user is User){
                log:printInfo(user.name);
            }
            
        }
        
        log:printInfo((result is error) ? "Failed to retrieve payload." : result);
                    
    } else {
        log:printError("Failed to call the endpoint.", <error> response);
    }
}
