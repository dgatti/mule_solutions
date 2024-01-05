%dw 2.0
output application/json skipNullOn="everywhere"
fun coreRecTypeId(rtId,rtObj) = (vars.coreRT filter ($.DeveloperName == ((vars.pnmRT filter ($.Id == rtId and $.SobjectType == rtObj)).DeveloperName[0]) and $.SobjectType == rtObj)).Id[0]

fun actType (rtId) = if (['PersonAccount', 'Provider'] contains (vars.pnmRT filter ($.Id == rtId)).DeveloperName[0]) 'PersonAcct' else 'BussAcct'

---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 
  
  ( if (item.ParentRecord.'Type' == "Account")   
	 [{
	      "url" : (item.ParentRecord.attributes.url) replace '/Account/' with '/Account/External_Id__c/' ,
	      "method": "PATCH",
	      "referenceId": 'ParentAccount_' ++ index,
	      "body" : {
	        ("FirstName" : item.ParentRecord.FirstName) if (actType(item.ParentRecord.RecordTypeId) == 'PersonAcct') ,
			("LastName" : item.ParentRecord.LastName) if (actType(item.ParentRecord.RecordTypeId) == 'PersonAcct'),
			("MiddleName" : item.ParentRecord.MiddleName) if (actType(item.ParentRecord.RecordTypeId) == 'PersonAcct'),
			("Name" : item.ParentRecord.Name) if (actType(item.ParentRecord.RecordTypeId) != 'PersonAcct'),
	        "RecordTypeId": coreRecTypeId(item.ParentRecord.RecordTypeId, 'Account')
            }
	 }] else   [])
	 
++


( if (item.ParentRecord.'Type' == "Contact")   
	 [{
	      "url" : (item.ParentRecord.attributes.url) replace '/Contact/' with '/Contact/External_Id__c/' ,
	      "method": "PATCH",
	      "referenceId": 'ParentContact_' ++ index,
	      "body" : {
	        "FirstName" : item.ParentRecord.FirstName ,
			"LastName" : item.ParentRecord.LastName,
	        "RecordTypeId": coreRecTypeId(item.ParentRecord.RecordTypeId, 'Contact')
            }
	 }] else   [])
	 
++

( if (item.ParentRecord.'Type' == "HealthcareFacility")   
	 [{
	      "url" : (item.ParentRecord.attributes.url) replace '/HealthcareFacility/' with '/HealthcareFacility/External_Id__c/' ,
	      "method": "PATCH",
	      "referenceId": 'ParentHealthcareFacility_' ++ index,
	      "body" : {
	        "Name" : item.ParentRecord.Name
            }
	 }] else   [])
	 
++

( if (item.ParentRecord.'Type' == "HealthcareProvider")   
	 [{
	      "url" : (item.ParentRecord.attributes.url) replace '/HealthcareProvider/' with '/HealthcareProvider/External_Id__c/' ,
	      "method": "PATCH",
	      "referenceId": 'ParentHealthcareProvider_' ++ index,
	      "body" : {
	        "Name" : item.ParentRecord.Name
            }
	 }] else   [])
	 
++

( if (item.ParentRecord.'Type' == "HealthcarePractitionerFacility")   
	 [{
	      "url" : (item.ParentRecord.attributes.url) replace '/HealthcarePractitionerFacility/' with '/HealthcarePractitionerFacility/External_Id__c/' ,
	      "method": "PATCH",
	      "referenceId": 'ParentHealthcarePractitionerFacility_' ++ index,
	      "body" : {
	        "Name" : item.ParentRecord.Name
            }
	 }] else   [])
	 
++

( if (!isEmpty(item.IssuingAuthorityId))   
	 [{
      "url" : (item.IssuingAuthority.attributes.url) replace '/Account/' with '/Account/External_Id__c/' ,
      "method": "GET",
      "referenceId": 'Account_' ++ index
   }] else   [])

++

  
  [{
      "url" : (item.attributes.url) replace '/Identifier/' with '/Identifier/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'Identifier_' ++ index,
      "body" : {
        ("IssuingAuthorityId": "@{Account_" ++ index ++ '.Id}') if (!isEmpty(item.IssuingAuthorityId)),
        ("ParentRecordId": "@{ParentAccount_" ++ index ++ '.id}')  if (item.ParentRecord.'Type' == "Account"),
        ("ParentRecordId": "@{ParentContact_" ++ index ++ '.id}')  if (item.ParentRecord.'Type' == "Contact"),
        ("ParentRecordId": "@{ParentHealthcareFacility_" ++ index ++ '.id}')  if (item.ParentRecord.'Type' == "HealthcareFacility") ,
        ("ParentRecordId": "@{ParentHealthcareProvider_" ++ index ++ '.id}')  if (item.ParentRecord.'Type' == "HealthcareProvider")  ,
        ("ParentRecordId": "@{ParentHealthcarePractitionerFacility_" ++ index ++ '.id}')  if (item.ParentRecord.'Type' == "HealthcarePractitionerFacility") ,
        "EffectiveDate": item.EffectiveDate,
        "EndDate": item.EndDate,
        "IdUsageType": item.IdUsageType,
        "IdValue": item.IdValue,
        "SourceSystem": item.SourceSystem,
        "SourceSystemIdentifier": item.SourceSystemIdentifier,
        "SourceSystemModified": item.SourceSystemModified,
        "PNM_Last_Updated__c": now(),
        "PNM_Updated__c": "true"
        
        
      }
  }]
      
})}