%dw 2.0
output application/json skipNullOn="everywhere"

fun coreRecTypeId(rtId,rtObjPnm, rtObjPnmcore) = (vars.coreRT filter ($.DeveloperName == ((vars.pnmRT filter ($.Id == rtId and $.SobjectType == rtObjPnm)).DeveloperName[0]) and $.SobjectType == rtObjPnmcore)).Id[0]

---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 
  
  [{
      "url" : (item.attributes.url) replace '/Provider_Freeze__c/' with '/Freeze__c/PNM_External_Id__c/',
        "method": "PATCH",
        "referenceId": 'PF_' ++ index,
      "body": {
            ("Account__r": {"External_Id__c": item.Account__c }) if (!isEmpty(item.Account__c)),
            "End_Date__c" : item.End_Date__c,
            "Freeze_Source__c" : item.Freeze_Source__c,
            "Reason__c" : item.Reason__c,
            "Start_Date__c" : item.Start_Date__c,
            "Status__c" : item.Status__c,
            "RecordTypeId": coreRecTypeId(item.RecordTypeId, 'Provider_Freeze__c', 'Freeze__c'),
            
            "PNM_Last_Updated__c": now(),
            "PNM_Updated__c": "true" 
            }
  }]
  
 
      
})}