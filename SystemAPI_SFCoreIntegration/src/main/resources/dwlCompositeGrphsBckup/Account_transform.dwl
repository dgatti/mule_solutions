%dw 2.0
output application/json skipNullOn="everywhere"

fun coreRecTypeId(rtId,rtObj) = (vars.coreRT filter ($.DeveloperName == ((vars.pnmRT filter ($.Id == rtId and $.SobjectType == rtObj)).DeveloperName[0]) and $.SobjectType == rtObj)).Id[0]

//fun actType (rtId) = if (['PersonAccount', 'Provider'] contains (vars.pnmRT filter ($.Id == rtId)).DeveloperName[0]) 'PersonAcct' else 'BussAcct'

fun actType (rtId) = if ((vars.pnmRT filter ($.Id == rtId)).IsPersonType[0]) 'PersonAcct' else 'BussAcct'

//fun recType(rtId,rtObj) =  (vars.pnmRT filter ($.Id == rtId and $.SobjectType == rtObj)).DeveloperName[0]

---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 
  
  ( if (!isEmpty(item.Affiliation_Name__c))   
	 [{
	      "url" : (item.Affiliation_Name__r.attributes.url) replace '/Account/' with '/Account/External_Id__c/' ,
	      "method": "PATCH",
	      "referenceId": 'AffiliationAccount_' ++ index,
	      "body" : {
	        ("FirstName" : item.Affiliation_Name__r.FirstName) if (actType(item.Affiliation_Name__r.RecordTypeId) == 'PersonAcct') ,
			("LastName" : item.Affiliation_Name__r.LastName) if (actType(item.Affiliation_Name__r.RecordTypeId) == 'PersonAcct'),
			("MiddleName" : item.Affiliation_Name__r.MiddleName) if (actType(item.Affiliation_Name__r.RecordTypeId) == 'PersonAcct'),
			("Name" : item.Affiliation_Name__r.Name) if (actType(item.Affiliation_Name__r.RecordTypeId) != 'PersonAcct'),
	        "ShippingCity" : item.Affiliation_Name__r.ShippingCity,
	        "ShippingCountry" : item.Affiliation_Name__r.ShippingCountry,
	        "ShippingPostalCode" : item.Affiliation_Name__r.ShippingPostalCode,
	        "ShippingState" : item.Affiliation_Name__r.ShippingState,
	        "ShippingStreet" : item.Affiliation_Name__r.ShippingStreet,
	        "RecordTypeId": coreRecTypeId(item.Affiliation_Name__r.RecordTypeId, 'Account')
	        }
	 }] else   [])
++

( if (!isEmpty(item.HealthCloudGA__PrimaryContact__c) and  !isEmpty(item.HealthCloudGA__PrimaryContact__r.RecordTypeId))
   
	 [{
	      "url" : (item.HealthCloudGA__PrimaryContact__r.attributes.url) replace '/Contact/' with '/Contact/External_Id__c/' ,
	      "method": "PATCH",
	      "referenceId": 'HCGA_Contact_' ++ index,
	      "body" : {
	        "FirstName" : item.HealthCloudGA__PrimaryContact__r.FirstName,
	        "LastName" : item.HealthCloudGA__PrimaryContact__r.LastName,
	        "RecordTypeId": coreRecTypeId(item.HealthCloudGA__PrimaryContact__r.RecordTypeId, 'Contact')
	        }
	 }] else   [])
	 
	 
