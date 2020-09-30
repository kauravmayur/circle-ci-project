({
	doInitHelper : function(component, event) {
    
		console.log('doInit Helper...');
		var action = component.get("c.fetchAccount");
		action.setCallback(this, function(response){
			var state = response.getState();
			console.log('response.getState()----'+response.getState());
			if(state === "SUCCESS"){
				var oRes = response.getReturnValue();
				console.log('response.getTeturnValue()----'+response.getReturnValue());
				if(oRes.length > 0){
					console.log('Component has been set here...');
					component.set("v.listOfAllAccounts", oRes);
				}
				else{
					alert('Error...');
				}
			}
		});
		$A.enqueueAction(action);
	}
})