public with sharing class testRestApi{
    public string accessToken;
    public string sfdcInstanceUrl;
    
    public void getAccessToken(){
        //string url = 'https://login.salesforce.com/services/oauth2/token';
        string url = 'https://login.salesforce.com/services/oauth2/token';
        string clientId = EncodingUtil.urlEncode('3MVG9Y6d_Btp4xp7cZZR7pzuX1ifzV2MlWaZ5AoN4ypHCFaGDNdaR8_wbNZhVJP28SPMVci56LB7Rts1KlXOW', 'UTF-8');
        string clientSecret = EncodingUtil.urlEncode('7549049734241718346', 'UTF-8');
        string username = EncodingUtil.urlEncode('kaurav@gmail.com', 'UTF-8');
        string password = EncodingUtil.urlEncode('mad072face566U79hLY7cQcDxCWXdvv9AmvmPT', 'UTF-8');
        string body = 'grant_type=password&client_id='+clientId+
                                         '&client_Secret='+clientSecret+
                                         '&username='+username+
                                         '&password='+password;
                                         
        Http h = new Http();
        HttpRequest hrqst = new HttpRequest();
        hrqst.setEndpoint(url);  // caller provides, this will be a RSET resources.
        hrqst.setMethod('POST');  // Caller Provide
        hrqst.setTimeOut(6000);
        hrqst.setBody(body);  // caller provide
        system.Debug('***hRqst : '+hrqst.getBody());
        
        HttpResponse hRes = h.send(hrqst);
        system.Debug('***hRes.getStatusCode() : '+hRes.getStatusCode());
    }
}