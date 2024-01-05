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
      
})}