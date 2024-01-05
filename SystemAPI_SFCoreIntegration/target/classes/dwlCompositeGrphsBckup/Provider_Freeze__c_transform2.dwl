%dw 2.0
output application/json skipNullOn="everywhere"

fun yNTransform (val) = if(val == 'Yes') 'true' else if (val == 'No') 'false' else null
fun coreRecTypeId(rtId,rtObjPnm, rtObjPnmcore) = (vars.coreRT filter ($.DeveloperName == ((vars.pnmRT filter ($.Id == rtId and $.SobjectType == rtObjPnm)).DeveloperName[0]) and $.SobjectType == rtObjPnmcore)).Id[0]

fun actType (rtId) = if (['PersonAccount', 'Provider'] contains (vars.pnmRT filter ($.Id == rtId)).DeveloperName[0]) 'PersonAcct' else 'BussAcct'


fun actLoad(actId) = (payload map (item, index) -> {
    AccountId: item.Account__c,
    fullPayload: item
 } ) filter ($.AccountId == actId)

---
{ graphs:(

((payload map (item, index) -> {
    AccountId: item.Account__c,
    fullPayload: item
 })  distinctBy $.AccountId) map (item, index) -> {
    "graphId": index,
    "compositeRequest": 

    ( if (!isEmpty(item.AccountId))   
      [{
      "url" : (item.fullPayload.Account__r.attributes.url) replace '/Account/' with '/Account/External_Id__c/',
      "method": "PATCH",
      "referenceId": 'Account_' ++ index,
      "body" : {
        ("FirstName" : item.fullPayload.Account__r.FirstName) if (actType(item.fullPayload.Account__r.RecordTypeId) == 'PersonAcct') ,
		("LastName" : item.fullPayload.Account__r.LastName) if (actType(item.fullPayload.Account__r.RecordTypeId) == 'PersonAcct'),
		("MiddleName" : item.fullPayload.Account__r.MiddleName) if (actType(item.fullPayload.Account__r.RecordTypeId) == 'PersonAcct'),
		("Name" : item.fullPayload.Account__r.Name) if (actType(item.fullPayload.Account__r.RecordTypeId) != 'PersonAcct'),
        "ShippingCity": item.fullPayload.Account__r.ShippingCity,
        "ShippingCountry": item.fullPayload.Account__r.ShippingCountry,
        "ShippingPostalCode": item.fullPayload.Account__r.ShippingPostalCode,
        "ShippingState": item.fullPayload.Account__r.ShippingState,
        "ShippingStreet": item.fullPayload.Account__r.ShippingStreet,
	    "RecordTypeId": coreRecTypeId(item.fullPayload.Account__r.RecordTypeId, 'Account', 'Account')
      }
   }] else [])

      ++

	 (actLoad(item.AccountId).fullPayload map (pitem, pindex) -> {
        "url" : (pitem.attributes.url) replace '/Provider_Freeze__c/' with '/Freeze__c/PNM_External_Id__c/',
        "method": "PATCH",
        "referenceId": 'PF_' ++ pindex,
        "body": {
            ("Account__c": "@{Account_" ++ index ++ '.id}') if (!isEmpty(item.AccountId)),
            "End_Date__c" : pitem.End_Date__c,
            "Freeze_Source__c" : pitem.Freeze_Source__c,
            "Reason__c" : pitem.Reason__c,
            "Start_Date__c" : pitem.Start_Date__c,
            "Status__c" : pitem.Status__c,
            "RecordTypeId": coreRecTypeId(pitem.RecordTypeId, 'Provider_Freeze__c', 'Freeze__c'),
            
            "PNM_Last_Updated__c": now(),
            "PNM_Updated__c": "true" 
            }
        })   
 })}