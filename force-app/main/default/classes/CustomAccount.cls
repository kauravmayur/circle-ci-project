public with sharing class CustomAccount {

    public string accName {get; set;}
    public List<Account> account;

    public string customId {get; set;}
    public string recordName {get; set;}

    public CustomAccount(ApexPages.StandardController controller) {

    }
    
    public void saveAccount() {
        Account acc = new Account();
        acc.Name = accName;
        
        
        insert acc;
    }
    
    public void updateProgress() {
        //System.debug('recordName :: ' + recordName);
        recordName = apexpages.currentPage().getParameters().get('recordName');
        customId = apexpages.currentPage().getParameters().get('customId');
        //
        System.debug('recordName :: ' + recordName);
        System.debug('customId :: ' + customId);
        Account acc = new Account();
        acc.Id = customId;
        acc.Name = recordName;
        
        System.debug(acc);
        update acc;          
    
    }

    public List<Account> getPrintAccounts() {
    
        account = [Select Id, Name, (Select Id, LastName from Contacts order by Id desc) from Account Limit 10];
        return account;
    }
    
}