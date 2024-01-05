%dw 2.0
output application/json skipNullOn="everywhere"
---
payload map {
    "External_Id__c": $.Integration_ID__c,
    "Phone": $.Phone,
    "Fax": $.Fax,
   // "PersonEmailBouncedReason": $.PersonEmailBouncedReason,
    //"PersonMobilePhone" : $.PersonMobilePhone,
    "AccountNumber" : $.AccountNumber,
    //"PersonEmail" : $.PersonEmail,
    "Website" : $.Website,
    "Jigsaw" : $.Jigsaw,
    //"PersonGender" : $.PersonGender,
    //"PersonDepartment" : $.PersonDepartment,
	
    //("PersonSequenceInMultipleBirth" : $.PersonSequenceInMultipleBirth as Number) if (!isEmpty($.PersonSequenceInMultipleBirth)),
    "Description" : $.Description,
    "SicDesc" : $.SicDesc,
    "IsActive" : if ($.IsActive == 'false') false else true,
	"Sic" : $.Sic,
	"AnnualRevenue" : $.AnnualRevenue,
	"Name": $.Name,
    "TickerSymbol" : $.TickerSymbol,
    
    
    
    //"IsCustomerPortal" :if ($.IsCustomerPortal == 'false') false else true,
    
    
    
    //"BillingAddress" : $.BillingAddress,
    //"ShippingAddress" : $.ShippingAddress,
    //"PersonContactId" : $.PersonContactId, "Unable to create/update fields: PersonContactId. Please check the security settings of this field and verify that it is read/write for your profile or permission set."
    //"PersonTitle" : $.PersonTitle,
	//"PersonMaritalStatus" : $.PersonMaritalStatus,
	//"PersonDeceasedDate" : $.PersonDeceasedDate,
	//"Site" : $.Site,
	//"IsDeleted" : if ($.IsDeleted == 'false') false else true,  "Unable to create/update fields: IsDeleted. Please check the security settings of this field and verify that it is read/write for your profile or permission set."
	//"ParentId" : $.ParentId,
	//"SourceSystemIdentifier" : $.SourceSystemIdentifier,
	//"OperatingHoursId" : $.OperatingHoursId,
	//"EndDate" : $.EndDate,
	//"PhotoUrl" : $.PhotoUrl,
	//"OwnerId" : $.OwnerId,
	//"NumberOfEmployees" : $.NumberOfEmployees,
	//"Ownership" : $.Ownership,
	//"NumberOfEmployees" : $.NumberOfEmployees,
	//"PersonMobilePhone" : $.PersonMobilePhone,
	
	
	//"Rating" : $.Rating,
	//"AccountNumber" : $.AccountNumber,
	
	//"PersonLastCUUpdateDate" : $.PersonLastCUUpdateDate,
	
	//"RecordTypeId" : $.RecordTypeId,
	//"LastActivityDate" : $.LastActivityDate,
	//"PersonLastCURequestDate" : $.PersonLastCURequestDate,
	//"LastReferencedDate" : $.LastReferencedDate,
	//"JigsawCompanyId" : $.JigsawCompanyId,
	//"LastViewedDate" : $.LastViewedDate,
	
	
	//"MasterRecordId" : $.MasterRecordId,
//	"EffectiveDate" : $.EffectiveDate,
	
	
	//"SystemModstamp" : $.SystemModstamp,
	
//	"PersonIndividualId" : $.PersonIndividualId,
//	"TickerSymbol" : $.TickerSymbol,
//	"Type" : $.Type,
	//"PersonMailingAddress" : $.PersonMailingAddress,
//	"PersonEmailBouncedDate" : $.PersonEmailBouncedDate,
	//"IsPersonAccount" : if ($.IsPersonAccount == 'false') false else true,   "Unable to create/update fields: IsPersonAccount. Please check the security settings of this field and verify that it is read/write for your profile or permission set."
	
	//"LastModifiedById" : $.LastModifiedById,
	
//	"SourceSystemModifiedDate" : $.SourceSystemModifiedDate
	
    
    

}