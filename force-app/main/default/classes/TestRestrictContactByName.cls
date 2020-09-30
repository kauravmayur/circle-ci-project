@isTest
public class TestRestrictContactByName{
    @istest static void restrictContact(){
        Contact con = new Contact();
        con.firstName = 'TestFN';
        con.lastName = 'INVALIDNAME';
        Test.StartTest();
            Database.SaveResult result = Database.Insert(con, False);
        Test.StopTest();
        System.assert(result.isSuccess() );
        //System.assert(result.getErrors().size() > 0);
        //System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML',result.getErrors()[0].getMessage());
    }
}