++
  
  [{
      "url" : (item.attributes.url) replace '/Account/' with '/Account/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'Account_' ++ index,
      "body" : {
        
		("Affiliation_Name__c": "@{AffiliationAccount_" ++ index ++ '.id}') if (!isEmpty(item.Affiliation_Name__c)),
		("HealthCloudGA__PrimaryContact__c": "@{HCGA_Contact_" ++ index ++ '.id}') if (!isEmpty(item.HealthCloudGA__PrimaryContact__c) and  !isEmpty(item.HealthCloudGA__PrimaryContact__r.RecordTypeId)),
		"BillingCity" : item.BillingCity,
		"BillingCountry" : item.BillingCountry,
		"BillingLatitude" : item.BillingLatitude,
		"BillingLongitude" : item.BillingLongitude,
		"BillingPostalCode" : item.BillingPostalCode,
		"BillingState" : item.BillingState,
		"BillingStreet" : item.BillingStreet,
		"Description" : item.Description,
		"Fax" : item.Fax,
		("FirstName" : item.FirstName) if (actType(item.RecordTypeId) == 'PersonAcct') ,
		("LastName" : item.LastName) if (actType(item.RecordTypeId) == 'PersonAcct'),
		("MiddleName" : item.MiddleName) if (actType(item.RecordTypeId) == 'PersonAcct'),
		("Name" : item.Name) if (actType(item.RecordTypeId) != 'PersonAcct'),
		"Group_Affiliation__c" : item.Group_Affiliation__c,
		"Group_Id__c" : item.Group_Id__c,
		"Health_System_Affiliation__c" : item.Health_System_Affiliation__c,
		"HealthCloudGA__Active__c" : item.HealthCloudGA__Active__c,
		("HealthCloudGA__Age__pc" : item.HealthCloudGA__Age__pc) if (actType(item.RecordTypeId) == 'PersonAcct') ,
		("HealthCloudGA__ConvertedReferrals__pc" : item.HealthCloudGA__ConvertedReferrals__pc) if (actType(item.RecordTypeId) == 'PersonAcct') ,
		("HealthCloudGA__DeceasedDate__pc" : item.HealthCloudGA__DeceasedDate__pc) if (actType(item.RecordTypeId) == 'PersonAcct') ,
		"HealthCloudGA__Disabled__c" : item.HealthCloudGA__Disabled__c,
		"HealthCloudGA__EnrollmentType__c" : item.HealthCloudGA__EnrollmentType__c,
		("HealthCloudGA__Gender__pc" : item.HealthCloudGA__Gender__pc) if (actType(item.RecordTypeId) == 'PersonAcct') ,
		"HealthCloudGA__Institution__c" : item.HealthCloudGA__Institution__c,
		"HealthCloudGA__OREC__c" : item.HealthCloudGA__OREC__c,
		"HealthCloudGA__PayerType__c" : item.HealthCloudGA__PayerType__c,
		("HealthCloudGA__PreferredName__pc" : item.HealthCloudGA__PreferredName__pc) if (actType(item.RecordTypeId) == 'PersonAcct') ,
		//"HealthCloudGA__PrimaryContact__c" : item.HealthCloudGA__PrimaryContact__c, //Lookup
		("HealthCloudGA__PrimaryLanguage__pc" : item.HealthCloudGA__PrimaryLanguage__pc) if (actType(item.RecordTypeId) == 'PersonAcct') ,
		("HealthCloudGA__ReferrerScore__pc" : item.HealthCloudGA__ReferrerScore__pc) if (actType(item.RecordTypeId) == 'PersonAcct') ,
		("HealthCloudGA__SecondaryLanguage__pc" : item.HealthCloudGA__SecondaryLanguage__pc) if (actType(item.RecordTypeId) == 'PersonAcct') ,
		"HealthCloudGA__SourceSystem__c" : item.HealthCloudGA__SourceSystem__c,
		("HealthCloudGA__SourceSystem__pc" : item.HealthCloudGA__SourceSystem__pc) if (actType(item.RecordTypeId) == 'PersonAcct') ,
		"HealthCloudGA__SourceSystemId__c" : item.HealthCloudGA__SourceSystemId__c,
		("HealthCloudGA__SourceSystemId__pc" : item.HealthCloudGA__SourceSystemId__pc) if (actType(item.RecordTypeId) == 'PersonAcct') ,
		"HealthCloudGA__TaxId__c" : item.HealthCloudGA__TaxId__c,
		("HealthCloudGA__Testing_Status__pc" : item.HealthCloudGA__Testing_Status__pc) if (actType(item.RecordTypeId) == 'PersonAcct') ,
		("HealthCloudGA__TotalReferrals__pc" : item.HealthCloudGA__TotalReferrals__pc) if (actType(item.RecordTypeId) == 'PersonAcct') ,
		
		//"ParentId" : item., (Lookup)
		"PersonBirthdate" : item.PersonBirthdate,
		"PersonDoNotCall" : item.PersonDoNotCall,
		"PersonEmail" : item.PersonEmail,
		"PersonHasOptedOutOfEmail" : item.PersonHasOptedOutOfEmail,
		"PersonHasOptedOutOfFax" : item.PersonHasOptedOutOfFax,
		"PersonLastCURequestDate" : item.PersonLastCURequestDate,
		"PersonLastCUUpdateDate" : item.PersonLastCUUpdateDate,
		"PersonLeadSource" : item.PersonLeadSource,
		"Mobile" : item.Mobile,
		"Title" : item.Title,
		"Phone" : item.Phone,
		"Provider_Status__c" : item.Provider_Status__c,
		"Provider_Type__c" : item.Provider_Type__c,
		"RecordTypeId": coreRecTypeId(item.RecordTypeId, 'Account'),
		"Salutation" : item.Salutation,
		"ShippingCity" : item.ShippingCity,
		"ShippingCountry" : item.ShippingCountry,
		"ShippingLatitude" : item.ShippingLatitude,
		"ShippingLongitude" : item.ShippingLongitude,
		"ShippingPostalCode" : item.ShippingPostalCode,
		"ShippingState" : item.ShippingState,
		"ShippingStreet" : item.ShippingStreet,
				
		//("ShippingCity" : item.ShippingCity) if (recType(item.RecordTypeId, vars.targetObjName) == 'Facility'),
		//("ShippingCountry" : item.ShippingCountry) if (recType(item.RecordTypeId, vars.targetObjName) == 'Facility'),
		//("ShippingLatitude" : item.ShippingLatitude) if (recType(item.RecordTypeId, vars.targetObjName) == 'Facility'),
		//("ShippingLongitude" : item.ShippingLongitude) if (recType(item.RecordTypeId, vars.targetObjName) == 'Facility'),
		//("ShippingPostalCode" : item.ShippingPostalCode) if (recType(item.RecordTypeId, vars.targetObjName) == 'Facility'),
		//("ShippingState" : item.ShippingState) if (recType(item.RecordTypeId, vars.targetObjName) == 'Facility'),
		//("ShippingStreet" : item.ShippingStreet) if (recType(item.RecordTypeId, vars.targetObjName) == 'Facility'),
		
		
		"Sic" : item.Sic,
		"SicDesc" : item.SicDesc,
		"Site" : item.Site,
		"Spoken_Language__c" : item.Spoken_Language__c,
		"Substatus__c" : item.Substatus__c,
		"Suffix" : item.Suffix,
		"Supervising_Physician_Email_Address__c" : item.Supervising_Physician_Email_Address__c,
		"Supervising_Physician_Name__c" : item.Supervising_Physician_Name__c,
		"Termination_Comments__c" : item.Termination_Comments__c,
		"Termination_Date__c" : item.Termination_Date__c,
		"Training_Flags__c" : item.Training_Flags__c,
		"Type" : item.Type,
		"Vendor_ID__c" : item.Vendor_ID__c,
		"VES_Specialty__c" : item.VES_Specialty__c,
		"Website" : item.Website,
		"Written_Languages__c" : item.Written_Languages__c,
		
		//New Field Addition from V2 Tab
		"ABI__c" : item.ABI__c, 
		"ABI_Comments__c" : item.ABI_Comments__c, 
	//	("Board_Certifications__pc" : item.Board_Certification__pc) if (actType(item.RecordTypeId) == 'PersonAcct') , 
		"Business_Category__c" : item.Business_Category__c, 
		"Currency__c" : item.Currency__c, 
		//"Deactivated_By__c" : item.Deactivated_By__c, 
		"Deactivation_Date__c" : item.Deactivation_Date__c, 
		"Deactivation_Reason__c" : item.Deactivation_Reason__c, 
		"Dexa__c" : item.Dexa__c, 
		"Dexa_Comments__c" : item.Dexa_Comments__c, 
		"Diagnostic_Facility_Billing_Type__c" : item.Diagnostic_Facility_Billing_Type__c, 
		"DLCO__c" : item.DLCO__c, 
		"DLCO_Comments__c" : item.DLCO_Comments__c, 
		"DUNS_Number__c" : item.DUNS_Number__c, 
		"Echo__c" : item.Echo__c, 
		"Echo_Comments__c" : item.Echo_Comments__c, 
		"EKG__c" : item.EKG__c, 
		"EKG_Comments__c" : item.EKG_Comments__c, 
		"EMG__c" : item.EMG__c, 
		"EMG_Comments__c" : item.EMG_Comments__c, 
		"Facility_Code__c" : item.Facility_Code__c, 
		"Facility_Type__c" : item.Facility_Type__c, 
		"Federal_Tax_Classification__c" : item.Federal_Tax_Classification__c, 
		"International_Domestic__c" : item.International_Domestic__c, 
		"Labs__c" : item.Labs__c, 
		"Labs_Comments__c" : item.Labs_Comments__c, 
		"MRI__c" : item.MRI__c, 
		"MRI_Comments__c" : item.MRI_Comments__c, 
		"NPI_Number__pc" : item.NPI__c, 
		"Other__c" : item.Other__c, 
		"Other_Comments__c" : item.Other_Comments__c, 
		"OOA__c" : item.OOA__c, 
		"PFT__c" : item.PFT__c, 
		"PFT_Comments__c" : item.PFT_Comments__c, 
		"Provider_CAPS_Summary__c" : item.Provider_CAPS_Summary__c, 
		"Provider_License__c" : item.Provider_License__c, 
		//"Reactivated_By__c" : item.Reactivated_By__c, 
		"Reactivation_Date__c" : item.Reactivation_Date__c, 
		"Semen_Analysis__c" : item.Semen_Analysis__c, 
		"Semen_Analysis_Comments__c" : item.Semen_Analysis_Comments__c, 
		"Sleep_Study__c" : item.Sleep_Study_PNM__c, 
		"Sleep_Study_Comments__c" : item.Sleep_Study_Comments__c, 
		"UGI__c" : item.UGI__c, 
		"UGI_Comments__c" : item.UGI_Comments__c, 
		"Ultrasound__c" : item.Ultrasound__c, 
		"Ultrasound_Comments__c" : item.Ultrasound_Comments__c, 
		"Region_PNM__c" : item.Region__c, 
		"Urinalysis__c" : item.Urinalysis__c, 
		"Urinalysis_Comments__c" : item.Urinalysis_Comments__c,
		"PNM_Last_Updated__c": now(),
        "PNM_Updated__c": "true" 
		
      }
  }]
  
  
  
