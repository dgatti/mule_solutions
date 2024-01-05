%dw 2.0
output application/json skipNullOn="everywhere"
---
{ graphs: (
      
      payload map (item, index) -> {
    
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
     
      "url" : (item1.attributes.url) replace '/Account/' with '/Account/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'Account_' ++ index1,
      "body" : {
        ("SpecialtyId": "@{CareSpecialty_" ++ index ++ '.id}') if (!isEmpty(item1.Name)),
        "name": item1.Name
      }
}
  ] filter ($.body != null)) 


  ++ flatten([ item.Contacts.records  map  (item2, index2) -> {
      
      "url" : (item2.attributes.url) replace '/Account/' with '/Account/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'Account_' ++ index2,
      "body" : {
        ("SpecialtyId": "@{CareSpecialty_" ++ index ++ '.id}') if (!isEmpty(item1.Name)),
        "name": item2.Name
      }
}
  ] filter ($.body != null))
  
 
      
})}