%dw 2.0
output application/json skipNullOn="everywhere"

fun coreRecTypeId(rtId,rtObj) = (vars.coreRT filter ($.DeveloperName == ((vars.pnmRT filter ($.Id == rtId and $.SobjectType == rtObj)).DeveloperName[0]) and $.SobjectType == rtObj)).Id[0]

fun actType (rtId) = if (['PersonAccount', 'Provider'] contains (vars.pnmRT filter ($.Id == rtId)).DeveloperName[0]) 'PersonAcct' else 'BussAcct'

---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 
  
  ( if (!isEmpty(item.AccountId))   
	 [{
      "url" : (item.Account.attributes.url) replace '/Account/' with '/Account/External_Id__c/',
      "method": "GET",
      "referenceId": 'Account_' ++ index
   }] else   [])

++


  [{
      "url" : (item.attributes.url) replace '/Contract/' with '/Contract/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'Contract_' ++ index,
      "body" : {
        "ContractTerm": item.ContractTerm,
        "Termination_Date__c": item.Termination_Date__c,
        "Term_Reason__c": item.Term_Reason__c,
        "Contract_Type_Version__c": item.Contract_Type_Version__c,
        "StartDate": item.StartDate,
        
        ("AccountId": "@{Account_" ++ index ++ '.Id}') if (!isEmpty(item.AccountId)),
        "OOA_VES_ID__c": item.OOA_VES_ID__c,
        "OOA_Veteran__c": item.OOA_Veteran__c,
		"PNM_Last_Updated__c": now(),
        "PNM_Updated__c": "true"
        //"EndDate": item.EndDate
        
      }
  }]
  
  
  ++ flatten([ item.Rate_Card_Line_Items__r.records  map  (item1, index1) -> {
     
      "url" : (item1.attributes.url) replace '/Rate_Card_Line_Item__c/' with '/Rate_Card_Line_Item__c/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'RCLI_' ++ index1,
      "body" : {
        ("Contract__c": "@{Contract_" ++ index ++ '.id}') if (!isEmpty(item1.Total_Price__c)),
        "Total_Price__c": item1.Total_Price__c
      }
}
  ] filter ($.body != null)) 


  
  
 
      
})}