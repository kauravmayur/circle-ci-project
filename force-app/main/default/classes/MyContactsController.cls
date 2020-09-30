public class MyContactsController {
	@AuraEnabled
    public static List<Contact> getContacts(List<Id> accountIds){
        List<Contact> contactList = [SELECT Id, Name, Phone, Email, AccountId FROM Contact where AccountID IN: accountIds];
        return contactList;
    }
}