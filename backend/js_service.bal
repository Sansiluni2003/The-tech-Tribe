import ballerina/http;
import ballerina/io;
import ballerina/log;

listener http:Listener jsServiceListener = new(5300);

service / on jsServiceListener {
    resource function get tourismJs(http:Caller caller, http:Request req) returns error? {
        http:Response res = new;
        string|io:Error jsContent = io:fileReadString("./tourism.js");
        if (jsContent is string) {
            res.setPayload(jsContent);
        } else {
            res.setPayload("Error reading JS file");
        }
        error? contentType = res.setContentType("application/javascript");
        if contentType is error {
            log:printError("Error setting content type for JS", contentType);
        }
        check caller->respond(res);
    }
}
