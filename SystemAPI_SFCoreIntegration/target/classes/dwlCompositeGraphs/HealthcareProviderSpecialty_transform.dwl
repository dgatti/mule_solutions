%dw 2.0
output application/json skipNullOn="everywhere"
//fun coreRecTypeId(rtId,rtObj) = (vars.coreRT filter ($.DeveloperName == ((vars.pnmRT filter ($.Id == rtId and $.SobjectType == rtObj)).DeveloperName[0]) and $.SobjectType == rtObj)).Id[0]

---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 
  
  
//  ( if (!isEmpty(item.AccountId))   
//	 [{
//     "url" : (item.Account.attributes.url) replace '/Account/' with '/Account/External_Id__c/',
//      "method": "GET",
//      "referenceId": 'Account_' ++ index
//   }] else   [])

//++


  [{
      "url" : (item.attributes.url) replace '/HealthcareProviderSpecialty/' with '/HealthcareProviderSpecialty/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'HCPS_' ++ index,
      "body" : {
        
        ("Account": {"External_Id__c": item.AccountId }) if (!isEmpty(item.AccountId)),
        //("AccountId": "@{Account_" ++ index ++ '.Id}') if (!isEmpty(item.AccountId)),
        ("Specialty": {"External_Id__c": item.SpecialtyId}) if (!isEmpty(item.SpecialtyId)),
        
        ("Practitioner": {"External_Id__c": item.PractitionerId}) if (!isEmpty(item.PractitionerId)),
        //("PractitionerId": "@{Account_" ++ index ++ '.PersonContactId}') if (!isEmpty("@{Account_" ++ index ++ '.PersonContactId}') and !isEmpty(item.AccountId)),
		
        
        "SpecialtyRole": item.SpecialtyRole,
        "SourceSystem": item.SourceSystem,
        "Name": item.Name,
        "EffectiveFrom": item.EffectiveFrom,
        "SourceSystemIdentifier": item.SourceSystemIdentifier,
        "IsActive": item.IsActive,
        "EffectiveTo": item.EffectiveTo,
        "IsPrimarySpecialty": item.IsPrimarySpecialty,
		"PNM_Last_Updated__c": now(),
        "PNM_Updated__c": "true"

      }
  }]
      
})}