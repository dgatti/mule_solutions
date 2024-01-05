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
  
  
  [{
      "url" : (item.attributes.url) replace '/Contact/' with '/Contact/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'Contact_' ++ index,
      "body" : {
        ("AccountId": "@{Account_" ++ index ++ '.id}') if (!isEmpty(item.AccountId)),
		"FirstName" : item.FirstName,
		"LastName" : item.LastName,
		"Title" : item.Title,
		"Email" : item.Email,
		"Phone" : item.Phone,
		"Mobile" : item.Mobile,
		"Is_Provider_Group_Admin__c" : item.isProviderGroupAdmin__c,
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
  
 ++ flatten([ item.HealthcarePractitionerFacilities.records  map  (item1, index1) -> {
     
      "url" : (item1.attributes.url) replace '/HealthcarePractitionerFacility/' with '/HealthcarePractitionerFacility/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'HCPF_' ++ index1,
      "body" : {
        ("PractitionerId": "@{Contact_" ++ index ++ '.id}') if (!isEmpty(item1.PractitionerId)),
        "Name": item1.Name,
        "EffectiveFrom": item1.EffectiveFrom
      }
}
  ] filter ($.body != null)) 
  
  
++ flatten([ item.HealthcareProviders.records  map  (item2, index2) -> {
     
      "url" : (item2.attributes.url) replace '/HealthcareProvider/' with '/HealthcareProvider/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'HealthcareProviderPId_' ++ index2,
      "body" : {
        ("PractitionerId": "@{Contact_" ++ index ++ '.id}') if (!isEmpty(item2.PractitionerId)),
        "Name": item2.Name,
        "ProviderType": item2.ProviderType
      }
}
  ] filter ($.body != null)) 
  
   
++ flatten([ item.HealthcareProvidersReferredBy.records  map  (item3, index3) -> {
     
      "url" : (item3.attributes.url) replace '/HealthcareProvider/' with '/HealthcareProvider/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'HealthcareProviderRBy_' ++ index3,
      "body" : {
        ("ReferredByContactId": "@{Contact_" ++ index ++ '.id}') if (!isEmpty(item3.PractitionerId)),
        "Name": item3.Name,
        "ProviderType": item3.ProviderType
      }
}
  ] filter ($.body != null)) 
  
   
++ flatten([ item.HealthcareProviderSpecialties.records  map  (item4, index4) -> {
     
      "url" : (item4.attributes.url) replace '/HealthcareProviderSpecialty/' with '/HealthcareProviderSpecialty/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'HCPS_' ++ index4,
      "body" : {
        ("PractitionerId": "@{Contact_" ++ index ++ '.id}') if (!isEmpty(item4.PractitionerId)),
        "Name": item4.Name,
        "EffectiveFrom": item4.EffectiveFrom
      }
}
  ] filter ($.body != null))   
  
  
      
})}