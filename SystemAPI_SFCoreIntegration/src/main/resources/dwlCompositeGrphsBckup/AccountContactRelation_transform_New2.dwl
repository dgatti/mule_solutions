%dw 2.0
output application/json skipNullOn="everywhere"


fun coreRecTypeId(rtId,rtObj) = (vars.coreRT filter ($.DeveloperName == ((vars.pnmRT filter ($.Id == rtId and $.SobjectType == rtObj)).DeveloperName[0]) and $.SobjectType == rtObj)).Id[0]

fun actType (rtId) = if (['PersonAccount', 'Provider'] contains (vars.pnmRT filter ($.Id == rtId)).DeveloperName[0]) 'PersonAcct' else 'BussAcct'

---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 
 
 ( if (!isEmpty(item.AccountId))   
	 [{
	      "url" : (item.Account.attributes.url) replace '/Account/' with '/Account/External_Id__c/' ,
	      "method": "PATCH",
	      "referenceId": 'Account_' ++ index,
	      "body" : {
	        ("FirstName" : item.Account.FirstName) if (actType(item.Account.RecordTypeId) == 'PersonAcct') ,
			("LastName" : item.Account.LastName) if (actType(item.Account.RecordTypeId) == 'PersonAcct'),
			("MiddleName" : item.Account.MiddleName) if (actType(item.Account.RecordTypeId) == 'PersonAcct'),
			("Name" : item.Account.Name) if (actType(item.Account.RecordTypeId) != 'PersonAcct'),
	        "ShippingCity": item.Account.ShippingCity,
	        "ShippingCountry": item.Account.ShippingCountry,
	        "ShippingPostalCode": item.Account.ShippingPostalCode,
	        "ShippingState": item.Account.ShippingState,
	        "ShippingStreet": item.Account.ShippingStreet,
	        "RecordTypeId": coreRecTypeId(item.Account.RecordTypeId, 'Account')
            }
	 }] else   [])

++ 
 
 
  ( if (!isEmpty(item.ContactId))   
	 [{
	      "url" : (item.Contact.attributes.url) replace '/Contact/' with '/Contact/External_Id__c/' ,
	      "method": "PATCH",
	      "referenceId": 'Contact_' ++ index,
	      "body" : {
	        "FirstName" : item.Contact.FirstName,
		    "LastName" : item.Contact.LastName,
		    // ("AccountId": "@{Account_" ++ index ++ '.id}') if (!isEmpty(item.AccountId)),
            "RecordTypeId" : coreRecTypeId(item.Contact.RecordTypeId, 'Contact')
            }
	 }] else   [])
++
  
  
 [{
    "method": "GET",
    "url": ("/services/data/v58.0/query/?q=SELECT  Id from AccountContactRelation  where AccountId = '") ++ "@{Account_" ++ index ++ '.id}' ++ "' and ContactId = '" ++ "@{Contact_" ++ index ++ '.id}' ++ "'" ,
    "referenceId": 'CoreACR_' ++ index
 }]
 
++
  
  
  [{
      "url" : (item.attributes.url) replace item.Id with "@{CoreACR_" ++ index ++ '.id}' ,
      "method": "PATCH",
      "referenceId": 'ACR_' ++ index,
      "body" : {
        ("AccountId": "@{Account_" ++ index ++ '.id}') if (!isEmpty(item.AccountId)),
        ("ContactId": "@{Contact_" ++ index ++ '.id}') if (!isEmpty(item.ContactId)),
        "External_Id__c": item.Id,
		"IsActive" : item.IsActive,
		"EndDate" : item.EndDate,
		"HealthCloudGA_Primary__c" : item.HealthCloudGA_Primary__c,
		"HealthCloudGA_Primary_Group__c" : item.HealthCloudGA_Primary_Group__c,
		"Roles" : item.Roles,
		"StartDate" : item.StartDate,
		"PNM_Last_Updated__c": now(),
        "PNM_Updated__c": "true"		
      }
  }]  
      
})}