({
	doinitHelper : function(component, event) {
		console.log("do init helper...");
        var action = component.get("c.fetchAccountWrapper");
        action.setCallback(this, function(response){
            console.log("response.getState() : "+response.getState());
            var state = response.getState();
            if(state === "SUCCESS"){
                console.log("response.getReturnValue() : "+response.getReturnValue());
                var oRes = response.getReturnValue();
                console.log("oRes1323213 : "+oRes);
                if(oRes.length > 0){
                    component.set("v.listOfAllAccounts", oRes);
                    var pageSize = component.get("v.pageSize");
                    var totalRecordList = oRes;
                    var totalLength = totalRecordList.length;

                    component.set("v.startPage", 0);
                    component.set("v.totalRecordsCount", totalLength);
                    component.set("v.endPage", pageSize-1);

                    console.log("pageSize : "+pageSize);
                    console.log("totalLength : "+totalLength);
                    console.log("totalRecordList : "+totalRecordList);
                    
                    var paginationLst = [];
                    for(var i =0; i< pageSize; i++){
                        if(component.get("v.listOfAllAccounts").length > i){
                            paginationLst.push(oRes[i]);
                        }
                    }

                    console.log("paginationlist : "+paginationLst);
                    component.set("v.PaginationList", paginationLst);
                    component.set("v.selectedCount", 0);
                    component.set("v.totalPagesCount", Math.ceil(totalLength/pageSize));
                }
                else{
                    component.set("v.bNoRecordsFound", true);
                }
            }
            else{
                alert("Error...");
            }
        });
        $A.enqueueAction(action);
    },
    next : function(component,event,sObjectlist,start,end,pageSize){
        var paginationList =[];
        var counter = 0;
        for(var i = end + 1; i < end + pageSize +1 ; i++){
            if(sObjectlist.length > i){
                paginationList.push(sObjectlist[i]);
            }
        }
        counter++;
        start = start + counter;
        end = end +counter;
        component.set("v.startPage", start);
        component.set("v.endPage", end);
        component.set("v.PaginationList", paginationList);
        console.log("next counter : "+counter);
        console.log("next startPage : "+start);
        console.log("next endPage : "+end);
        console.log("next PaginationList : "+paginationList);
    },
    // navigate to previous pagination record set   
    previous : function(component,event,sObjectList,end,start,pageSize){
        var Paginationlist = [];
        var counter = 0;
        for(var i= start-pageSize; i < start ; i++){
            if(i > -1){
                if(component.find("selectAllId").get("v.value")){
                    Paginationlist.push(sObjectList[i]);
                }else{
                    Paginationlist.push(sObjectList[i]); 
                }
                counter ++;
            }else{
                start++;
            }
        }
        start = start - counter;
        end = end - counter;
        component.set("v.startPage",start);
        component.set("v.endPage",end);
        component.set('v.PaginationList', Paginationlist);
    }
})