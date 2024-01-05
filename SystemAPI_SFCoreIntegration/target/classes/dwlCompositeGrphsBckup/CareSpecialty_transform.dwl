%dw 2.0
output application/json skipNullOn="everywhere"
---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 
  
  [{
      "url" : (item.attributes.url) replace '/CareSpecialty/' with '/CareSpecialty/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'CareSpecialty_' ++ index,
      "body" : {
				        
				"SpecialtyType": item.SpecialtyType,
				"IsActive": item.IsActive,
				"Description": item.Description,
				//"IsDeleted": item.IsDeleted,
				"SpecialtyCode": item.SpecialtyCode,
				"Name": item.Name,
				"SpecialtyUsage": item.SpecialtyUsage,
				"EffectiveFrom": item.EffectiveFrom,
				"EffectiveTo": item.EffectiveTo,
				"PNM_Last_Updated__c": now(),
		        "PNM_Updated__c": "true"
       
      }
  }]
  
  
  ++ flatten([ item.CareProviderFacilitySpecialties.records  map  (item1, index1) -> {
       "url": (item1.attributes.url) replace '/CareProviderFacilitySpecialty/' with '/CareProviderFacilitySpecialty/External_Id__c/',
       "method": "PATCH",
       "referenceId": 'CareProviderFacilitySpecialty_' ++ index1,
       "body" : {
            "Name": item1.Name,
            "EffectiveFrom": item1.EffectiveFrom,
            ("SpecialtyId": "@{CareSpecialty_" ++ index ++ '.id}') if (!isEmpty(item1.Name))
       }
       
}
  ] filter ($.body != null)) 


  ++ flatten([ item.HealthcareProviderSpecialties.records  map  (item2, index2) -> {
       "url": (item2.attributes.url) replace '/HealthcareProviderSpecialty/' with '/HealthcareProviderSpecialty/External_Id__c/',
       "method": "PATCH",
       "referenceId": 'HealthcareProviderSpecialty_' ++ index2,
       "body" : {
            "Name": item2.Name,
            "EffectiveFrom": item2.EffectiveFrom,
            ("SpecialtyId": "@{CareSpecialty_" ++ index ++ '.id}') if (!isEmpty(item2.Name))
       }
       
}
  ] filter ($.body != null)) 
  
 
      
})}