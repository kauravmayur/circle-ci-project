trigger AccountUpdate on Account (before insert) {
    
    List<Account> accList = new List<Account>();
    AccountUpdate AU = new AccountUpdate(Trigger.newMap, trigger.oldMap);
        //if(trigger.isInsert || trigger.isUpdate){
            accList = [SELECT ID, Name, Phone, Type FROM Account where ID IN : Trigger.new];
            if(accList != null && accList.Size() > 0){
                String jsonBody = json.serialize(accList);
                system.debug('$$ jsonBody 1: '+jsonBody);
                //AccountUpdate.doPostCallout(jsonBody);
            }
        //}
        /*
        else{
            List<Account>    accList1 = [SELECT ID, Name, Phone, Type FROM Account where ID IN : Trigger.oldMap.KeySet()];
            if(accList1 != null && accList1.Size() > 0){
                String jsonBody = json.serialize(accList1);
                system.debug('$$ jsonBody 2: '+jsonBody);
                //AccountUpdate.doDeleteCallout(jsonBody);
            }
        }
        */
        
}