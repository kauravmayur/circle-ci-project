trigger Trigger_25New on Account (before insert,after insert, before update,after update) {
    
    list<Account> actlist = trigger.new;
    if(Trigger.isInsert && trigger.isbefore){
     for(Account act:actlist){
        if(act.Do_not_call__c == TRUE && act.phone != null){           
            act.Phone.addError('Please unchecked Do Not Call');
         }
     }
    }
    if(Trigger.isInsert && trigger.isAfter){
        System.debug('***After Insert***');
    }
    else if(trigger.isUpdate && trigger.isBefore){
        Map<Id, Account> accMap = trigger.OldMap;
        System.debug('accMap : '+accMap);
        for(Account act:actlist){
            if(accMap != null){
                if(accMap.ContainsKey(act.Id) && act.Do_not_call__c == TRUE && accMap.get(act.Id).phone != act.phone)    {           
                    act.Phone.addError('Can not change phone');
                }
            }
         }
    }
    else if(trigger.isUpdate && trigger.isAfter){
        System.debug('***After Update***');
    }
     

}