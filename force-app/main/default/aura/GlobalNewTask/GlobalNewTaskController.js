({
    doInit : function(component, event, helper) {

        helper.getRecordTypes(component);
    },


    handleRecordTypeChange : function(component, event, helper) {

        var recordTypeId = event.getParam("value");
        component.set( "v.selectedRecordTypeId", recordTypeId);
        
    },


    handleNext : function(component, event, helper) {

        var recordTypeId = component.get("v.selectedRecordTypeId");

        if (!recordTypeId) {

            var toast = $A.get("e.force:showToast");

            toast.setParams({
                title: "Error",
                message: "Please select a Task Record Type.",
                type: "error"
            });

            toast.fire();

            return;
        }

        component.set(
            "v.showTaskForm",
            true
        );
    },


    handleSuccess : function(component, event, helper) {

        var toast = $A.get("e.force:showToast");

        toast.setParams({
            title: "Success",
            message: "Task created successfully.",
            type: "success"
        });

        toast.fire();

        $A.get("e.force:closeQuickAction").fire();
    },


    handleError : function(component, event, helper) {

        var toast = $A.get("e.force:showToast");

        toast.setParams({
            title: "Error",
            message: "Unable to create Task.",
            type: "error"
        });

        toast.fire();
    }
})