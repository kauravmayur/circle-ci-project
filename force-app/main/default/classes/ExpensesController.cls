public with sharing class ExpensesController {
	@AuraEnabled
    public static list<Expense__c> getExpenses(){
        system.debug('@@@ getExpenses @@@');
        return [SELECT Id, Name, Amount__c, Client__c, Date__c, 
                Reimbursed__c, CreatedDate 
                FROM Expense__c];
    }
    @AuraEnabled
    public static Expense__c saveExpense(Expense__c expense) {
        system.debug('@@@ saveExpense @@@');
        // Perform isUpdatable() checking first, then
        upsert expense;
        return expense;
    }
}