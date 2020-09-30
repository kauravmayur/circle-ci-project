global class ZomatoFindLocation {
	@InvocableMethod
    global static List<String> locate( List<String> location ){
        System.debug('***ZomatoFindLocation***'+location);
        return ZomatoAPI.locate(location[0]);
    }
}