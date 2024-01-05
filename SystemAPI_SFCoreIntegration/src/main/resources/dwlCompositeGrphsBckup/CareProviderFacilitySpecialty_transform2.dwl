%dw 2.0
output application/json skipNullOn="everywhere"

fun coreRecTypeId(rtId,rtObj) = (vars.coreRT filter ($.DeveloperName == ((vars.pnmRT filter ($.Id == rtId and $.SobjectType == rtObj)).DeveloperName[0]) and $.SobjectType == rtObj)).Id[0]

---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index as String,
  "compositeRequest": 
  
  ( if (!isEmpty(item.AccountId))   
	 [{
	      "url" : (item.Account.attributes.url) replace '/Account/' with '/Account/External_Id__c/' ,
	      "method": "PATCH",
	      "referenceId": 'Account_' ++ index,
	      "body" : {
	        "Name" : item.Account.Name,
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
      "url" : (item.attributes.url) replace '/CareProviderFacilitySpecialty/' with '/CareProviderFacilitySpecialty/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'CPFS_' ++ index,
      "body" : {
        ("AccountId": "@{Account_" ++ index ++ '.id}') if (!isEmpty(item.AccountId)),
        "SpecialtyRole": item.SpecialtyRole,
        "Name" : item.Name,
        //"External_Id__c" : item.Id,
        "SourceSystem" : item.SourceSystem,
        "PractitionerFacilityId" : item.PractitionerFacilityId,
        "EffectiveTo" : item.EffectiveTo,
        "IsPrimarySpecialty" : item.IsPrimarySpecialty,
        "IsActive" : item.IsActive,
        "SourceSystemIdentifier" : item.SourceSystemIdentifier,
        "EffectiveFrom" : item.EffectiveFrom,
		"PNM_Last_Updated__c": now(),
        "PNM_Updated__c": "true"
      }
  }]
  
  
  
 
      
})}