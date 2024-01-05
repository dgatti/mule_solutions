%dw 2.0
output application/json skipNullOn="everywhere"
---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 
  
  [{
      "url" : (item.attributes.url) replace '/OperatingHours/' with '/OperatingHours/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'OperatingHours_' ++ index,
      "body" : {
        "Description": item.Description,
        "Name": item.Name,
        "TimeZone": item.TimeZone,
		"PNM_Last_Updated__c": now(),
        "PNM_Updated__c": "true"
      }
  }]
  
 ++ flatten([ item.HealthcarePractitionerFacilityOperatingHours.records  map  (item1, index1) -> {
     
      "url" : (item1.attributes.url) replace '/HealthcarePractitionerFacility/' with '/HealthcarePractitionerFacility/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'HealthcarePractitionerFacility_' ++ index1,
      "body" : {
        ("OperatingHoursId": "@{OperatingHours_" ++ index ++ '.id}') if (!isEmpty(item1.Name)),
        "Name": item1.Name,
        "EffectiveFrom": item1.EffectiveFrom
      }
}
  ] filter ($.body != null)) 
  
  
++ flatten([ item.TimeSlots.records  map  (item2, index2) -> {
     
      "url" : (item2.attributes.url) replace '/TimeSlot/' with '/TimeSlot/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'TimeSlot_' ++ index2,
      "body" : {
        ("OperatingHoursId": "@{OperatingHours_" ++ index ++ '.id}') if (!isEmpty(item2.StartTime)),
        "DayOfWeek": item2.DayOfWeek,
        "StartTime": item2.StartTime,
        "EndTime": item2.EndTime
      }
}
  ] filter ($.body != null)) 
  
   
   
  
  
      
})}