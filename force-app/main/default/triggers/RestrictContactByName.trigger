trigger RestrictContactByName on Contact (before insert, before update) {
    //check contacts prior to insert or update for invalid data
        system.debug('bypass setting : '+BypassSetting__c.getInstance().isAllowTrigger__c);
    if(BypassSetting__c.getInstance().isAllowTrigger__c){
        return;
    }
    For (Contact c : Trigger.New) {
        if(c.description != null){
            c.description = c.description+' Test Trigger';
        }
        else{
            c.description = 'Test Trigger';
        }
    }
}