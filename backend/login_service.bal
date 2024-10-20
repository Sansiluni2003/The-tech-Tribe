import ballerina/http;

listener http:Listener loginServiceListener = new(5400);

service / on loginServiceListener {
    resource function post login(http:Caller caller, http:Request req) returns error? {
        json loginData = check req.getJsonPayload();
        string email = (check loginData.email).toString();
        string password = (check loginData.password).toString();
        
        if email == "user@example.com" && password == "password" {
            check caller->respond("Login Successful!");
        } else {
            check caller->respond("Invalid Credentials.");
        }
    }
}
