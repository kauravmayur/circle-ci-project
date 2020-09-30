global class updateAccontBatch implements Database.Batchable<sObject>,Database.Stateful{
    global List<Account> accountList = new List<Account>();
    global Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'SELECT id, Name,description, site, Industry From Account';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Account> accList){
        List<Account> updateAccounts = new List<Account>();
        for(Account acc: accList){
            if(acc.site != null){
                //acc.description = acc.Name +'-'+acc.Industry;
                //acc.site = acc.Name +'-'+acc.Industry;
                acc.description = '';
                acc.site = '';
                System.debug('acc.description : '+acc.description);
                System.debug('acc.site : '+acc.site);
                accountList.add(acc);
                updateAccounts .add(acc);
                
            }
            else{
                //acc.site = acc.Name;
                //acc.description = acc.Name;
                acc.site = '';
                acc.description = '';
                accountList.add(acc);
                updateAccounts.add(acc);
            }
        }
        //update updateAccounts ;
        Database.SaveResult[] srList = Database.update(updateAccounts , false);
        for(Database.SaveResult sr: srList){
            if(sr.isSuccess()){
                System.debug('Successfully Inserted');
                
            }
            else{
                for(Database.Error err: sr.getErrors()){
                    System.debug('The followiong error has occured');
                    System.debug('Status code: '+ err.getStatusCode());
                    System.debug('Error Message : '+err.getMessage());
                    System.debug('Error field : '+err.getFields());
                    //accountList(sr.Id());
                }
            }
        }
    }
    global void finish(Database.BatchableContext bc){
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        System.debug('job Details : '+job );
        System.debug('accountList : '+accountList.size());
    }
}