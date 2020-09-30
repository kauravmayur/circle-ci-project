trigger ContactTrigger on Contact (before update) {
    
    Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
    Schema.SObjectType systemObjectType = gd.get('Contact');
    Schema.DescribeSObjectResult r = systemObjectType.getDescribe();
    Map<String, Schema.SObjectField> M = r.fields.getMap();
    for(Schema.SObjectField fieldAPI : M.values()){
        string str = fieldAPI.getDescribe().getName();
    }
    
    List<sObject> conList = Trigger.New;//[SELECT Id, FirstName,lastname, Email from Contact limit 2];
    //Map<Id, Contact> conMap = new Map<Id,Contact>([SELECT Id, FirstName,lastname, Email from Contact where id IN Trigger.New]);
    for(sObject con : conList){
        for(Schema.SObjectField fieldAPI : M.values()){
            //system.debug('fieldAPI : '+fieldAPI);
            //system.debug('fieldAPI.getDescribe().getName() : '+fieldAPI.getDescribe().getName());
            
            string str = fieldAPI.getDescribe().getName();
            system.debug('str : '+str);
            if(con.get(str) != null){
                if(con.get(str) != False)
                //mapContact.get(con.LastName +'-'+con.email)
                system.debug(str +'-- : '+con.get(str));
            }
        }
    }

                      
}