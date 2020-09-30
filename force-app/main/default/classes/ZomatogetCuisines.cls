global class ZomatogetCuisines {
	@InvocableMethod
    global static List<List<String>> cuisines( List<string> reqId ){
        System.debug('***ZomatogetCuisines***'+reqId);
        List<String> cuisines = ZomatoAPI.getCuisines(reqId[0]);
        return new List< List<String> >{cuisines};
    }
}