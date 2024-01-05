%dw 2.0
output application/json skipNullOn="everywhere"
---
{
    "allOrNone" : true,
    "compositeRequest" : payload map {
        "method" : "PATCH",
        "referenceId" : $.Id,
        "url" : "/services/data/v58.0/sobjects/OperatingHours/External_Id__c/" ++ $.Id,
        "body": 
            {
                "Name": $.Name,
                "Description": $.Description,
                "TimeZone" : $.TimeZone
            }

    }
}