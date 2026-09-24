({
    doInit : function(component, event, helper) {

        helper.getRecordTypes(component);
    },


    handleRecordTypeChange : function(component, event, helper) {

        var recordTypeId = event.getParam("value");

        component.set(
            "v.selectedRecordTypeId",
            recordTypeId
        );
    },


    handleNext : function(component, event, helper) {

        var recordTypeId =
            component.get("v.selectedRecordTypeId");

        if (!recordTypeId) {

            var toast = $A.get("e.force:showToast");

            toast.setParams({
                title: "Error",
                message: "Please select an Opportunity Record Type.",
                type: "error"
            });

            toast.fire();

            return;
        }

        component.set(
            "v.showOpportunityForm",
            true
        );
    },


    handleSuccess : function(component, event, helper) {

        var toast = $A.get("e.force:showToast");

        toast.setParams({
            title: "Success",
            message: "Opportunity created successfully.",
            type: "success"
        });

        toast.fire();

        $A.get("e.force:closeQuickAction").fire();
    },


    handleError : function(component, event, helper) {

        var toast = $A.get("e.force:showToast");

        toast.setParams({
            title: "Error",
            message: "Unable to create Opportunity.",
            type: "error"
        });

        toast.fire();
    }
})