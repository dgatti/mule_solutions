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
//      "url" : (item.Account.attributes.url) replace '/Account/' with '/Account/External_Id__c/',
//      "method": "GET",
//      "referenceId": 'Account_' ++ index
//   }] else   [])

//++
  
  
  [{
      "url" : (item.attributes.url) replace '/HealthcarePractitionerFacility/' with '/HealthcarePractitionerFacility/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'HCPF_' ++ index,
      "body" : {
        
        ("Account": {"External_Id__c": item.AccountId }) if (!isEmpty(item.AccountId)),
        //("AccountId": "@{Account_" ++ index ++ '.Id}') if (!isEmpty(item.AccountId)),
        
        ("HealthcareProvider": {"External_Id__c": item.HealthcareProviderId}) if (!isEmpty(item.HealthcareProviderId)),
        ("OperatingHours": {"External_Id__c": item.OperatingHoursId}) if (!isEmpty(item.OperatingHoursId)),
        ("HealthcareFacility": {"External_Id__c": item.HealthcareFacilityId}) if (!isEmpty(item.HealthcareFacilityId)),
        
        ("Practitioner": {"External_Id__c": item.PractitionerId}) if (!isEmpty(item.PractitionerId)),
        //("PractitionerId": "@{Account_" ++ index ++ '.PersonContactId}') if (!isEmpty("@{Account_" ++ index ++ '.PersonContactId}') and !isEmpty(item.AccountId)),
		
        
        "Name": item.Name,
        "TerminationDate": item.TerminationDate,
        "HighestValidAge": item.HighestValidAge,
        "InitialStartDate": item.InitialStartDate,
        "EffectiveFrom": item.EffectiveFrom,
        "LowestValidAge": item.LowestValidAge,
        "SsaCountyCode": item.SsaCountyCode,
        "GenderRestriction": item.GenderRestriction,
        "EffectiveTo": item.EffectiveTo,
        "AvailabilityExceptions": item.AvailabilityExceptions,
        "IsPrimaryFacility": item.IsPrimaryFacility,
        "IsPrimaryCarePhysician": item.IsPrimaryCarePhysician,
        "TerminationReason": item.TerminationReason,
        "Has24x7Service": item.Has24x7Service,
        "IsActive": item.IsActive,
        "SourceSystemIdentifier": item.SourceSystemIdentifier,
        "IsDirectoryPrint": item.IsDirectoryPrint,
        "SourceSystem": item.SourceSystem,
		"PNM_Last_Updated__c": now(),
        "PNM_Updated__c": "true"       
        
      }
  }] 
      
})}