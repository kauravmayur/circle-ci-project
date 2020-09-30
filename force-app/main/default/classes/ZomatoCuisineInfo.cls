public class ZomatoCuisineInfo {
	public List<Cuisines> cuisines;
    
    public class Cuisines {
		public CuisineInfo CuisineInfo;
	}
    
    public class CuisineInfo{
        public string cuisine_id;
    	public string cuisine_name;
	}
	
    public static ZomatoCuisineInfo parse(String json) {
        return (ZomatoCuisineInfo) System.JSON.deserialize(json, ZomatoCuisineInfo.class);
    }
}