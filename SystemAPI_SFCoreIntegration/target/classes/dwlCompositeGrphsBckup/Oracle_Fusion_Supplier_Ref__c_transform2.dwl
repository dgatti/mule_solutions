%dw 2.0
output application/json skipNullOn="everywhere"

fun yNTransform (val) = if(val == 'Yes') 'true' else if (val == 'No') 'false' else null
fun coreRecTypeId(rtId,rtObj) = (vars.coreRT filter ($.DeveloperName == ((vars.pnmRT filter ($.Id == rtId and $.SobjectType == rtObj)).DeveloperName[0]) and $.SobjectType == rtObj)).Id[0]

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
	    "RecordTypeId": coreRecTypeId(item.fullPayload.Account__r.RecordTypeId, 'Account')
      }
   }] else [])

      ++

	 (actLoad(item.AccountId).fullPayload map (pitem, pindex) -> {
        "url" : (pitem.attributes.url) replace '/Oracle_Fusion_Supplier_Ref__c/' with '/Oracle_Fusion_Supplier_Ref__c/External_Id__c/',
        "method": "PATCH",
        "referenceId": 'OFSR_' ++ pindex,
        "body": {
            ("Account__c": "@{Account_" ++ index ++ '.id}') if (!isEmpty(item.AccountId)),
            "Supplier_ID__c" : pitem.Supplier_ID__c,
            "Party_ID__c" : pitem.Party_ID__c,
            "Supplier_Number__c" : pitem.Supplier_Number__c,
            "PNM_Last_Updated__c": now(),
            "PNM_Updated__c": "true" 
            }
        })   
 })}