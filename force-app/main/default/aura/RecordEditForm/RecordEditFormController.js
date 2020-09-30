({
	
    handleReset: function(cmp, event, helper) {
        cmp.find('field').forEach(function(f) {
            f.reset();
        });
    },
    handleOnLoad : function(component, event, helper) {
        
    },
    handleOnSubmit : function(component, event, helper) {
        event.preventDefault();
        helper.handleFormSubmit(component);
    },
    
    handleOnSuccess : function(component, event, helper) {
        
    },
    
    handleOnError : function(component, event, helper) {
    
    },  
})