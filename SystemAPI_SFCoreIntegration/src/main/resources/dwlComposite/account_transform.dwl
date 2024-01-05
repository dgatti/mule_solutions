%dw 2.0
output application/json skipNullOn="everywhere"
---

{
    "allOrNone" : true,
    "compositeRequest" : 
        (payload  map {
        "method" : "PATCH",
        "referenceId" : 'OperHrs_' ++ $$,
        "url" : "/services/data/v58.0/sobjects/OperatingHours/External_Id__c/" ++ ($.OperatingHoursId default '') ,
        "body": 
            {
                "Name": $.OperatingHours.Name
            }

    }) filter (!isEmpty($.body.Name))
    
    ++ (payload map {
        "method" : "PATCH",
        "referenceId" : 'Account_' ++ $$,
        "url" : "/services/data/v58.0/sobjects/Account/External_Id__c/" ++ $.Id,
        "body": 
            {
                //Min Required Fields
                "Name": $.Name,
                
                //Map Lookups
                ("OperatingHoursId": "@{OperHrs_" ++ $$ ++ '.id}') if (!isEmpty($.OperatingHoursId)),
                
             	//Map other Fields
             	"AccountNumber" : $.AccountNumber,
             	"AccountSource" : $.AccountSource,
             	"AnnualRevenue" : $.AnnualRevenue,
			    "Phone": $.Phone,
			    "Fax": $.Fax,
			    
			    "Website" : $.Website,
			    "Jigsaw" : $.Jigsaw,
			    "Description" : $.Description,
			    "SicDesc" : $.SicDesc,
			    "IsActive" : if ($.IsActive == 'false') false else true,
				"Sic" : $.Sic,
				
			    "TickerSymbol" : $.TickerSymbol,
			     
                
            }

    })
}