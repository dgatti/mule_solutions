%dw 2.0
output application/json skipNullOn="everywhere"

fun yNTransform (val) = if(val == 'Yes') 'true' else if (val == 'No') 'false' else null
fun coreRecTypeId(rtId,rtObj) = (vars.coreRT filter ($.DeveloperName == ((vars.pnmRT filter ($.Id == rtId and $.SobjectType == rtObj)).DeveloperName[0]) and $.SobjectType == rtObj)).Id[0]

fun actType (rtId) = if (['PersonAccount', 'Provider'] contains (vars.pnmRT filter ($.Id == rtId)).DeveloperName[0]) 'PersonAcct' else 'BussAcct'

---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 

( if (!isEmpty(item.AccountId))   
	 [{
      "url" : (item.Account.attributes.url) replace '/Account/' with '/Account/External_Id__c/',
      "method": "GET",
      "referenceId": 'Account_' ++ index
   }] else   [])

++
  [{
      "url" : (item.attributes.url) replace '/HealthcareFacility/' with '/HealthcareFacility/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'HCF_' ++ index,
      "body" : {
        "Name" : item.Name,
        "LocationType" : item.LocationType,
        "FacilityTypeId" : item.FacilityTypeId,
        "IsAlwaysOpen" : item.IsAlwaysOpen,
        
        "SourceSystem" : item.SourceSystem,
        
        ("AccountId": "@{Account_" ++ index ++ '.Id}') if (!isEmpty(item.AccountId)),
        "AvailabilityExceptions" : item.AvailabilityExceptions,
        "SourceSystemModified" : item.SourceSystemModified,
        "LicensedBedCount" : item.LicensedBedCount,
        "SourceSystemIdentifier" : item.SourceSystemIdentifier,
        
        "Other_language_spoken_other_than_English__c" : item.Other_Language_Spoken__c,
        "OSHA_ADA_Compliant__c" : yNTransform(item.OSHA_ADA_Compliant__c),
        "Special_Instructions__c" : item.Special_Instructions__c,
        "WiFi_Network_Name__c" : item.WiFi_Network_Name__c,
        "WiFi_Password__c" : item.Wi_Fi_Password__c,
        "Accessible_Parking__c" : yNTransform(item.Accessible_Parking__c),
        "Permit_Service_Animals__c" : yNTransform(item.Permit_Service_Animals__c),
        "Wheelchair_Ramps__c" : yNTransform(item.Wheelchair_Ramps__c),
        "Elevators__c" : yNTransform(item.Elevators__c),
        "Additional_Resources__c" : yNTransform(item.Additional_Resources__c),
        "How_PFTs_Interpreted__c" : item.How_PFTs_Interpreted__c,
        "Appointment_Types__c" : item.Appointment_Types__c,
        
        "Diagnostic_Testing_at_Location__c" : item.Diagnostic_Testing_at_Location__c,
        "Explain_Facility_Not_Handicap_Accessible__c" : item.Explain_Facility_Not_Handicap_Accessible__c,
      
        ("Operating_Hours__r": {"External_Id__c": item.Operating_Hours__c }) if (!isEmpty(item.Operating_Hours__c)),
        "Results_Portal_Available__c" : item.Results_Portal_Available__c,
        "Results_Portal_Info__c" : item.Results_Portal_Info__c,
        "Special_Instructions_VES_Staff__c" : item.Special_Instructions_VES_Staff__c,
        "Special_Instructions_Veterans__c" : item.Special_Instructions_Veterans__c,
        
		"PNM_Last_Updated__c": now(),
        "PNM_Updated__c": "true"
      }
  }]
  

++ flatten([ item.HealthcareFacilityParent.records  map  (item2, index2) -> {
     
      "url" : (item2.attributes.url) replace '/HealthcareFacility/' with '/HealthcareFacility/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'HealthcareFacilityParent_' ++ index2,
      "body" : {
        
        "Name" : item2.Name,
        "LocationType" : item2.LocationType,
        "FacilityTypeId" : item2.FacilityTypeId,
        "IsAlwaysOpen" : item2.IsAlwaysOpen,
        ("ParentHealthcareFacilityId": "@{HCF_" ++ index ++ '.id}') if (!isEmpty(item2.Name)),
        "SourceSystem" : item2.SourceSystem,
        
        //("AccountId": "@{Account_" ++ index ++ '.id}') if (!isEmpty(item.AccountId)),
        "AvailabilityExceptions" : item2.AvailabilityExceptions,
        "SourceSystemModified" : item2.SourceSystemModified,
        "LicensedBedCount" : item2.LicensedBedCount,
        "SourceSystemIdentifier" : item2.SourceSystemIdentifier,
        
        "Other_language_spoken_other_than_English__c" : item2.Other_Language_Spoken__c,
        "OSHA_ADA_Compliant__c" : yNTransform(item2.OSHA_ADA_Compliant__c),
        "Special_Instructions__c" : item2.Special_Instructions__c,
        "WiFi_Network_Name__c" : item2.WiFi_Network_Name__c,
        "WiFi_Password__c" : item2.Wi_Fi_Password__c,
        "Accessible_Parking__c" : yNTransform(item2.Accessible_Parking__c),
        "Permit_Service_Animals__c" : yNTransform(item2.Permit_Service_Animals__c),
        "Wheelchair_Ramps__c" : yNTransform(item2.Wheelchair_Ramps__c),
        "Elevators__c" : yNTransform(item2.Elevators__c),
        "Additional_Resources__c" : yNTransform(item2.Additional_Resources__c),
        "How_PFTs_Interpreted__c" : item2.How_PFTs_Interpreted__c,
        "Appointment_Types__c" : item2.Appointment_Types__c
      }
}
  ] filter ($.body != null)) 
  
   
   
  
  
      
})}