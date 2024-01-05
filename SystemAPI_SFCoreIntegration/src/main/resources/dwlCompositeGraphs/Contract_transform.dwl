%dw 2.0
output application/json skipNullOn="everywhere"

fun coreRecTypeId(rtId,rtObj) = (vars.coreRT filter ($.DeveloperName == ((vars.pnmRT filter ($.Id == rtId and $.SobjectType == rtObj)).DeveloperName[0]) and $.SobjectType == rtObj)).Id[0]

fun actType (rtId) = if (['PersonAccount', 'Provider'] contains (vars.pnmRT filter ($.Id == rtId)).DeveloperName[0]) 'PersonAcct' else 'BussAcct'

---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 

  [{
      "url" : (item.attributes.url) replace '/Contract/' with '/Contract/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'Contract_' ++ index,
      "body" : {
        
        ("Account": {"External_Id__c": item.AccountId }) if (!isEmpty(item.AccountId)),
        //("AccountId": "@{Account_" ++ index ++ '.Id}') if (!isEmpty(item.AccountId)),
        
        "ContractTerm": item.ContractTerm,
        "Termination_Date__c": item.Termination_Date__c,
        "Term_Reason__c": item.Term_Reason__c,
        "Contract_Type_Version__c": item.Contract_Type_Version__c,
        "StartDate": item.StartDate,
        "OOA_VES_ID__c": item.OOA_VES_ID__c,
        "OOA_Veteran__c": item.OOA_Veteran__c,
        "Signed_Domestic_Contract__c": item.Signed_Domestic_Contract__c,
        "Signed_International_Contract__c": item.Signed_International_Contract__c,
        "SHA__c": item.SHA__c,
        "ContractNumber": item.PNM_Contract_Number__c,
        "Record_URL__c": item.PNM_Contract_URL__c,
        "Status": item.Status,
		"PNM_Last_Updated__c": now(),
        "PNM_Updated__c": "true"
        
        
      }
  }]
    
      
})}