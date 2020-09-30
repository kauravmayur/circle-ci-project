@RestResource(urlMapping='/accounts/')
global class AccountRest{

@HttpGet
  global static String getAccountInfo(){
    //try{
      RestRequest req =  RestContext.request;
      restResponse res = RestContext.response;
      //String accountName = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
      /*
      Account account = [SELECT Id, Name FROM Account WHERE Name Like 'accountName%'];
      if(account != null)
        return 'found';
      else
        return 'not found';
    }
    catch(Exception e){
      System.debug('----Exception : '+e.getMessage());
      */
      System.debug('----Test Rest API--- ');
      return 'Test';
    //}
  }
}