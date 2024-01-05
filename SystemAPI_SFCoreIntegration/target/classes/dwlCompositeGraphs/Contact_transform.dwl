%dw 2.0
output application/json skipNullOn="everywhere"


fun coreRecTypeId(rtId,rtObj) = (vars.coreRT filter ($.DeveloperName == ((vars.pnmRT filter ($.Id == rtId and $.SobjectType == rtObj)).DeveloperName[0]) and $.SobjectType == rtObj)).Id[0]

fun actType (rtId) = if (['PersonAccount', 'Provider'] contains (vars.pnmRT filter ($.Id == rtId)).DeveloperName[0]) 'PersonAcct' else 'BussAcct'

---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 
  
  ( if (!isEmpty(item.ReportsToId))   
	 [{
	      "url" : (item.ReportsTo.attributes.url) replace '/Contact/' with '/Contact/External_Id__c/' ,
	      "method": "PATCH",
	      "referenceId": 'ReportsToContact_' ++ index,
	      "body" : {
	        "FirstName" : item.ReportsTo.FirstName,
		    "LastName" : item.ReportsTo.LastName,
            "RecordTypeId" : coreRecTypeId(item.ReportsTo.RecordTypeId, 'Contact')
            }
	 }] else   [])
++
  
  
  [{
      "url" : (item.attributes.url) replace '/Contact/' with '/Contact/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'Contact_' ++ index,
      "body" : {
        
         ("Account": {"External_Id__c": item.AccountId }) if (!isEmpty(item.AccountId)),
        //("AccountId": "@{Account_" ++ index ++ '.Id}') if (!isEmpty(item.AccountId)),
		"FirstName" : item.FirstName,
		"LastName" : item.LastName,
		"Title" : item.Title,
		"Email" : item.Email,
		"Phone" : item.Phone,
		"Mobile" : item.Mobile,
//6710		"isProviderGroupAdmin__c" : item.isProviderGroupAdmin__c,
		("Reportsto": "@{ReportsToContact_" ++ index ++ '.id}') if (!isEmpty(item.ReportsToId)),
		"Department" : item.Department,
		"Fax" : item.Fax,
		"Birthdate" : item.Birthdate,
		"RecordTypeId" : coreRecTypeId(item.RecordTypeId, 'Contact'),
		"Role__c": item.Role__c,
		"PNM_Last_Updated__c": now(),
	    "PNM_Updated__c": "true"
      }
  }]
        
})}