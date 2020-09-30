@isTest
private class AccountProcessorTest{
    @isTest
    private static void testCountContacts(){
        Test.setMock(HttpCalloutMock.class, new AccountProcessorCalloutMock());
        Account acc = new Account(name = 'test');
        insert acc;
        list<Id> accIds = new List<Id>();
        accIds.add(acc.Id);
        List<Contact> conList = new List<Contact>();
        for(integer i=1; i<=5; i++){
            Contact con = new Contact();
            con.LastName = 'test LN'+i;
            con.AccountId = acc.Id;
            conList.add(con);
        }
        insert conList;
        Test.StartTest();
            AccountProcessor.countContacts(accIds);
        Test.StopTest();
    }
}