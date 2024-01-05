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
      
})}