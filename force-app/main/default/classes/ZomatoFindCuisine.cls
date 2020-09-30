global class ZomatoFindCuisine {
	@InvocableMethod
    global static List<String> cuisines( List<string> reqId ){
        System.debug('***ZomatoFindCuisine***'+reqId);
        return ZomatoAPI.findCuisines(reqId[0]);
    }
}