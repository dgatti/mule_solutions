%dw 2.0
output application/json skipNullOn="everywhere"
---

{
    "allOrNone" : true,
    "compositeRequest" : 
        (payload filter ($.OperatingHoursId != null) map {
        "method" : "PATCH",
        "referenceId" : 'OperHrs_' ++ $$,
        "url" : "/services/data/v58.0/sobjects/OperatingHours/External_Id__c/" ++ $.OperatingHoursId ,
        "body": 
            {
                "Name": $.OperatingHours.Name
            }

    }) 
    
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
			    "Phone": $.Phone,
			    "Fax": $.Fax,
			    "AccountNumber" : $.AccountNumber,
			    "Website" : $.Website,
			    "Jigsaw" : $.Jigsaw,
			    "Description" : $.Description,
			    "SicDesc" : $.SicDesc,
			    "IsActive" : if ($.IsActive == 'false') false else true,
				"Sic" : $.Sic,
				"AnnualRevenue" : $.AnnualRevenue,
			    "TickerSymbol" : $.TickerSymbol 
                
            }

    })
}