%dw 2.0
output application/json skipNullOn="everywhere"
---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 
  
  [{
      "url" : (item.attributes.url) replace '/Product2/' with '/Product2/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'Product2_' ++ index,
      "body" : {
        "IsActive": item.IsActive,
		"Fee_Type__c": item.Fee_Type__c,
		"ProductCode": item.ProductCode,
		"Description": item.Description,
		"Geography__c": item.Geography__c,
		"Name": item.Name,
		"PayeeType__c": item.PayeeType__c,
		"Type__c": item.Type__c,
		"PNM_Last_Updated__c": now(),
        "PNM_Updated__c": "true"
      }
  }]
  
 ++ flatten([ item.Rate_Card_Line_Items__r.records  map  (item1, index1) -> {
     
      "url" : (item1.attributes.url) replace '/Rate_Card_Line_Item__c/' with '/Rate_Card_Line_Item__c/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'Rate_Card_Line_Item__c_' ++ index1,
      "body" : {
        ("Product__c": "@{Product2_" ++ index ++ '.id}') if (!isEmpty(item1.Product__c)),
        "Total_Price__c": item1.Total_Price__c
      }
}
  ] filter ($.body.Product__c != null))   
  
      
})}