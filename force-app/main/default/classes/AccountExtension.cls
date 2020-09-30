public class AccountExtension {
    //AccountExtension class
    public string accountName{get; set;}
    public AccountExtension(){
        accountName = '';
    }
    public AccountExtension(ApexPages.StandardController controller) {

    }
    public void saveAccount(){
        
        system.debug('Account name : '+accountName);
        Account acc = new Account();
        acc.name = accountName;
        insert acc;
    }

}