++ flatten([ item.ChildAccounts.records  map  (item1, index1) -> {
     
      "url" : (item1.attributes.url) replace '/Account/' with '/Account/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'ChildAccount_' ++ index1,
      "body" : {
        
		("ParentId": "@{Account_" ++ index ++ '.id}') if (!isEmpty(item1.ParentId)),
		"BillingCity" : item1.BillingCity,
		"BillingCountry" : item1.BillingCountry,
		"BillingLatitude" : item1.BillingLatitude,
		"BillingLongitude" : item1.BillingLongitude,
		"BillingPostalCode" : item1.BillingPostalCode,
		"BillingState" : item1.BillingState,
		"BillingStreet" : item1.BillingStreet,
		"Description" : item1.Description,
		"Fax" : item1.Fax,
		("FirstName" : item1.FirstName) if (actType(item1.RecordTypeId) == 'PersonAcct') ,
		("LastName" : item1.LastName) if (actType(item1.RecordTypeId) == 'PersonAcct'),
		("MiddleName" : item1.MiddleName) if (actType(item1.RecordTypeId) == 'PersonAcct'),
		("Name" : item.Name) if (actType(item1.RecordTypeId) != 'PersonAcct'),
		"Group_Affiliation__c" : item1.Group_Affiliation__c,
		"Group_Id__c" : item1.Group_Id__c,
		"Health_System_Affiliation__c" : item1.Health_System_Affiliation__c,
		"HealthCloudGA__Active__c" : item1.HealthCloudGA__Active__c,
		("HealthCloudGA__Age__pc" : item1.HealthCloudGA__Age__pc) if (actType(item1.RecordTypeId) == 'PersonAcct'),
		("HealthCloudGA__ConvertedReferrals__pc" : item1.HealthCloudGA__ConvertedReferrals__pc) if (actType(item1.RecordTypeId) == 'PersonAcct'),
		("HealthCloudGA__DeceasedDate__pc" : item1.HealthCloudGA__DeceasedDate__pc) if (actType(item1.RecordTypeId) == 'PersonAcct'),
		"HealthCloudGA__Disabled__c" : item1.HealthCloudGA__Disabled__c,
		"HealthCloudGA__EnrollmentType__c" : item1.HealthCloudGA__EnrollmentType__c,
		("HealthCloudGA__Gender__pc" : item1.HealthCloudGA__Gender__pc) if (actType(item1.RecordTypeId) == 'PersonAcct'),
		"HealthCloudGA__Institution__c" : item1.HealthCloudGA__Institution__c,
		"HealthCloudGA__OREC__c" : item1.HealthCloudGA__OREC__c,
		"HealthCloudGA__PayerType__c" : item1.HealthCloudGA__PayerType__c,
		("HealthCloudGA__PreferredName__pc" : item1.HealthCloudGA__PreferredName__pc) if (actType(item1.RecordTypeId) == 'PersonAcct'),
		//"HealthCloudGA__PrimaryContact__c" : item1.HealthCloudGA__PrimaryContact__c, //Lookup
		("HealthCloudGA__PrimaryLanguage__pc" : item1.HealthCloudGA__PrimaryLanguage__pc) if (actType(item1.RecordTypeId) == 'PersonAcct'),
		("HealthCloudGA__ReferrerScore__pc" : item1.HealthCloudGA__ReferrerScore__pc) if (actType(item1.RecordTypeId) == 'PersonAcct'),
		("HealthCloudGA__SecondaryLanguage__pc" : item1.HealthCloudGA__SecondaryLanguage__pc) if (actType(item1.RecordTypeId) == 'PersonAcct'),
		"HealthCloudGA__SourceSystem__c" : item1.HealthCloudGA__SourceSystem__c,
		("HealthCloudGA__SourceSystem__pc" : item1.HealthCloudGA__SourceSystem__pc) if (actType(item1.RecordTypeId) == 'PersonAcct'),
		"HealthCloudGA__SourceSystemId__c" : item1.HealthCloudGA__SourceSystemId__c,
		("HealthCloudGA__SourceSystemId__pc" : item1.HealthCloudGA__SourceSystemId__pc) if (actType(item1.RecordTypeId) == 'PersonAcct'),
		"HealthCloudGA__TaxId__c" : item1.HealthCloudGA__TaxId__c,
		("HealthCloudGA__Testing_Status__pc" : item1.HealthCloudGA__Testing_Status__pc) if (actType(item1.RecordTypeId) == 'PersonAcct'),
		("HealthCloudGA__TotalReferrals__pc" : item1.HealthCloudGA__TotalReferrals__pc) if (actType(item1.RecordTypeId) == 'PersonAcct'),
		
		//"ParentId" : item1., (Lookup)
		"PersonBirthdate" : item1.PersonBirthdate,
		"PersonDoNotCall" : item1.PersonDoNotCall,
		"PersonEmail" : item1.PersonEmail,
		"PersonHasOptedOutOfEmail" : item1.PersonHasOptedOutOfEmail,
		"PersonHasOptedOutOfFax" : item1.PersonHasOptedOutOfFax,
		"PersonLastCURequestDate" : item1.PersonLastCURequestDate,
		"PersonLastCUUpdateDate" : item1.PersonLastCUUpdateDate,
		"PersonLeadSource" : item1.PersonLeadSource,
		"Mobile" : item1.Mobile,
		"Title" : item1.Title,
		"Phone" : item1.Phone,
		"Provider_Status__c" : item1.Provider_Status__c,
		"Provider_Type__c" : item1.Provider_Type__c,
		"RecordTypeId": coreRecTypeId(item1.RecordTypeId, 'Account'),
		"Salutation" : item1.Salutation,
		"ShippingCity" : item1.ShippingCity,
		"ShippingCountry" : item1.ShippingCountry,
		"ShippingLatitude" : item1.ShippingLatitude,
		"ShippingLongitude" : item1.ShippingLongitude,
		"ShippingPostalCode" : item1.ShippingPostalCode,
		"ShippingState" : item1.ShippingState,
		"ShippingStreet" : item1.ShippingStreet,
				
		//("ShippingCity" : item1.ShippingCity) if (recType(item1.RecordTypeId, vars.targetObjName) == 'Facility'),
		//("ShippingCountry" : item1.ShippingCountry) if (recType(item1.RecordTypeId, vars.targetObjName) == 'Facility'),
		//("ShippingLatitude" : item1.ShippingLatitude) if (recType(item1.RecordTypeId, vars.targetObjName) == 'Facility'),
		//("ShippingLongitude" : item1.ShippingLongitude) if (recType(item1.RecordTypeId, vars.targetObjName) == 'Facility'),
		//("ShippingPostalCode" : item1.ShippingPostalCode) if (recType(item1.RecordTypeId, vars.targetObjName) == 'Facility'),
		//("ShippingState" : item1.ShippingState) if (recType(item1.RecordTypeId, vars.targetObjName) == 'Facility'),
		//("ShippingStreet" : item1.ShippingStreet) if (recType(item1.RecordTypeId, vars.targetObjName) == 'Facility'),
		
		
		"Sic" : item1.Sic,
		"SicDesc" : item1.SicDesc,
		"Site" : item1.Site,
		"Spoken_Language__c" : item1.Spoken_Language__c,
		"Substatus__c" : item1.Substatus__c,
		"Suffix" : item1.Suffix,
		"Supervising_Physician_Email_Address__c" : item1.Supervising_Physician_Email_Address__c,
		"Supervising_Physician_Name__c" : item1.Supervising_Physician_Name__c,
		"Termination_Comments__c" : item1.Termination_Comments__c,
		"Termination_Date__c" : item1.Termination_Date__c,
		"Training_Flags__c" : item1.Training_Flags__c,
		"Type" : item1.Type,
		"Vendor_ID__c" : item1.Vendor_ID__c,
		"VES_Specialty__c" : item1.VES_Specialty__c,
		"Website" : item1.Website,
		"Written_Languages__c" : item1.Written_Languages__c,
		
		//New Field Addition from V2 Tab
		"ABI__c" : item1.ABI__c, 
		"ABI_Comments__c" : item1.ABI_Comments__c, 
		//("Board_Certification__pc" : item1.Board_Certification__pc) if (actType(item1.RecordTypeId) == 'PersonAcct') , 
		"Business_Category__c" : item1.Business_Category__c, 
		"Currency__c" : item1.Currency__c, 
		//"Deactivated_By__c" : item1.Deactivated_By__c, 
		"Deactivation_Date__c" : item1.Deactivation_Date__c, 
		"Deactivation_Reason__c" : item1.Deactivation_Reason__c, 
		"Dexa__c" : item1.Dexa__c, 
		"Dexa_Comments__c" : item1.Dexa_Comments__c, 
		"Diagnostic_Facility_Billing_Type__c" : item1.Diagnostic_Facility_Billing_Type__c, 
		"DLCO__c" : item1.DLCO__c, 
		"DLCO_Comments__c" : item1.DLCO_Comments__c, 
		"DUNS_Number__c" : item1.DUNS_Number__c, 
		"Echo__c" : item1.Echo__c, 
		"Echo_Comments__c" : item1.Echo_Comments__c, 
		"EKG__c" : item1.EKG__c, 
		"EKG_Comments__c" : item1.EKG_Comments__c, 
		"EMG__c" : item1.EMG__c, 
		"EMG_Comments__c" : item1.EMG_Comments__c, 
		"Facility_Code__c" : item1.Facility_Code__c, 
		"Facility_Type__c" : item1.Facility_Type__c, 
		"Federal_Tax_Classification__c" : item1.Federal_Tax_Classification__c, 
		"International_Domestic__c" : item1.International_Domestic__c, 
		"Labs__c" : item1.Labs__c, 
		"Labs_Comments__c" : item1.Labs_Comments__c, 
		"MRI__c" : item1.MRI__c, 
		"MRI_Comments__c" : item1.MRI_Comments__c, 
		"NPI_Number__pc" : item1.NPI__c, 
		"Other__c" : item1.Other__c, 
		"Other_Comments__c" : item1.Other_Comments__c, 
		"OOA__c" : item1.OOA__c, 
		"PFT__c" : item1.PFT__c, 
		"PFT_Comments__c" : item1.PFT_Comments__c, 
		"Provider_CAPS_Summary__c" : item1.Provider_CAPS_Summary__c, 
		"Provider_License__c" : item1.Provider_License__c, 
		//"Reactivated_By__c" : item1.Reactivated_By__c, 
		"Reactivation_Date__c" : item1.Reactivation_Date__c, 
		"Semen_Analysis__c" : item1.Semen_Analysis__c, 
		"Semen_Analysis_Comments__c" : item1.Semen_Analysis_Comments__c, 
		"Sleep_Study__c" : item1.Sleep_Study_PNM__c, 
		"Sleep_Study_Comments__c" : item1.Sleep_Study_Comments__c, 
		"UGI__c" : item1.UGI__c, 
		"UGI_Comments__c" : item1.UGI_Comments__c, 
		"Ultrasound__c" : item1.Ultrasound__c, 
		"Ultrasound_Comments__c" : item1.Ultrasound_Comments__c, 
		"Region_PNM__c" : item1.Region__c, 
		"Urinalysis__c" : item1.Urinalysis__c, 
		"Urinalysis_Comments__c" : item1.Urinalysis_Comments__c
		
		
      }
}] filter ($.body != null)) 


