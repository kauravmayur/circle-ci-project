public class AccountProcessor{
    @future(callout=true)
    public static void countContacts(List<Id> accountIds){
        /*
        list<Account> accountList = [Select id, name, Number_of_Contacts__c,(select id,name from contacts) from account where id IN:accountIds];
        for(Account acc: accountList){
            acc.Number_of_Contacts__c = acc.contacts.size();
        }
        update accountList;
        */
    }
}