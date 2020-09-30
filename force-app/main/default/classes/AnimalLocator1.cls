public class AnimalLocator1 {
    public static string getAnimalNameById(Integer inte){
        String response =  makeGetCallout(inte);
        system.debug('response : '+response);
        return response;
    }
    public static string makeGetCallout(integer ids){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+ids);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        Map<String, Object> animals = new Map<String, Object>();
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200){
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            animals = (Map<String, Object> )results.get('animal');
			system.debug('animals : '+animals.get('id'));
        }
        return (String)animals.get('name');
    }
}