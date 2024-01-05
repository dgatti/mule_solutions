%dw 2.0

fun buildExamRequestFaultEventXmlResponse(xmlPayload, error) =
	do {
		ns em http://va.gov/vler/schemas/vlerSupersetSchema/examManagement/4.3
		---
		if(xmlPayload != null)
		{	
			em#ExamManagementEventNotification:
				{
					em#OriginatingSystem @(participatingSystemName: xmlPayload.ExamManagementEventNotification.OriginatingSystem.@participatingSystemName default null, 
											contractorName: xmlPayload.ExamManagementEventNotification.Destination.@participatingSystemName default null): null,
					em#Destination @(participatingSystemName: xmlPayload.ExamManagementEventNotification.Destination.@participatingSystemName default null): null,
					em#RequestScopedFaultEvent @(eventDtg: xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.@eventDtg default null,
						modelVersion: xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.@modelVersiond default null, 
						examSchedulingRequestUuid: xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.@examSchedulingRequestUuid default null,
           				 previousEventUuid: xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.@previousEventUuid default null,
           				 eventUuid: xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.@eventUuid default null
					):{
						em:Details: error.description,
						em#EventSource @(participatingSystemName: xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.EventSource.@participatingSystemName default null,
											contractorName:xmlPayload.ExamManagementEventNotification.Destination.@participatingSystemName default null): null
					}
				}
		}else
			null
	}

fun buildExamRequestAcknowledgementEventXmlResponse(xmlPayload) =
	do {
		ns em http://va.gov/vler/schemas/vlerSupersetSchema/examManagement/4.3
		---
		if(xmlPayload != null)
		{
			em#ExamManagementEventNotification:
				{
					em#OriginatingSystem @(participatingSystemName: xmlPayload.ExamManagementEventNotification.OriginatingSystem.@participatingSystemName default null, 
											contractorName: xmlPayload.ExamManagementEventNotification.Destination.@participatingSystemName default null): null,
					em#Destination @(participatingSystemName: xmlPayload.ExamManagementEventNotification.Destination.@participatingSystemName default null): null,
					em#ExamRequestAcknowledgementEvent @(eventDtg: xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.@eventDtg default null,
						modelVersion: xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.@modelVersiond default null, 
						examSchedulingRequestUuid: xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.@examSchedulingRequestUuid default null,
           				 previousEventUuid: xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.@previousEventUuid default null,
           				 eventUuid: xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.@eventUuid default null
					):{
						em#EventSource @(participatingSystemName: xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.EventSource.@participatingSystemName default null,
											contractorName:xmlPayload.ExamManagementEventNotification.Destination.@participatingSystemName default null): null
					}
				}
		}else
			null
	}
	
fun buildVAPeriodOfServiceCustomObjectPayload(xmlPayload, vaESRID) =
	if(xmlPayload != null)
	{
		"VA_Inbound_Request__c": vaESRID default null,
		"Branch_Of_Service__c": xmlPayload.ExamManagementEventNotificationReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PeriodsOfService[0].@branchOfService default null,
		"Entry_On_Duty__c": xmlPayload.ExamManagementEventNotificationReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PeriodsOfService[0].@entryOnDuty default null,
		"Rad_Date__c": xmlPayload.ExamManagementEventNotificationReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PeriodsOfService[0].@radDate default null,
	}
	else
		null

