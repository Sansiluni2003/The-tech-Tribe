import ballerina/http;
import ballerina/log;
import ballerina/io;

// Define the listener
listener http:Listener serverEP = new(9097);

// Define a service to serve the frontend.
service / on serverEP {

    // Route to serve the static HTML file
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

    // Route to serve the static CSS file
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
    
    // Route to serve the static JS file
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

    // Handle login POST request
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

    // Handle search functionality
    resource function post search(http:Caller caller, http:Request req) returns error? {
        json searchData = check req.getJsonPayload();
        string searchQuery = (check searchData.query).toString();

        // Sample response for search query
        json response = { message: "You searched for " + searchQuery };
        check caller->respond(response);
    }

    // Handle booking form submission
    resource function post book(http:Caller caller, http:Request req) returns error? {
        json bookingData = check req.getJsonPayload();
        string place = (check bookingData.place).toString();
        string guests = (check bookingData.guests).toString();
        string arrival = (check bookingData.arrival).toString();
        string leaving = (check bookingData.leaving).toString();

        json response = { 
            message: "Booking confirmed", 
            details: { place: place, guests: guests, arrival: arrival, leaving: leaving }
        };
        check caller->respond(response);
    }
}
