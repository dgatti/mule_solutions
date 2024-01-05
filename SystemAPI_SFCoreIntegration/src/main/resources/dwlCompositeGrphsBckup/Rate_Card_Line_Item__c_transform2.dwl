%dw 2.0
output application/json skipNullOn="everywhere"

fun coreRecTypeId(rtId,rtObj) = (vars.coreRT filter ($.DeveloperName == ((vars.pnmRT filter ($.Id == rtId and $.SobjectType == rtObj)).DeveloperName[0]) and $.SobjectType == rtObj)).Id[0]


---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index as String,
  "compositeRequest": 
  
  ( if (!isEmpty(item.Account__c))   
	 [{
	      "url" : (item.Account__r.attributes.url) replace '/Account/' with '/Account/External_Id__c/' ,
	      "method": "PATCH",
	      "referenceId": 'Account_' ++ item.Account__c,
	      "body" : {
	        "Name" : item.Account__r.Name,
	        "ShippingCity": item.Account__r.ShippingCity,
	        "ShippingCountry": item.Account__r.ShippingCountry,
	        "ShippingPostalCode": item.Account__r.ShippingPostalCode,
	        "ShippingState": item.Account__r.ShippingState,
	        "ShippingStreet": item.Account__r.ShippingStreet,
	        "RecordTypeId": coreRecTypeId(item.Account__r.RecordTypeId,'Account')
            }
	 }] else   [])
	 
++
  
  [{
      "url" : (item.attributes.url) replace '/Rate_Card_Line_Item__c/' with '/Rate_Card_Line_Item__c/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'RCLI_' ++ index,
      "body" : {
        //("Account__c": "@{Account_" ++ item.Account__c ++ '.id}') if (!isEmpty(item.Account__c)),
        "Multiplier__c": item.Multiplier__c,
        "Total_Price__c" : (item.Total_Price__c default '') as String
      
      }
  }]
  
  
  
 
      
})}