%dw 2.0
output application/json skipNullOn="everywhere"


---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 
  
  [{
      "url" : (item.attributes.url) replace '/Oracle_Fusion_Supplier_Ref__c/' with '/Oracle_Fusion_Supplier_Ref__c/External_Id__c/',
        "method": "PATCH",
        "referenceId": 'OFSR_' ++ index,
      "body": {
            ("Account__r": {"External_Id__c": item.Account__c }) if (!isEmpty(item.Account__c)),
            "Supplier_ID__c" : item.Supplier_ID__c,
            "Party_ID__c" : item.Party_ID__c,
            "Supplier_Number__c" : item.Supplier_Number__c,
            "PNM_Last_Updated__c": now(),
            "PNM_Updated__c": "true" 
            }
  }]
  
 
      
})}