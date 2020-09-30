@isTest
public class TestVerifyDate{
    
    //date date3 = system.today() -3;
    @isTest static void CheckDates1(){
        date date1 = system.today();
        date date2 = system.today() + 2;
        Date dt = VerifyDate.CheckDates(date1, date2);
    }
    
   @isTest static void CheckDates2(){
        date date1 = system.today() - 20;
        date date2 = system.today() + 31;
        Date dt = VerifyDate.CheckDates(date1, date2);
    }
}