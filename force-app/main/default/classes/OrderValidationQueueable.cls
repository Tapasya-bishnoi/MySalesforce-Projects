public with sharing class OrderValidationQueueable  implements Queueable, Database.AllowsCallouts {
    private Id orderId;
    private Integer retryCount;
    public OrderValidationQueueable(Id orderId,Integer retryCount) {
        this.orderId = orderId;
        this.retryCount = retryCount;
    }
   public void execute(QueueableContext context) {
        /*
         * Attach Finalizer.
         * If this Queueable throws an exception,
         * the Finalizer will handle retry logic.
         */
      System.attachFinalizer(new OrderValidationFinalizer(orderId,retryCount));
        // 1. Get Order
      Order ord = [ SELECT Id,OrderNumber,Status FROM Order WHERE Id = :orderId  LIMIT 1 ];
        // 2. Create HTTP Request
      HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Order_Validation_API/api/inventory/check');
        request.setMethod('POST');
        request.setHeader('Content-Type','application/json');
        // 3. Request Body
        Map<String, Object> requestBody = new Map<String, Object>();
        requestBody.put('orderId',String.valueOf(ord.Id));     
         requestBody.put('orderNumber',ord.OrderNumber);
        request.setBody(JSON.serialize(requestBody));
        // 4. Call Inventory API
        Http http = new Http();
        HttpResponse response = http.send(request);
        Integer statusCode = response.getStatusCode();
        String responseBody =response.getBody();
        System.debug('Inventory API Status Code: ' +statusCode);
        System.debug('Inventory API Response: ' +responseBody);
        // 5. HTTP Error
        if (statusCode < 200 ||statusCode >= 300) {
            throw new CalloutException('Inventory API returned HTTP ' +statusCode + ': ' +responseBody);
        }
        // 6. Parse API Response
        InventoryResponse result = (InventoryResponse) JSON.deserialize( responseBody,InventoryResponse.class );
        // 7. Inventory Available
        if (result.available == true) {
            System.enqueueJob(new OrderFulfillmentQueueable(orderId));
        }
        // 8. Inventory Not Available
        else {
            publishFailureEvent(ord,result.message,retryCount );
        }
    }
    // API Response Wrapper
    public class InventoryResponse {
        public Boolean available;
        public Integer availableQuantity;
        public String message;
    }
    // Publish Failure Platform Event
    private static void publishFailureEvent(Order ord,String failureReason,Integer retryCount) {
        Order_Validation_Failed__e failureEvent =new Order_Validation_Failed__e(
                OrderId__c =String.valueOf(ord.Id),
                OrderNumber__c =ord.OrderNumber,
                Failure_Reason__c = failureReason,
                Retry_Count__c =retryCount
            );
        Database.SaveResult result =EventBus.publish(failureEvent);
        if (!result.isSuccess()) {
            System.debug('Failure Platform Event error: ' +result.getErrors());
        }
    }
}