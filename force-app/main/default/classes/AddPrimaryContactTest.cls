@isTest(SeeAllData = false)
public class AddPrimaryContactTest{
    @testSetup
    static void setup(){
        List<Account> accList = new List<Account>();
        for(integer i=1; i<50; i++){
            Account acc =  new Account();
            acc.name = 'Test'+i;
            acc.BillingState  = 'NY';
            accList.add(acc);
        }
        
        for(integer i=1; i<50; i++){
            Account acc =  new Account();
            acc.name = 'Test'+i;
            acc.BillingState  = 'CA';
            accList.add(acc);
        }
        insert accList;
    }
    @isTest
    static void AddPrimaryContactTestMethod(){
        
        List<Account> accList = [SELECT id, name, BillingState from Account];
        
        Contact con = new Contact();
        con.lastName = 'TestLN';
        con.firstName = 'TestFN';
        insert con;
        
        string state = 'CA';
        AddPrimaryContact apc = new AddPrimaryContact(con, state);
        Test.StartTest();
        system.enqueueJob(apc);
        Test.StopTest();
        
        System.assertEquals(50, [SELECT Count() from Contact]);
    }
}