
29.1
# MySalesforce-Projects

# Order Synch Orchestrator

## Apex Classes

### 1. OrderSyncInvocable

- Invoked from Salesforce Flow when an Order is Activated.
- Receives the Order Id and starts the asynchronous synchronization process.
- Enqueues the validation Queueable job.

### 2. OrderValidationQueueable

- Validates Order data against the external inventory API.
- Uses the configured Named Credential for the API callout.
- Handles successful and failed validation scenarios.

### 3. OrderFulfillmentQueueable

- Creates OrderItem fulfillment records after successful validation.
- Publishes the Order Fulfillment Platform Event.
- Includes idempotency handling to prevent duplicate fulfillment records.

### 4. OrderValidationFinalizer

- Handles Queueable execution failures and timeout scenarios.
- Controls retry attempts.
- Routes the process to the failure path after the maximum retry limit.
30.2
## Order Validation Failure Response Flow

### Overview

When the Inventory Validation API responds that inventory is not available, the `OrderValidationQueueable` does not directly send a notification.

Instead, it publishes the `Order_Validation_Failed__e` Platform Event.

A Platform Event-Triggered Flow listens for this event and handles the business response by retrieving the related Order and sending a notification to the appropriate queue/users.

### Failure Flow Architecture

Order Activated

↓

Record-Triggered Flow

↓

OrderSyncInvocable

↓

OrderValidationQueueable

↓

Inventory Validation API

↓

Inventory unavailable

↓

publishFailureEvent()

↓

Order_Validation_Failed__e

↓

Platform Event-Triggered Flow

↓

Get Related Order

↓

Send Custom Notification

## Platform Event

### Event Name

`Order Validation Failed`

### API Name

`Order_Validation_Failed__e`

### Fields

| Field | API Name | Purpose |
|---|---|---|
| Order Id | `OrderId__c` | Stores the Salesforce Order Id |
| Order Number | `OrderNumber__c` | Stores the Order Number |
| Failure Reason | `Failure_Reason__c` | Stores the reason for validation failure |
| Retry Count | `Retry_Count__c` | Stores the number of retries performed |

## Apex Event Publishing

The `OrderValidationQueueable` calls the following method when inventory validation fails:

```apex
publishFailureEvent(
    ord,
    result.message,
    retryCount
);