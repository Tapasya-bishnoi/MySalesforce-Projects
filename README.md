
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

1.3
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

### 5.4

## **TESTING AND TROUBLESHOOTING**

Validation

```text
Tested the end-to-end Platform Event flow from Apex event publishing to Flow execution.
Verified the event field mapping between Apex and the subscriber Flow.
Checked the failure-handling scenarios and notification process.
Worked on troubleshooting and refining the event flow to ensure reliable processing.


 ### 6.5
 ## **AGENTFORCE**
```Started learning Salesforce Agentforce and exploring its fundamentals, including Agentforce concepts, agent setup, topics, actions, and how AI agents can automate business processes within Salesforce.


## 12.6

```Created  a Order Status Agent, which fetches an Order’s status using its Order Number and uses deterministic conditions to control action execution.
 Explored Agentforce subagent configuration, variables, action inputs/outputs, and conditional logic.
 Currently working on the Account Status Agent to fetch Account records based on the custom Status picklist value (Active/Inactive).
 Exploring how to configure Flow actions, subagent instructions, and deterministic conditions to make both agents work reliably.

### 12.7

# Agentforce Service Agent – Human Escalation

## Overview

This project focuses on configuring a Salesforce Agentforce Service Agent to handle customer interactions and transfer conversations to a human support agent when required.

## Features

* **Agentforce Service Agent:** Configured a Service Agent to interact with users through a messaging channel.
* **Subagent Configuration:** Explored subagents and their instructions to control agent behavior.
* **Messaging Connection:** Configured messaging settings and adaptive response formats.
* **Human Escalation:** Configured an Escalation Flow to support transferring conversations from the AI agent to a human support agent.
* **Omni-Channel Integration:** Explored how Omni-Channel Flow can route escalated conversations to the appropriate support queue.
* **Testing and Troubleshooting:** Tested escalation requests and investigated issues related to the agent's ability to initiate human handoff.

## Salesforce Components

* Agentforce Service Agent
* Agentforce Subagents
* Messaging Connection
* Omni-Channel Flow
* Queue and Routing Configuration
* Messaging Session

## Escalation Process

1. A customer starts a conversation with the Agentforce Service Agent.
2. The agent handles the customer's request.
3. When human assistance is required, the agent should initiate the escalation process.
4. The configured Omni-Channel Flow routes the conversation to the appropriate support queue.
5. A human support agent receives the conversation, provided the routing configuration and agent availability are set up correctly.

## Current Status

* Service Agent configuration and messaging settings reviewed.
* Escalation Flow selected in the messaging connection.
* Subagent configuration and human handoff behavior investigated.
* Further testing and troubleshooting are required to ensure that escalation requests successfully transfer conversations to a human agent.

## Learning Outcomes

* Understanding Agentforce Service Agent configuration.
* Working with subagents and agent instructions.
* Understanding messaging connections and escalation flows.
* Learning how Omni-Channel supports human handoff.
* Troubleshooting Agentforce runtime and routing issues.

## Technologies Used

* Salesforce Agentforce
* Salesforce Flow
* Omni-Channel
* Messaging
* Salesforce Service Cloud


14.8
## Today I completed the escalation task by troubleshooting . In this Task i created a agent which escalate the chat to the omni-channel on service console whenever chat escalates or issue is complex.
## Also completed case creation task in which the agent match the email given by user to existing contact and create a case with given description by user problem.
## Practice the Security levels of AI agent by doing Dynamic grounding example and data masking and learned about its type field , pattern based.
## I will continue my  further topics like prompt template and audit trails.

