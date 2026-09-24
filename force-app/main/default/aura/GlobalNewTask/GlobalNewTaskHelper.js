({
    getRecordTypes : function(component) {

        var action = component.get("c.getTaskRecordTypes");

        action.setCallback(this, function(response) {

            var state = response.getState();

            console.log("Record Type State: " + state);

            if (state === "SUCCESS") {

                var recordTypes = response.getReturnValue();

                console.log("Record Types: ", recordTypes);

                var options = [];

                recordTypes.forEach(function(recordType) {

                    options.push({
                        label: recordType.Name,
                        value: recordType.Id
                    });

                });

                component.set(
                    "v.recordTypeOptions",
                    options
                );

            } else {

                console.log(
                    "Error loading Record Types: ",
                    response.getError()
                );

                var toast = $A.get("e.force:showToast");

                toast.setParams({
                    title: "Error",
                    message: "Unable to load Task Record Types.",
                    type: "error"
                });

                toast.fire();
            }
        });

        $A.enqueueAction(action);
    }
})