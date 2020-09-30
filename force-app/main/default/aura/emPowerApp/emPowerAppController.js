({
	doInit : function(component, event, helper) {
		var staticLabel = $A.get("$Label.c.Hello_World");
		component.set("v.mylabel", staticLabel);
	}
})