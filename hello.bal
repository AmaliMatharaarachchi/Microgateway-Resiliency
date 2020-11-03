// To run the following service, you need ballerina v1.2.x version. 
// Visit https://ballerina.io/downloads/ 
// Start the example service by executing the following command.
// `ballerina run hello.bal`

// The timeout example
// import ballerina/http;
// import ballerina/runtime;
// import ballerina/io;

// service hello on new http:Listener(8080) {
//     resource function sayHello(http:Caller caller,
//         http:Request req) returns error? {
//         io:println("backend is called");
//         runtime:sleep(8000);
//         check caller->respond("Hello, World!");
//     }
// }

// // circuit breaker example
import ballerina/http;
import ballerina/io;

int count = 0;
service hello on new http:Listener(8080) {
    
    resource function sayHello(http:Caller caller,
        http:Request req) returns error? {
        io:print("backend is called : ");
        count = count + 1;
        if (count%2 == 0) {
            io:println("sending success");
            check caller->respond("Hello, World!");
        } else {
            io:println("sending fails");
            check caller->internalServerError();
        } 
    }
}