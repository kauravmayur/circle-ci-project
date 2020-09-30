({
	doinit : function(component, event, helper) {
		console.log('do init...');
        helper.doinitHelper(component, event);
    },

    /* javaScript function for pagination */
    navigation : function(component, event, helper){
        var sObjectlist = component.get("v.listOfAllAccounts");
        var start = component.get("v.startPage");
        var end = component.get("v.endPage");
        var pageSize = component.get("v.pageSize");
        var whichBtn = event.getSource().get("v.name");

        console.log('sObjectlist : '+sObjectlist);
        console.log('start : '+start);
        console.log('end : '+end);
        console.log('pageSize : '+pageSize);
        console.log('whichBtn : '+whichBtn);

        // Check if whichBtn value is 'next' then call 'next' helper method
        if(whichBtn == 'next'){
            component.set("v.currentPage", component.get("v.currentPage")+1);
            console.log('next whichBtn : '+component.get("v.currentPage"));
            helper.next(component,event,sObjectlist,start,end,pageSize);
        }
        
        // Check if whichBtn value is 'previous' then call 'previous' helper method
        if(whichBtn == 'previous'){
            component.set("v.currentPage", component.get("v.currentPage")-1);
            console.log('previous whichBtn : '+component.get("v.currentPage"));
            helper.previous(component,event,sObjectlist,start,end,pageSize);
        }
    }
})