public class ParkLocator {
    public static List<string> country(String country){
        ParkService.ParksImplPort parkServices = new ParkService.ParksImplPort();

        system.debug('parkServices.byCountry(country) ****** : '+parkServices.byCountry(country));
        return parkServices.byCountry(country);
    }
}