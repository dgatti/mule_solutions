%dw 2.0
output application/json skipNullOn="everywhere"
---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 
  
  [{
      "url" : (item.attributes.url) replace '/Postal_Code__c/' with '/Postal_Code__c/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'Postal_Code__c_' ++ index,
      "body" : {
        "name": item.Name
      }
  }]
  
 
      
})}