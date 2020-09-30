({
    doInit : function(component, event, helper) {
        var action = component.get("c.getUserDetails");
        action.setCallback(this, function(response) {
            debugger;
            var state = response.getState();
            console.log("user Id: "+response.getReturnValue().Name);
            console.log("Manager Id: "+response.getReturnValue().Manager.Name);
            if (state === "SUCCESS") {
                component.set("v.user", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    
    saveData : function(component, event, helper) {
        var result = component.get("v.startDate");
        console.log('result : '+result);
        var action = component.get("c.saveLeave");
        action.setParams({
            "startDate": result
        });
        action.setCallback(this, function(response) {
            debugger;
            var state = response.getState();
            if (state === "SUCCESS") {
                
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    handleOnLoad : function(component, event, helper) {
        
    },
    handleOnSubmit : function(component, event, helper) {
        
    },
    
    handleOnSuccess : function(component, event, helper) {  
    },
    
    handleOnError : function(component, event, helper) {
    
    },
})