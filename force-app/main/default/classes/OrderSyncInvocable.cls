public with sharing class OrderSyncInvocable {
    public class Request {
        @InvocableVariable(required=true)
        public Id orderId;
    }
    @InvocableMethod(
        label='Start Order Sync'
        description='Starts Order validation asynchronously'
    )
    public static void startSync(List<Request> requests) {
        Set<Id> orderIds = new Set<Id>();
        for (Request req : requests) {
            if (req.orderId != null) {
                orderIds.add(req.orderId);
            }
        }
        if (orderIds.isEmpty()) {
            return;
        }
        for (Id orderId : orderIds) {
     System.enqueueJob( new OrderValidationQueueable( orderId, 0 ) );

        }
    }
}