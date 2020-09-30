({  
   doInit :function(component,event,helper){  
     // Apex method definition  
     var action = component.get("c.loadData");  
     // callbak function  
     action.setCallback(this,function(response){  
       //get state  
       var state = response.getState();  
       // check if state is 'SUCCESS'  
       if(state == 'SUCCESS'){  
         var result = response.getReturnValue();  
         //set value to "UnfilteredData" attaribute   
         component.set("v.UnfilteredData",result);  
         console.log(result);  
         // set value to "data" attaribute  
         component.set("v.data",result);  
       }else{  
         console.log('something bad happend! ');  
       }  
     });  
     // put the action into queue for server call.  
     $A.enqueueAction(action);  
   },  
   doFilter: function(component, event, helper) {  
     //calling helper  
     helper.FilterRecords(component);  
   }  
 })