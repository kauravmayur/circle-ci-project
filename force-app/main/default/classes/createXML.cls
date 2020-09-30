public class createXML{
  
  //SendRequest function sends a set of XML data to an END point URL. The RAW data is then processed in ReadResponse that will convert the XML into a List
  public void sendRequest(list<account> accList) {
    // Get the list of accounts for which we need the updated values from the external system
    //List < Account > accountList = new List < Account([Select name from Account limit 2]);
    List < Account > accountList = accList;
    
    // Start preparing the XML
    XmlStreamWriter w = new XmlStreamWriter();
    w.writeStartDocument(null, '1.0'); //Start the XML document
    w.writeStartElement(null, 'accounts', null); //this will start with <accounts> in XML

    //Loop through the accounts we queried earlier and put the values into XML
    for (Account a: accountList) {
        // This will write <account> in the XML file
        w.writeStartElement(null, 'account', null);
        // Open the tag <accountID> that will be identified by the external system
        w.writeStartElement(null, 'accountid', null); 
        // Write the value of externalID to be send
        w.writeCharacters(a.name); 
        //close </accountid>
        w.writeEndElement(); 
        //close </account>
        w.writeEndElement(); 
    }

    //close </accounts>
    w.writeEndElement(); 
    w.writeEndDocument();
    system.debug('----w.getXmlString() : '+w.getXmlString());
    String xmlOutput = w.getXmlString();
    system.debug('----xmlOutput : '+xmlOutput);
    
    w.close();
    
    /*
    //Now that we have XML we will pass this to external system using HttpRequest
    System.HttpRequest request = new System.HttpRequest();

    // Set the endpoint URL previously decided that will know how to handle the XML 
    // we send them. Basically it will contain the code to read the values we are 
    // sending and send the data back.
    request.setEndpoint('https://integration.yourService.com/someEnpoint'); 
    // This line is important to tell the server you are passing XML input.
    request.setHeader('Content-Type', 'application/xml'); 
    request.setMethod('POST');
    // Set the XMLOutput we have created in the class above
    request.setBody(xmlOutput); 

    //This is like dialing on a telephone, we send the data and wait for the response.
    System.HttpResponse response = new System.Http().send(request); 
    this.Response = response.getBody();
    //And here we read the response. We will then process the response
    XmlStreamReader reader = new XmlStreamReader(this.Response); 
    readResponse(reader);
    */
  }
}