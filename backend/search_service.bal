import ballerina/http;

listener http:Listener searchServiceListener = new(5500);

service / on searchServiceListener {
    resource function post search(http:Caller caller, http:Request req) returns error? {
        json searchData = check req.getJsonPayload();
        string searchQuery = (check searchData.query).toString();

        json response = { message: "You searched for " + searchQuery };
        check caller->respond(response);
    }
}
