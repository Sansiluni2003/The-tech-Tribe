import ballerina/http;

// Update allowed origins to include your IP address

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"],
        allowCredentials: true,
        allowHeaders: ["Content-Type"],
        allowMethods: ["POST", "GET", "OPTIONS"],
        maxAge: 3600
    }
}
service / on new http:Listener(5570) {
    // Handle all OPTIONS requests
    resource function OPTIONS .() returns http:Response {
        return new http:Response();
    }

    resource function post search(@http:Payload json payload) returns json|error {
        string searchQuery = check payload.query.ensureType();
        return { message: "You searched for: " + searchQuery };
    }
}