++ flatten([ item.Rate_Card_Line_Items__r.records  map  (item2, index2) -> {
      
      "url" : (item2.attributes.url) replace '/Rate_Card_Line_Item__c/' with '/Rate_Card_Line_Item__c/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'RCLI_' ++ index2,
      "body" : {
        ("Account__c": "@{Account_" ++ index ++ '.id}') if (!isEmpty(item2.Account__c)),
        "Total_Price__c": item2.Total_Price__c,
        "Multiplier__c": item2.Multiplier__c
        
      }
}
  ] filter ($.body != null))

 
++ flatten([ item.Specialty_Training_Trackings__r.records  map  (item3, index3) -> {
      
      "url" : (item3.attributes.url) replace '/Training_Tracking__c/' with '/Training_Tracking__c/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'TrnTrk_' ++ index3,
      "body" : {
        ("Account__c": "@{Account_" ++ index ++ '.id}') if (!isEmpty(item3.Account__c)),
        "Name": item3.Name
      }
}
  ] filter ($.body != null))
  
  
++ flatten([ item.HealthcareProviderSpecialties.records  map  (item4, index4) -> {
      
      "url" : (item4.attributes.url) replace '/HealthcareProviderSpecialty/' with '/HealthcareProviderSpecialty/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'HCPS_' ++ index4,
      "body" : {
        ("AccountId": "@{Account_" ++ index ++ '.id}') if (!isEmpty(item4.AccountId)),
        "Name": item4.Name,
        "EffectiveFrom": item4.EffectiveFrom
      }
}
  ] filter ($.body != null))
  

