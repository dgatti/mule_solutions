%dw 2.0
output application/json skipNullOn="everywhere"
---
{ graphs: (
      
      payload.compositeResponse[0].body.records map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 
  
  [{
      "url" : (item.attributes.url) replace '/Account/' with '/Account/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'Account_' ++ index,
      "body" : {
        "name": item.Name
      }
  }]
  
  
  ++ flatten([ item.ChildAccounts.records  map  (item1, index1) -> {
      "PAct": index,
      "Act": index1
}
  ] filter ($.Act != null)) 


  ++ flatten([ item.Contacts.records  map  (item2, index2) -> {
      "PAct": index,
      "CON": index2
}
  ] filter ($.CON != null))
  
 
      
})}