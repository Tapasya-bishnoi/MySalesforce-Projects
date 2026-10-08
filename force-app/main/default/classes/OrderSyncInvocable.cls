public with sharing class OrderSyncInvocable {

    public class Request {

        @InvocableVariable(required=false)
        public Id orderId;

        @InvocableVariable(required=false)
        public String name;
    }

    @InvocableMethod(
        label='Start Order Sync'
        description='When the user says hello, returns Hi Tapasya.'
    )
    public static List<String> startSync(List<Request> requests) {

        List<String> results = new List<String>();
        Set<Id> orderIds = new Set<Id>();

        for (Request req : requests) {

            // Greeting response
            if (req.name != null) {
                results.add('Hi Tapasya!');
            }

            // Your existing Order Sync logic
            if (req.orderId != null) {
                orderIds.add(req.orderId);
            }
        }

        // Existing Order Sync logic
        for (Id orderId : orderIds) {

            System.enqueueJob(
                new OrderValidationQueueable(orderId, 0)
            );
        }

        return results;
    }
}