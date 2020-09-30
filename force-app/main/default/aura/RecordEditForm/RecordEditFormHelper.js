({
    handleFormSubmit: function(component) {
        var showValidationError = false;
        var fields = component.find("field");
        var vaildationFailReason = '';
        var popupWindow = '';
        fields.forEach(function (field) {
            if(field.get("v.fieldName") === 'AnnualRevenue' && $A.util.isEmpty(field.get("v.value"))){
                showValidationError = true;
                //alert(document.getElementById("annualRevenue").innerHTML);
                //component.find('annualRevenue').innerHTML = "The field cannot be empty!";
                popupWindow = component.find('annualRevenue').getElement();
                if(popupWindow){
                    popupWindow.style.display = 'block';
                }
                else{
                    popupWindow.style.display = 'none';
                }
            } else if (field.get("v.fieldName") === 'AccountNumber' && $A.util.isEmpty(field.get("v.value"))) {
                showValidationError = true;
                popupWindow = component.find('accountNumber').getElement();
                if(popupWindow){
                    popupWindow.style.display = 'block';
                }
                else{
                    popupWindow.style.display = 'none';
                }
                //vaildationFailReason = (vaildationFailReason === '')? "The field 'Account Number' cannot be empty!" : vaildationFailReason +'/n'+"The field 'Account Number' cannot be empty!";
            }
        });
        
        if (!showValidationError) {
            component.set('v.loading', true);
            component.find("accForm").submit();  
        } else {
            component.find('OppMessage').setError(vaildationFailReason);
            component.set('v.loading', false); 
        }
    },
})