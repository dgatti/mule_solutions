%dw 2.0
output application/json skipNullOn="everywhere"


---
 (
      
      payload map (item, index) -> {

  "compositeRequest": 
 
 
 [{
    "method": "GET",
    "url": ("/services/data/v53.0/query/?q=SELECT  Id from Account  where External_Id__c = '") ++ item.AccountId ++ "'" ,
    "referenceId": 'Account_' ++ index
 }]
 
++

[{
    "method": "GET",
    "url": ("/services/data/v53.0/query/?q=SELECT  Id from Contact  where External_Id__c = '") ++ item.ContactId ++ "'" ,
    "referenceId": 'Contact_' ++ index
 }]
 
++

[{
    "method": "GET",
    "url": ("/services/data/v53.0/query/?q=SELECT  Id from AccountContactRelation  where AccountId = '") ++ "@{Account_" ++ index ++ '.records[0].Id}' ++ "' and ContactId = '" ++ "@{Contact_" ++ index ++ '.records[0].Id}' ++ "'" ,
    "referenceId": 'ExistingACR_' ++ index
 }]
 
++

  
  [{
      "url": "/services/data/v53.0/sobjects/AccountContactRelation/@{ExistingACR_" ++ index ++ ".records[0].Id}",
      "method": "PATCH",
      "referenceId": 'ACR_' ++ index,
      "body" : {
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
  
    
  
      
})[0]