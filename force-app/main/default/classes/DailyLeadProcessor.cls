global class DailyLeadProcessor implements schedulable{
    global void execute(schedulableContext SC){
        /*
        List<Lead> leadList =   [SELECT
                                 ID, Name, LeadSource  
                                 FROM Lead
                                 WHERE LeadSource = ''
                                ];
        System.debug('*** leadList : '+leadList.Size());
        for(Lead l: leadList){
            l.LeadSource  = 'Dreamforce';
        }
        
        update leadList;
        */
        
        updateAccontBatch batch = new updateAccontBatch();
        id batchClass = Database.executeBatch(batch);
    }
}