public class OrderValidationFinalizer implements Finalizer {
    private Id orderId;
    private Integer retryCount;
    public OrderValidationFinalizer(Id orderId,Integer retryCount) {
        this.orderId = orderId;
        this.retryCount = retryCount;
    }
    public void execute(FinalizerContext context) {
        Exception ex =context.getException();
        // Queueable completed successfully
        if (ex == null) {
            return;
        }
        System.debug('Order validation failed: ' +ex.getMessage());
        // Retry #1 and Retry #2
        if (retryCount < 2) {
            Integer nextRetry = retryCount + 1;
            System.debug('Starting retry #' + nextRetry);
            System.enqueueJob(new OrderValidationQueueable(orderId,nextRetry));
            return;
        }        
        // Maximum retries reached
        Order ord = [SELECT Id,OrderNumber FROM Order WHERE Id = :orderId  LIMIT 1];
        Order_Validation_Failed__e failureEvent =new Order_Validation_Failed__e(
                OrderId__c =String.valueOf(ord.Id), OrderNumber__c = ord.OrderNumber,
                Failure_Reason__c ='Inventory API failed after 2 retries: ' +ex.getMessage(),
                Retry_Count__c =retryCount
            );
        Database.SaveResult result =EventBus.publish(failureEvent);
        if (!result.isSuccess()) {
            System.debug('Unable to publish failure event: ' +result.getErrors());
        }
    }
    }