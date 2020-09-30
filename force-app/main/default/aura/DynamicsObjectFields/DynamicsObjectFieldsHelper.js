({
    doInitHelper : function(component, event) {
    
		console.log('doInit Helper...');
		var action = component.get("c.fetchObjects");
		action.setCallback(this, function(response){
			var state = response.getState();
			console.log('response.getState()----'+response.getState());
			if(state === "SUCCESS"){
				var oRes = response.getReturnValue();
				console.log('response.getTeturnValue()----'+response.getReturnValue());
				if(oRes.length > 0){
					console.log('Component has been set here...');
					component.set("v.listOfAllObjects", oRes);
					//this.handleClickHelper(component, event);
				}
				else{
					alert('Error...');
				}
			}
		});
		$A.enqueueAction(action);
	},
    handleClickHelper : function(component, event) {
		console.log('handleClick Helper...');
        var selectedObject = component.find("sObjects").get("v.value");
		
		
		var action = component.get("c.ObjectFields");
		if(selectedObject == ''){
			selectedObject = 'account';
		}
		console.log('selectedObject : '+selectedObject);
		action.setParams({ "SelectedObject":selectedObject });
		action.setCallback(this, function(response){
			var state = response.getState();
			console.log('response.getState()----'+response.getState());
			if(state === "SUCCESS"){
				component.set("v.options", '');
				component.set("v.values", '');
				var oRes = response.getReturnValue();
				console.log('response.getTeturnValue()----'+response.getReturnValue());
				component.set("v.options", oRes);
				
			}
			else{
				alert('Unable to process...');
			}
		});
		$A.enqueueAction(action);
        
	},
	handleChangeHelper : function(component, event) {
		console.log('handleChange Helper...');
		
		var selectedObject = component.find("sObjects").get("v.value");
		if(selectedObject == ''){
			selectedObject = 'account';
		}
		console.log('selectedObject : '+selectedObject);

		var options =  component.get("v.options");
		var values =  component.get("v.values");
		var columnArray = [];
		console.log('options : '+options);
		console.log('values : '+values);
		
		var action = component.get("c.ShowTable");
		
		action.setParams({ 
			"SelectedObject":selectedObject,
			"SelectedFields":values
		});
		action.setCallback(this, function(response){
			var state = response.getState();
			console.log('response.getState()----'+response.getState());
			if(state === "SUCCESS"){
				var oRes = response.getReturnValue();
				console.log('response.getTeturnValue()----'+response.getReturnValue());
				component.set("v.columns", '');
				
				var columnMap = [];

			for(var i =0; i<values.length; i++){
				columnMap.push({label: values[i], fieldName: values[i]});
			}
				console.log('columnMap 2----'+columnMap);
				component.set("v.columns", columnMap);
				component.set('v.data',oRes);
				
			}
		});
		$A.enqueueAction(action);
	}
})