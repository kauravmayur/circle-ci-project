public class callSoapAccountPlanClass{
    
    public static void callWebservices(){
        string username = 'kaurav@gmail.com';
        string password  ='welcome12#8o9WQ9QhA1peqG0LSTEbKT34q';
        partnerSoapSforceCom.Soap soapClass = new partnerSoapSforceCom.soap();
        partnerSoapSforceCom.LoginResult loginResult = soapClass.login(username, password);
        
        SoapAccountPlanClass.plan vPlan = new SoapAccountPlanClass.plan();

        vPlan.name = 'Test Webservice';
        vPlan.planNumber = 100;
        vPlan.planningPeriod = System.today();

        SoapAccountPlanClass.AccountPlan accountPlan = new SoapAccountPlanClass.AccountPlan();
        accountPlan.SessionHeader = new SoapAccountPlanClass.SessionHeader_element();
        accountPlan.SessionHeader.sessionId = loginResult.sessionId;
        accountPlan.createAccountPlan(vPlan);
        
    }
}