import ballerina/http;
import ballerina/io;
import ballerina/log;

listener http:Listener htmlServiceListener = new(5100);

service / on htmlServiceListener {
    resource function get index(http:Caller caller, http:Request req) returns error? {
        http:Response res = new;
        string|io:Error htmlContent = io:fileReadString("./tourism.html");
        if (htmlContent is string) {
            res.setPayload(htmlContent);
        } else {
            res.setPayload("Error reading HTML file");
        }
        error? contentType = res.setContentType("text/html");
        if contentType is error {
            log:printError("Error setting content type for HTML", contentType);
        }
        check caller->respond(res);
    }
}
