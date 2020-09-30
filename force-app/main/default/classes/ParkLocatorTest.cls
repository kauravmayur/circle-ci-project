@isTest
public class ParkLocatorTest {
    @isTest static void parkListMethod(){
        Test.setMock(WebServiceMock.Class, new ParkServiceMock());
        List<String> results = ParkLocator.country('India');
        System.assertEquals(new List<String>{'Anamudi Shola National Park,Anshi National Park,Bandipur National Park'}, results);
    }
}