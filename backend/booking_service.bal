import ballerina/http;

listener http:Listener bookingServiceListener = new(5900);

service / on bookingServiceListener {
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
