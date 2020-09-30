@RestResource(urlMapping='/v1/getContact/*')
global with sharing class getContact {
    @Httpget
    global static LIST<contact> fetchAccount(){
    	RestRequest req = RestContext.request;
    	RestResponse res = RestContext.response;
    	id accid = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
    	LIST<contact> lstContact = [select id, name, phone,fax, email from contact where accountId =:accid];
    	return lstContact;
    }
}