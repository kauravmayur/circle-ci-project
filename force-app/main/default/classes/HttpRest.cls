public with sharing class HttpRest{
    private string accessToken;
    private string sfdcInstanceURL;
    public class OAuth2{
        public String id;
        public String access_token{get;set;}    
    }

    
    public void getAccessToken(){
        string uri = 'https://login.salesforce.com/services/oauth2/token';
        string clientId = '3MVG9Y6d_Btp4xp7cZZR7pzuX1lGFO3sWQtw9v4aGf8XM3YqX1kIIcHMnIs43zStjKMVmxdWQGP7P4PYmbHZ.';
        string clientSecret = '4709536801342944829';
        string username = 'kaurav@gmail.com';
        string password  ='welcome12#hMWCGfOJAz5TieIie0b6nZT8x';//welcome12#8o9WQ9QhA1peqG0LSTEbKT34q
        string body = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        //String body   = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        Http h = new Http();
        HttpRequest hRqst = new HttpRequest();
        hRqst.setMethod('POST');  // Caller Provide
        hRqst.setTimeOut(6000);
        hRqst.setBody(body);  // caller provide
        //hRqst.setEndpoint(uri);  // caller provides, this will be a RSET resources.
        hRqst.setEndpoint('https://login.salesforce.com/services/oauth2/token');  
        system.Debug('***hRqst : '+hRqst.getBody());
        HttpResponse hRes = h.send(hRqst);
        system.Debug('***hRes.getStatusCode() : '+hRes.getStatusCode());
        String responseBody = hRes.getBody(); 
        if(hRes.getStatusCode() == 200){
            system.Debug('***response body =\n'+hRes.getBody());
            Map<String, String> res = (Map<String, String>)JSON.deserialize(hRes.getBody(), Map<String, String>.class);
            system.debug('**res'+ res);
            accessToken = res.get('access_token');  // remember these for subsequesnt call
            sfdcInstanceUrl = res.get('instance_url');
            system.debug('**accessToken'+ accessToken);
            //callRestClass('Test');
        }
        else{
            system.debug('**response body =\n'+ hres.getBody());
        }
    }
    
    public void callRestClass(){
        system.debug('** callRestClass **');
        //string uri = 'https://ap1.salesforce.com/services/apexrest/accountRest';
        string uri = sfdcInstanceUrl+'/services/apexrest/KauravMayur/accountRest/';
        Http h = new Http();
        HttpRequest hRqst = new HttpRequest();
        System.Debug('**sfdcInstanceUrl '+ sfdcInstanceUrl);
        hRqst.setHeader('Authorization', 'Bearer '+accessToken);
        hRqst.setHeader('Content-Type','application/json');
        hRqst.setHeader('accept','application/json');
        hRqst.setMethod('GET');  // Caller Provide
        hRqst.setEndpoint(uri);  // caller provides, this will be a RSET resources.
        hRqst.setTimeOut(6000);
        HttpResponse hRes = h.send(hRqst);
        system.debug('**response body to class =\n'+ hres.getBody());
    }
    
    public void callPostMethod(String jsonBody){
        system.debug('** callPostMethod **');
        //String jsonBody = json.serialize(accList);
        string uri = sfdcInstanceUrl+'/services/apexrest/KauravMayur/accountRest/';
        Http h = new Http();
        HttpRequest hRqst = new HttpRequest();
        System.Debug('**sfdcInstanceUrl '+ sfdcInstanceUrl);
        hRqst.setHeader('Authorization', 'Bearer '+accessToken);
        hRqst.setHeader('Content-Type','application/json');
        hRqst.setHeader('accept','application/json');
        hRqst.setMethod('POST');  // Caller Provide
        hRqst.setbody(jsonBody);
        hRqst.setEndpoint(uri);  // caller provides, this will be a RSET resources.
        hRqst.setTimeOut(6000);
        HttpResponse hRes = h.send(hRqst);
        system.debug('**response body to class =\n'+ hres.getBody());
    }
    public void callDeleteMethod(String jsonBody){
        system.debug('** callPostMethod **');
        //String jsonBody = json.serialize(accList);
        string uri = sfdcInstanceUrl+'/services/apexrest/KauravMayur/accountRest/';
        Http h = new Http();
        HttpRequest hRqst = new HttpRequest();
        System.Debug('**sfdcInstanceUrl '+ sfdcInstanceUrl);
        hRqst.setHeader('Authorization', 'Bearer '+accessToken);
        hRqst.setHeader('Content-Type','application/json');
        hRqst.setHeader('accept','application/json');
        hRqst.setMethod('DELETE');  // Caller Provide
        hRqst.setbody(jsonBody);
        hRqst.setEndpoint(uri);  // caller provides, this will be a RSET resources.
        hRqst.setTimeOut(6000);
        HttpResponse hRes = h.send(hRqst);
        system.debug('**response body to class =\n'+ hres.getBody());
    }
    
}