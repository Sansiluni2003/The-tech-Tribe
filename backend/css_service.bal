import ballerina/http;
import ballerina/io;
import ballerina/log;

listener http:Listener cssServiceListener = new(5240);

service / on cssServiceListener {
    resource function get tourismCss(http:Caller caller, http:Request req) returns error? {
        http:Response res = new;
        string|io:Error cssContent = io:fileReadString("./tourism.css");
        if (cssContent is string) {
            res.setPayload(cssContent);
        } else {
            res.setPayload("Error reading CSS file");
        }
        error? contentType = res.setContentType("text/css");
        if contentType is error {
            log:printError("Error setting content type for CSS", contentType);
        }
        check caller->respond(res);
    }
}
