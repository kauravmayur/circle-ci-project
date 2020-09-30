@RestResource(urlMapping='/pankaj/*')
global class AccountDetailsByRestApi{
    @httpGet
    global static Account getAccountDetails(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        id accountid = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account accList = [Select Id, name from Account Where id =: accountId];
        return accList;
    }
    
    @HttpPost
    global static List<account> updateAccount(){
        //RestRequest req = RestContext.request;
        //RestResponse res = RestContext.response;
        //id accountid = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        Set<Id> accountIds = new Set<Id>();
        String jsonStr = null;
        if (null != req.requestBody) {
            jsonStr = req.requestBody.toString();
        }
        system.debug('data : '+ jsonStr);
        List<account> accList= (List<account>)System.JSON.deserialize(jsonStr, List<account>.class);

        system.debug('accList : '+ accList);
        /*
        for(account acc: accwrapList){
            accountIds.add(acc.Id);
        }
        
        List<Account> accounts = [Select Id, name,NumberofLocations__c from Account where Id in: accountIds];// Where id =: accountId];
        */
        for(account acc: accList){
            acc.NumberofLocations__c = acc.NumberofLocations__c + 4;
        }
        
        update accList;
        return accList;
    }
    
}