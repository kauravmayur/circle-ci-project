public class ContactController {
	@AuraEnabled
    public static list<contact> getContacts(){
        list<contact> contacts = [select id, name, mailingStreet, phone, email, level__c from contact];
        // Add isAccessible() check
        return contacts;
    }
    @AuraEnabled
    //Retrive all primary contacts
    public static list<contact> getPrimary(){
        list<contact> primaryContacts = [select id, name, mailingStreet, phone, email, level__c from contact where level__c ='Primary'];
        // Add isAccessible() check
        return primaryContacts;
    }
    
    @AuraEnabled(cacheable=true)
    public static list<contact> getContactList(){
        list<contact> contacts = [select id, name, mailingStreet, phone, email, level__c from contact limit 10];
        // Add isAccessible() check
        return contacts;
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> allAccountsWithContacts() {
        system.debug('*** allAccountsWithContacts ***');
        return [SELECT Id, Name, AccountNumber, (select id, name, mailingStreet, phone, email, level__c from Contacts) FROM Account LIMIT 10];
        
    }
    @AuraEnabled
    public static list<Account> getAccounts(){
        list<Account> accounts = [select id, name, AccountNumber, AnnualRevenue, SLAExpirationDate__c, Do_Not_Call__c from Account limit 10];
        // Add isAccessible() check
        return accounts;
    }
    @AuraEnabled
    public static Account saveExpense(Account expense) {
        // Perform isUpdateable() checking first, then
        upsert expense;
        return expense;
    }

}