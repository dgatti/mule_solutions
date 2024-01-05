%dw 2.0
output application/json skipNullOn="everywhere"
---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 

//( if (!isEmpty(item.AccountId))   
//	 [{
//     "url" : (item.Account.attributes.url) replace '/Account/' with '/Account/External_Id__c/',
//      "method": "GET",
//      "referenceId": 'Account_' ++ index
//   }] else   [])

//++
  
  
  [{
      "url" : (item.attributes.url) replace '/BusinessLicense/' with '/BusinessLicense/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'BusinessLicense_' ++ index,
      "body" : {
				        
				"JurisdictionState": item.JurisdictionState,
				"JurisdictionCountry": item.JurisdictionCountry,
				"Name": item.Name,
				"LicenseNumber": item.LicenseNumber,
				
				("Contact": {"External_Id__c": item.ContactId }) if (!isEmpty(item.ContactId)),
				//("ContactId": "@{Account_" ++ index ++ '.PersonContactId}') if (!isEmpty("@{Account_" ++ index ++ '.PersonContactId}') and !isEmpty(item.AccountId) ),
				
				("Account": {"External_Id__c": item.AccountId }) if (!isEmpty(item.AccountId)),
				"Status": item.Status,
				"IssueDate": item.IssueDate,
				"JurisdictionType": item.JurisdictionType,
				"JurisdictionOther": item.JurisdictionOther,
				"License_Expiration_Date__c" : item.License_Expiration_Date__c,
				
				//"PNM_Last_Updated__c": now(),
		        //"PNM_Updated__c": "true"
       
      }
  }]
      
})}