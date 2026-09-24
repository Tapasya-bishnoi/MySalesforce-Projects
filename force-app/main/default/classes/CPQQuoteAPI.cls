@RestResource(urlMapping='/cpq/quote/*')
global with sharing class CPQQuoteAPI {

    @HttpGet
    global static void getQuoteData() {

        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        String quoteId = req.params.get('quoteId');

        if (String.isBlank(quoteId)) {

            res.statusCode = 400;

            res.responseBody =
                Blob.valueOf(
                    '{"error":"quoteId is required"}'
                );

            return;
        }

        try {

            SBQQ__Quote__c quote = [

                SELECT
                    Id,
                    Name,
                    SBQQ__Status__c,
                    SBQQ__TotalCustomerDiscountAmount__c,
                    SBQQ__Account__r.Name

                FROM SBQQ__Quote__c

                WHERE Id = :quoteId

                LIMIT 1
            ];

            List<SBQQ__QuoteLine__c> lines = [

                SELECT
                    Id,
                    SBQQ__ProductName__c,
                    SBQQ__Quantity__c,
                    SBQQ__NetPrice__c

                FROM SBQQ__QuoteLine__c

                WHERE SBQQ__Quote__c = :quoteId
            ];

            Map<String,Object> responseMap =
                new Map<String,Object>();

            responseMap.put(
                'quoteId',
                quote.Id
            );

            responseMap.put(
                'quoteName',
                quote.Name
            );

            responseMap.put(
                'status',
                quote.SBQQ__Status__c
            );

            responseMap.put(
                'account',
                quote.SBQQ__Account__r != null
                ? quote.SBQQ__Account__r.Name
                : null
            );

            responseMap.put(
                'totalCustomerDiscountAmount',
                quote.SBQQ__TotalCustomerDiscountAmount__c
            );

            List<Map<String,Object>> lineList =
                new List<Map<String,Object>>();

            for(
                SBQQ__QuoteLine__c ql : lines
            ) {

                Map<String,Object> lineMap =
                    new Map<String,Object>();

                lineMap.put(
                    'product',
                    ql.SBQQ__ProductName__c
                );

                lineMap.put(
                    'quantity',
                    ql.SBQQ__Quantity__c
                );

                lineMap.put(
                    'netPrice',
                    ql.SBQQ__NetPrice__c
                );

                lineList.add(
                    lineMap
                );
            }

            responseMap.put(
                'quoteLines',
                lineList
            );

            res.addHeader(
                'Content-Type',
                'application/json'
            );

            res.statusCode = 200;

            res.responseBody =
                Blob.valueOf(
                    JSON.serializePretty(
                        responseMap
                    )
                );

        }
        catch(Exception e) {

            res.statusCode = 500;

            res.responseBody =
                Blob.valueOf(
                    '{"error":"' +
                    e.getMessage() +
                    '"}'
                );
        }
    }
}