fun buildVAESRCustomObjectPayload(xmlPayload) =
	if(xmlPayload != null)
	{	
		//Required field
		"examSchedulingRequestUuid__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.@examSchedulingRequestUuid,
			
		"participatingSystemName__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.EventSource.@participatingSystemName default null,
		"contractorName__c": xmlPayload.ExamManagementEventNotificationReworkExamSchedulingRequestCreatedEvent.EventSource.@contractorName default null,
		"claimDate__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.@claimDate default null,
		"claimLabel__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.@claimLabel default null,
		"endProductCode__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.@endProductCode default null,
		"claimPayeeCode__c":  xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.@claimPayeeCode default null,
		"survivorOrDependentPayeeCode__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.@survivorOrDependentPayeeCode default null,
		"benefitProgramType__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.@benefitProgramType default null,
		"EDIPI__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.@EDIPI default null,
		"firstName__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.@firstName default null,
		"fullName__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.@fullName default null,
		"lastName__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.@lastName default null,
		"middleName__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.@middleName default null,
		"dateOfBirth__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.@dateOfBirth default null,
		"dateOfDeath__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.@dateOfDeath default null,
		"gender__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.@gender default null,
		"regionalOfficeCode__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.@regionalOfficeCode default null,
		"emailAddress__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.@emailAddress default null,
		"fileNumber__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.@fileNumber default null,
		"pregnant__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.@pregnant default null,
		"geoDescription__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PreferredGeographicLocation.@description default null,
		"geoAddress1__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PreferredGeographicLocation.Address1 default null,
		"geoAddress2__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PreferredGeographicLocation.Address2 default null,
		"geoAddress3__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PreferredGeographicLocation.Address3 default null,
		"geoCity__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PreferredGeographicLocation.City default null,
		"geoState__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PreferredGeographicLocation.State default null,
		"geoZipOrPostalCode__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PreferredGeographicLocation.ZipOrPostalCode default null,
		"geoCountry__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PreferredGeographicLocation.Country default null,
		"geoMilitaryPO__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PreferredGeographicLocation.MilitaryPO default null,
		"geoMilitaryPostalCode__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PreferredGeographicLocation.MilitaryPostalCode default null,
		"mscprimaryphone__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.Phone.@primaryPhone default null,
		"mscsecondaryphone__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.Phone.@alternatePhone default null,
		"assigningAuthority__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.IntegrationControlNumber.@assigningAuthority default null,

		"Value__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.IntegrationControlNumber.Value default null,
		"PoaVsoName__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PoaVso.Name default null,
		"PoaVsoCode__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PoaVso.Code default null,
		"PoaVsodescription__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PoaVso.Address.@description default null,
		"PoaVsoAddress1__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PoaVso.Address.Address1 default null,
		"PoaVsoAddress2__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PoaVso.Address.Address2 default null,
		"PoaVsoAddress3__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PoaVso.Address.Address3 default null,
		"PoaVsoCity__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PoaVso.Address.City default null,
		"PoaVsoState__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PoaVso.Address.State default null,
		"PoaVsoZipOrPostalCode__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PoaVso.Address.ZipOrPostalCode default null,
		"PoaVsoCountry__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PoaVso.Address.Country default null,
		"PoaVsoMilitaryPO__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PoaVso.Address.MilitaryPO default null,
		"PoaVsoMilitaryPostalCode__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.VeteranServiceMemberInfo.PoaVso.Address.MilitaryPostalCode default null,
		"dependentfirstName__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.SurvivorAndDependentInfo.@firstName default null,
		"dependentlastName__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.SurvivorAndDependentInfo.@lastName default null,
		"dependentmiddleName__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.SurvivorAndDependentInfo.@middleName default null,
		"dependentgender__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.SurvivorAndDependentInfo.@gender default null,
		"dependentemailAddress__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.SurvivorAndDependentInfo.@emailAddress default null,
		"code__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.SurvivorAndDependentInfo.@code default null,
		"dependentgeoDescription__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.SurvivorAndDependentInfo.PreferredGeographicLocation.@description default null,
		"dependentgeoAddress1__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.SurvivorAndDependentInfo.PreferredGeographicLocation.Address1 default null,
		"dependentgeoAddress2__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.SurvivorAndDependentInfo.PreferredGeographicLocation.Address2 default null,
		"dependentgeoAddress3__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.SurvivorAndDependentInfo.PreferredGeographicLocation.Address3 default null,
		"dependentgeoCity__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.SurvivorAndDependentInfo.PreferredGeographicLocation.City default null,
		"dependentgeoState__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.SurvivorAndDependentInfo.PreferredGeographicLocation.State default null,
		"dependentgeoZipOrPostalCode__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.SurvivorAndDependentInfo.PreferredGeographicLocation.ZipOrPostalCode default null,
		"dependentgeoCountry__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.SurvivorAndDependentInfo.PreferredGeographicLocation.Country default null,
		"dependentgeoMilitaryPO__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.SurvivorAndDependentInfo.PreferredGeographicLocation.MilitaryPO default null,
		"dependentgeoMilitaryPostalCode__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.SurvivorAndDependentInfo.PreferredGeographicLocation.MilitaryPostalCode default null,
		"dependentprimaryPhone__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.SurvivorAndDependentInfo.Phone.@primaryPhone default null,
		"dependentalternatePhone__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.PostDischargeClaimInformation.SurvivorAndDependentInfo.Phone.@alternatePhone default null,
		"AlternateDestinationJustification__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.AlternateDestinationJustification default null		
}
	else
		null
		
