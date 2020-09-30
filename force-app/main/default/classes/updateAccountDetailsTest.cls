@isTest(seeAllData = false )
public class updateAccountDetailsTest {
    @TestSetup
    public static void createAccount(){
        List<Account> accList = new List<Account>();
        Account acc = new Account();
        acc.name = 'Test';
        acc.Industry = 'Agriculture';
        acc.site = 'site';
        accList.add(acc);
        
        insert accList;
    }
    static testMethod void updateAccount(){
        LIst<Account> accList = [SELECT Id, Name, Industry, Site, Description from Account];
        
        Test.StartTest();
            updateAccountDetails uad = new updateAccountDetails();
            uad.AccountList(accList);
            System.debug('accList : '+accList);
            System.assert(accList[0].description == 'Test-Agriculture');
            System.assertEquals(accList[0].description, 'Test-Agriculture');
            System.assertNotEquals(accList[0].description, 'Test-other');
        Test.StopTest();
    }
}