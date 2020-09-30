public with sharing class CampingListController {
	@AuraEnabled
    public static list<Camping_Item__c> getItems(){
        system.debug('@@@ getItems @@@');
        return [SELECT Id, Name, Packed__c, Price__c, Quantity__c
                FROM Camping_Item__c];
    }
    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c item) {
        system.debug('@@@ saveExpense @@@');
        // Perform isUpdatable() checking first, then
        upsert item;
        return item;
    }
}