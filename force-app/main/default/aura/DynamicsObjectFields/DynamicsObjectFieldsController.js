({
    
    doinit : function(component, event, helper) {
        console.log('doinit...');
        helper.doInitHelper(component, event);
        helper.handleChangeHelper(component, event);
    },
    // function automatic called by aura:waiting event  
    showSpinner: function(component, event, helper) {
        // make Spinner attribute true for displaying loading spinner 
        component.set("v.spinner", true); 
    },

    // function automatic called by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
        // make Spinner attribute to false for hiding loading spinner    
        component.set("v.spinner", false);
    },
    handleClick : function(component, event, helper) {
        console.log('handleClick...');
		helper.handleClickHelper(component, event);
    },
    handleChange : function(component, event, helper) {
        console.log('handleChange...');
		helper.handleChangeHelper(component, event);
    },
    handleSaveEdition : function(component, event, helper) {
        console.log('handleSaveEdition...');
		helper.handleSaveEditionHelper(component, event);
    }
    
})