@isTest
global class AccountProcessorCalloutMock implements HttpCalloutMock{
    global HttpResponse respond(HttpRequest req){
        //Create fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type','application/json');
        res.setBody('{"status":"success"}');
        res.setStatusCode(200);
        return res;
    }
}