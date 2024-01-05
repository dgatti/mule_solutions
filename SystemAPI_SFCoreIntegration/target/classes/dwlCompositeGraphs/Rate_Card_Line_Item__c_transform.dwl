%dw 2.0
output application/json skipNullOn="everywhere"

//fun coreRecTypeId(rtId,rtObj) = (vars.coreRT filter ($.DeveloperName == ((vars.pnmRT filter ($.Id == rtId and $.SobjectType == rtObj)).DeveloperName[0]) and $.SobjectType == rtObj)).Id[0]


---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index as String,
  "compositeRequest": 
  
  ( if (!isEmpty(item.Account__c))   
	 [{
      "url" : (item.Account__r.attributes.url) replace '/Account/' with '/Account/External_Id__c/',
      "method": "GET",
      "referenceId": 'Account_' ++ index
   }] else   [])

++
  
  
  [{
      "url" : (item.attributes.url) replace '/Rate_Card_Line_Item__c/' with '/Rate_Card_Line_Item__c/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'RCLI_' ++ index,
      "body" : {
      
        ("Account__c": "@{Account_" ++ index ++ '.Id}') if (!isEmpty(item.Account__c)),
        ("Contract__r": {"External_Id__c": item.Contract__c}) if (!isEmpty(item.Contract__c)),
        ("Product__r": {"External_Id__c": item.Product__c }) if (!isEmpty(item.Product__c)),
        "Multiplier__c": item.Multiplier__c,
        "Total_Price__c" : (item.Total_Price__c default '') as String,
        "Product_Code__c": item.Product_Code__c,
		"PNM_Last_Updated__c": now(),
        "PNM_Updated__c": "true"
      
      }
  }]
  
  
  
 
      
})}