%dw 2.0
output application/json skipNullOn="everywhere"
---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 
  
  [{
      "url" : (item.attributes.url) replace '/Regional_Office__c/' with '/Regional_Office__c/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'Regional_Office__c_' ++ index,
      "body" : {
        "Name": item.Name,
        "Station_Number__c": item.Station_Number__c
        
      }
  }]
  
  
  ++ flatten([ item.Postal_Codes__r.records  map  (item1, index1) -> {
     
      "url" : (item1.attributes.url) replace '/Postal_Code__c/' with '/Postal_Code__c/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'Postal_Code__c_' ++ index1,
      "body" : {
        ("Regional_Office__c": "@{Regional_Office__c_" ++ index ++ '.id}') if (!isEmpty(item1.Name)),
        "name": item1.Name
      }
}
  ] filter ($.body != null)) 
  
 
      
})}