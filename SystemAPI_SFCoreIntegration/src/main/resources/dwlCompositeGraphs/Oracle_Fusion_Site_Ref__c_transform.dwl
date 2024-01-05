%dw 2.0
output application/json skipNullOn="everywhere"

fun OFSRLoad(OFSR) = (payload map (item, index) -> {
    OFSRId: item.Oracle_Fusion_Supplier_Ref__c,
    fullPayload: item
 } ) filter ($.OFSRId == OFSR)

---

{ graphs:(

((payload map (item1, index1) -> {
    OFSRId: item1.Oracle_Fusion_Supplier_Ref__c,
    fullPayload: item1
 })  distinctBy $.OFSRId) map (item, index) -> {
    "graphId": index,
    "compositeRequest": 

	 (OFSRLoad(item.OFSRId).fullPayload map (pitem, pindex) -> {
        "url" : (pitem.attributes.url) replace '/Oracle_Fusion_Site_Ref__c/' with '/Oracle_Fusion_Site_Ref__c/External_Id__c/',
        "method": "PATCH",
        "referenceId": 'OFSiteRef_' ++ pindex,
        "body": {
            ("Oracle_Fusion_Supplier_Ref__r": {"External_Id__c": item.fullPayload.Oracle_Fusion_Supplier_Ref__c }) if (!isEmpty(item.fullPayload.Oracle_Fusion_Supplier_Ref__c)),
            "Supplier_Site__c" : pitem.Supplier_Site__c,
            "Site_ID__c" : pitem.Site_ID__c,
            "Bank_Account_ID__c" : pitem.Bank_Account_ID__c,
            "PNM_Last_Updated__c": now(),
            "PNM_Updated__c": "true" 
           }})
              
 })}