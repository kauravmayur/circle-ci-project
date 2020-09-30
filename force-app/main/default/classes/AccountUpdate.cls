global class AccountUpdate{
   
    public AccountUpdate(Map<id,Account> mapNewAcc, Map<id, Account> oldAccMap){
        /*
        system.debug('** AccountUpdate **');
        for(Account acc: mapNewAcc.Values()){
            if(trigger.isUpdate){
                system.debug('---- acc.phone 1: '+ acc.phone);
                if(oldAccMap.get(acc.id).phone == null && acc.phone != null && acc.Do_Not_Call__c == True){
                    system.debug('---- acc.phone 2: '+ acc.phone);
                    system.debug('---- System.isBatch(): '+ System.isBatch());
                    if(System.isBatch()){
                        system.debug('---- acc.phone 32: '+ acc.phone);
                        acc.phone = '2222222222';
                    }
                    else if(!System.isBatch()){
                        system.debug('---- acc.phone 31: '+ acc.phone);
                        acc.phone = '1111111111';
                    }
                }
            }
        }
        */
    }
    
    @future (callout=true)
    public static void doPostCallout( String jsonBody){
        system.debug('** AccountUpdate doPostCallout **');
        if(jsonBody != ''){
            HttpRest hr = new HttpRest();
            hr.getAccessToken();
            hr.callPostMethod(jsonBody);
        }
    }
   
    @future (callout=true)
    public static void doDeleteCallout( String jsonBody){
        system.debug('** AccountUpdate doDeleteCallout **');
        if(jsonBody != ''){
            HttpRest hr = new HttpRest();
            hr.getAccessToken();
            hr.callDeleteMethod(jsonBody);
        }
    }
}