++ flatten([ item.HealthcareProviders.records  map  (item5, index5) -> {
      
      "url" : (item5.attributes.url) replace '/HealthcareProvider/' with '/HealthcareProvider/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'HCP_' ++ index5,
      "body" : {
        ("AccountId": "@{Account_" ++ index ++ '.id}') if (!isEmpty(item5.AccountId)),
        "Name": item5.Name,
        "ProviderType": item5.ProviderType
      }
}
  ] filter ($.body != null))
 
 
++ flatten([ item.HealthcarePractitionerFacilities.records  map  (item6, index6) -> {
      
      "url" : (item6.attributes.url) replace '/HealthcarePractitionerFacility/' with '/HealthcarePractitionerFacility/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'HCPF_' ++ index6,
      "body" : {
        ("AccountId": "@{Account_" ++ index ++ '.id}') if (!isEmpty(item6.AccountId)),
        "Name": item6.Name,
        "EffectiveFrom": item6.EffectiveFrom
      }
}
  ] filter ($.body != null))


++ flatten([ item.Care_Provider_Facility_Specialties.records  map  (item7, index7) -> {
      
      "url" : (item7.attributes.url) replace '/CareProviderFacilitySpecialty/' with '/CareProviderFacilitySpecialty/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'CPFS_' ++ index7,
      "body" : {
        ("AccountId": "@{Account_" ++ index ++ '.id}') if (!isEmpty(item7.AccountId)),
        "Name": item7.Name,
        "EffectiveFrom": item7.EffectiveFrom
      }
}
  ] filter ($.body != null))

      
})}