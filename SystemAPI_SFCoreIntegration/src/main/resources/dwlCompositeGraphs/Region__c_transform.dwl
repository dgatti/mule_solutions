%dw 2.0
output application/json skipNullOn="everywhere"
---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 
  
  [{
      "url" : (item.attributes.url) replace '/Region__c/' with '/Region__c/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'Region__c_' ++ index,
      "body" : {
        "Name": item.Name
        
      }
  }]
  
  
  ++ flatten([ item.Regional_Offices__r.records  map  (item1, index1) -> {
     
      "url" : (item1.attributes.url) replace '/Regional_Office__c/' with '/Regional_Office__c/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'Regional_Office__c_' ++ index1,
      "body" : {
        ("Region__c": "@{Region__c_" ++ index ++ '.id}') if (!isEmpty(item1.Name)),
        "name": item1.Name,
         "Station_Number__c": item1.Station_Number__c
      }
}
  ] filter ($.body != null)) 
  
 
      
})}