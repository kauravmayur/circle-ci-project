trigger AccountTrigger on Account (before insert, before update) {
    system.debug('bypass setting : '+BypassSetting__c.getInstance().isAllowTrigger__c);
    if(BypassSetting__c.getInstance().isAllowTrigger__c){
        return;
    }
    For (Account acc : Trigger.New) {
        if(acc.description != null){
            acc.description = acc.description+' Test Trigger';
        }
        else{
            acc.description = 'Test Trigger';
        }
    }
}