%dw 2.0
output application/json skipNullOn="everywhere"
---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 
  
  [{
      "url" : (item.attributes.url) replace '/TimeSlot/' with '/TimeSlot/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'TimeSlot_' ++ index,
      "body" : {
        //("OperatingHoursId": "@{OperatingHours_" ++ index ++ '.id}') if (!isEmpty(item.OperatingHoursId)),
        //("OperatingHoursId": "@{OperatingHours_" ++ index ++ '.id}') if (!isEmpty(item.OperatingHoursId)),
        ("OperatingHours": {"External_Id__c": item.OperatingHoursId}) if (!isEmpty(item.OperatingHoursId)),
        "DayOfWeek": item.DayOfWeek,
        "EndTime": item.EndTime,
        "MaxAppointments": item.MaxAppointments,
        "StartTime": item.StartTime,
        "Type": item.Type,
		"PNM_Last_Updated__c": now(),
        "PNM_Updated__c": "true"
       
        
      }
  }]
  
      
})}