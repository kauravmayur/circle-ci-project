public class discountOnAccount{

    @InvocableMethod
    public static void updateAccount(List<Account> accountDetails){
        Set<Id> accIds = new Set<Id>();
        
        for(Account acc: accountDetails){
            accIds.add(acc.Id);
        }
        
        List<Account> accList = [SELECT Id, Name, Amount__c, SLA__c from Account WHERE Id IN : accIds];
        
        for(Account acc: accList ){
            
            if(acc.SLA__c == 'Gold'){
                acc.Amount__c = acc.Amount__c *20/100;
            } 
            else if(acc.SLA__c == 'Silver'){
                acc.Amount__c = acc.Amount__c *15/100;
            }
            else if(acc.SLA__c == 'Platinum'){
                acc.Amount__c = acc.Amount__c *10/100;
            }
            else{
                acc.Amount__c = acc.Amount__c *5/100;
            }
        }
        
        Update accList;
        
    }
}