public class TestAction {

    public PageReference testDebug() {
        System.debug('cityName : '+cityName);
        return null;
    }

    public string cityName{get; set;}
    public string cityName1{get; set;}
    public static List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        
        options.add(new SelectOption('US','US'));
        options.add(new SelectOption('CANADA','Canada'));
        options.add(new SelectOption('MEXICO','Mexico'));

        return options;
    }
    
}