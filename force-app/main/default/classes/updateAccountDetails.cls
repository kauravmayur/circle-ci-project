public  class updateAccountDetails{
    public map<Id, List<Contact>> contactMap{get; set;}
     public updateAccountDetails(){
        system.debug('***updateAccountDetails***');
        List<Contact> conlist = [Select Id, Name from Contact];
        System.debug('updateAccountDetails conlist : '+conlist.size());

        
    }
    public void AccountList(List<Account> accList){
        system.debug('accList : '+accList);
        for(Account acc: accList){
            if(acc.site != null){
                acc.description = updateDescription(acc);
                acc.site = updateDescription(acc);
                System.debug('acc.description : '+acc.description);
                System.debug('acc.site : '+acc.site);
            }
        }
    } 
    public string updateDescription(Account acc){
        return acc.Name +'-'+acc.Industry;
        
        
    }

    public List<Account> getAccounts(){
        contactMap = new map<Id, List<Contact>>();
        list<Account> accList = [Select Id, name,(Select Id, Name from Contacts) from Account];
        for(account acc: accList){
            contactMap.put(acc.Id, acc.Contacts);
        }
        return accList;
    }
        
}