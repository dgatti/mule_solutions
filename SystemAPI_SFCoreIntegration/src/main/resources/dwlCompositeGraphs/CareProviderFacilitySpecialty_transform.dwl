%dw 2.0
output application/json skipNullOn="everywhere"

fun coreRecTypeId(rtId,rtObj) = (vars.coreRT filter ($.DeveloperName == ((vars.pnmRT filter ($.Id == rtId and $.SobjectType == rtObj)).DeveloperName[0]) and $.SobjectType == rtObj)).Id[0]

---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index as String,
  "compositeRequest": 
  
  [{
      "url" : (item.attributes.url) replace '/CareProviderFacilitySpecialty/' with '/CareProviderFacilitySpecialty/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'CPFS_' ++ index,
      "body" : {
        
        ("Account": {"External_Id__c": item.AccountId }) if (!isEmpty(item.AccountId)),
        //("AccountId": "@{Account_" ++ index ++ '.Id}') if (!isEmpty(item.AccountId)),
        // "PractitionerFacilityId" : item.PractitionerFacilityId,
        ("PractitionerFacility": {"External_Id__c": item.PractitionerFacilityId}) if (!isEmpty(item.PractitionerFacilityId)),
        ("Specialty": {"External_Id__c": item.SpecialtyId}) if (!isEmpty(item.SpecialtyId)),
        
        "SpecialtyRole": item.SpecialtyRole,
        "Name" : item.Name,
        "SourceSystem" : item.SourceSystem,
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