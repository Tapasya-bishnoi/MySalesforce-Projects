public with sharing class OrderFulfillmentQueueable implements Queueable {
    private Id orderId;
    public OrderFulfillmentQueueable(Id orderId) {
        this.orderId = orderId;
    }
    public void execute(QueueableContext context) {
        // 1. Get Order
        Order ord = [SELECT Id, OrderNumber,Status,FulfillmentProcessed__c,	FulfillmentEventPublished__c FROM Order WHERE Id = :orderId LIMIT 1 FOR UPDATE];
        // 2. Idempotency check
        if (ord.FulfillmentProcessed__c == true) {
            System.debug('Fulfillment already processed for Order: '+ ord.OrderNumber);
            return;
        }
        // 3. Get original Order Items
        List<OrderItem> sourceItems = [SELECT Id, OrderId, Quantity, UnitPrice,  PricebookEntryId,Description, FulfillmentItem__c FROM OrderItem  WHERE OrderId = :orderId AND FulfillmentItem__c = false];
        if (sourceItems.isEmpty()) {
            throw new DmlException('No original OrderItems found for Order '+ ord.OrderNumber);
        }
        // 4. Check whether fulfillment items already exist
        List<OrderItem> existingFulfillmentItems = [ SELECT Id FROM OrderItem WHERE OrderId = :orderId AND FulfillmentItem__c = true LIMIT 1 ];
        if (!existingFulfillmentItems.isEmpty()) {
            System.debug('Fulfillment OrderItems already exist.');
            ord.FulfillmentProcessed__c = true;
            update ord;
            return;
        }
        // 5. Create fulfillment OrderItems
        List<OrderItem> fulfillmentItems = new List<OrderItem>();
        for (OrderItem sourceItem : sourceItems) {
            OrderItem fulfillmentItem =new OrderItem();
            fulfillmentItem.OrderId =sourceItem.OrderId;
            fulfillmentItem.PricebookEntryId =sourceItem.PricebookEntryId;
            fulfillmentItem.Quantity =sourceItem.Quantity;
            fulfillmentItem.UnitPrice =sourceItem.UnitPrice;
            fulfillmentItem.Description ='Fulfillment for OrderItem '+ sourceItem.Id;
            fulfillmentItem.FulfillmentItem__c =true;
            fulfillmentItems.add(fulfillmentItem);
        }
        // 6. Insert fulfillment OrderItems
        insert fulfillmentItems;
        System.debug('Created fulfillment OrderItems: '+ fulfillmentItems.size());
        // 7. Mark fulfillment as processed
        ord.FulfillmentProcessed__c = true;
        update ord;
        // 8. Publish YOUR actual Platform Event
        if (
            ord.FulfillmentEventPublished__c != true
        ) {
            String fulfillmentKey ='ORDER-' + String.valueOf(orderId);
            OrderFullfillment__e fulfillmentEvent =new OrderFullfillment__e(Fulfillment_Key__c =fulfillmentKey,Order_Id__c =String.valueOf(orderId),
                    Order_Number__c =ord.OrderNumber);

            // 9. Publish event
            Database.SaveResult eventResult =EventBus.publish(fulfillmentEvent);
            // 10. Check event result
            if (!eventResult.isSuccess()) {
                System.debug('OrderFulfillment event failed: '+ eventResult.getErrors());
                throw new DmlException('Failed to publish OrderFulfillment__e' );
            }
            // 11. Mark event as published
            ord.FulfillmentEventPublished__c =true;

            update ord;
        }
        System.debug('Order fulfillment completed for Order: '+ ord.OrderNumber);
    }
}