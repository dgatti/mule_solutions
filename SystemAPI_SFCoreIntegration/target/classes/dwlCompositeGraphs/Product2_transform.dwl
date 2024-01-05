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
		"Family": item.Family,
		"PNM_Last_Updated__c": now(),
        "PNM_Updated__c": "true",
        "CPT_Code__c": item.CPT_Code__c,
        "Product_Differentiator__c": item.Product_Differentiator__c
        
      }
  }]
      
})}