fun buildVADbqCustomObjectPayload(xmlPayload, vaESRID) = 
	if(xmlPayload != null)
	{
		"VA_ESR__c": vaESRID default null,
		"name__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].DbqRequests[0].@name default null,
		"NarrativeEntry__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].DbqRequests[0].@title default null,
	}
	else
		null
		
fun buildVAContentionsCustomObjectPayload(xmlPayload, vaESRID) =
	if(xmlPayload != null)
	{
		"VA_ESR__c": vaESRID default null,
		"ExamPrioritizationSpecialIssues__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamPrioritizationSpecialIssues[0] default null,
		"ExamReworkRelatedContentionsUuid__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].@examReworkRelatedContentions default null,
		"contentionType__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].@contentionType default null,
		"dodReferred__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].@dodReferred default null,
		"Adjudicated__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].@adjudicated default null,
		"aceEligible__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].@aceEligible default null,
		"medicalOpinionNeeded__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].@medicalOpinionNeeded default null,
		"contentionName__c": if(xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ContentionName != null)
							 	xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ContentionName
							 else 
							 	null,
		"Classification_code__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].Classification.@code default null,
		"classificationName__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].Classification.@name default null,
		"examAppointmentUuid__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[1] default null,
		"examType__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExamAppointments[0].@examType default null,
		"modelVersion__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExamAppointments[0].ExamAppointmentStatusEvents[0].@modelVersion default null,
		"scheduledDateTime__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExamAppointments[0].ExamAppointmentStatusEvents[0].@scheduledDateTime default null,
		"emsPointOfContact__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExamAppointments[0].ExamAppointmentStatusEvents[0].@emsPointOfContact default null,
		"examName__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExamAppointments[0].ExamAppointmentStatusEvents[0].@examName default null,
		"examAppointmentUuid__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExamAppointments[0].ExamAppointmentStatusEvents[0].@examAppointmentUuid default null,
		"eventUuid__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExamAppointments[0].ExamAppointmentStatusEvents[0].@eventUuid default null,
		"UuidValue__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExamAppointments[0].ExamReworkRelatedContentionsUuidCollection[0] default null,
		"previousEventUuid__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExamAppointments[0].ExamAppointmentStatusEvents[0].@previousEventUuid default null,		
		"eventDtg__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExamAppointments[0].ExamAppointmentStatusEvents[0].@eventDtg default null,		 
		"modelVersion__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExamAppointments[0].ExamAppointmentStatusEvents[0].@modelVersion default null,
		"examSchedulingRequestUuid__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].@examSchedulingRequestUuid default null,
		"participatingSystemName__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExamAppointments[0].ExamAppointmentStatusEvents[0].EventSource.@participatingSystemName default null,
		"contractorName__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExamAppointments[0].ExamAppointmentStatusEvents[0].EventSource.@contractorName default null,
		//"ExamReworkRelatedContentionsUuid__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExamAppointments[0].ExamAppointmentStatusEvents[0].ExamReworkRelatedContentionsUuids.UuidValue[0] default null,
		"nameOfExaminer__c": xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExamAppointments[0].ExamAppointmentStatusEvents[0].nameOfExaminer.FirstName default null,
		"DisabilityName__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExistingDisabilities[0].@name default null,
		"DisabilityPercentage__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExistingDisabilities[0].@percentage default null,
		"DisabilityDiagnosticCode__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExistingDisabilities[0].@diagnosticCode default null,
		"DisabilityBilateralIndicator__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ExistingDisabilities[0].@bilateralIndicator default null,
		"Title__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].ContentionNarrative[0].@title default null,
		"RemandSpecialistIndicator__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].RemandSpecialistIndicator default null,
		"Remand_Specialist_Type__c":xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0].RemandSpecialistType default null,
		
		"narrativeEntry__c": joinBy(xmlPayload.ExamManagementEventNotification.ReworkExamSchedulingRequestCreatedEvent.ExamReworkRelatedContentions[0]..StandardLanguageEntries, ";")
	}
	else
		null
