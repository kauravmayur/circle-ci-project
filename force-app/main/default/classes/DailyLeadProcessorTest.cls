@isTest
public class DailyLeadProcessorTest{
    public static String CRON_EXP = '0 5 * * * ? ';
    @isTest static void scheduleTestMethod(){
        List<Lead> leadList = new List<Lead>();
        for(integer i=0; i<200; i++){
            Lead l = new Lead();
            l.LastName = 'LeadLN'+i;
            l.Company = 'Company'+i;
            l.Status = 'Open - Not Contacted';
            l.LeadSource = '';
            leadList.add(l);
            //insert leadList;
        }
        
        Test.Starttest();
            insert leadList;
            system.assertEquals(200, leadList.Size());
            String jobId = System.Schedule('Schedule New Job', CRON_EXP, new DailyLeadProcessor());
            
        Test.StopTest();
        List<Lead> leadList1 = [SELECT ID, Name, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        system.assertEquals(0, leadList1.Size());
    }
}