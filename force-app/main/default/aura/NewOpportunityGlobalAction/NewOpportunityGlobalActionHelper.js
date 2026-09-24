({
    getRecordTypes : function(component) {

        var action = component.get("c.getOpportunityRecordTypes");


        action.setCallback( this,
            function(response) {

                var state = response.getState();

                console.log("Record Type State: " + state);

                if (state === "SUCCESS") {

                    var recordTypes =
                        response.getReturnValue();

                    console.log( "Opportunity Record Types: ", recordTypes);


                    var options = [];


                    recordTypes.forEach(
                        function(recordType) {

                            options.push({
                                label: recordType.Name,
                                value: recordType.Id
                            });

                        }
                    );


                    component.set(
                        "v.recordTypeOptions",
                        options
                    );

                }
                else {

                    console.log(
                        "Error: ",
                        response.getError()
                    );


                    var toast =
                        $A.get("e.force:showToast");


                    toast.setParams({
                        title: "Error",
                        message: "Unable to load Opportunity Record Types.",
                        type: "error"
                    });


                    toast.fire();
                }
            }
        );


        $A.enqueueAction(action);
    }
})