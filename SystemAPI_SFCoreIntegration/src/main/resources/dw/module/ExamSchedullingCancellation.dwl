%dw 2.0

fun buildExamRequestFaultEventXmlResponse(xmlPayload, error) =
	do {
		
		ns em http://va.gov/vler/schemas/vlerSupersetSchema/examManagement/4.3
		---
		if(xmlPayload != null)
		{	
			em#ExamManagementEventNotification:
				{
					em#OriginatingSystem @(participatingSystemName: xmlPayload.ExamManagementEventNotification.ExamSchedulingRequestCancellationEvent.EventSource.@participatingSystemName default null, 
											contractorName: xmlPayload.ExamManagementEventNotification.Destination.@contractorName default null): null,
					em#Destination @(participatingSystemName: xmlPayload.ExamManagementEventNotification.Destination.@participatingSystemName default null): null,
					em#RequestScopedFaultEvent @(eventDtg: xmlPayload.ExamManagementEventNotification.ExamSchedulingRequestCancellationEvent.@eventDtg default null,
						modelVersion: xmlPayload.ExamManagementEventNotification.ExamSchedulingRequestCancellationEvent.@modelVersion default null, 
						examSchedulingRequestUuid: xmlPayload.ExamManagementEventNotification.ExamSchedulingRequestCancellationEvent.@examSchedulingRequestUuid default null,
           				 previousEventUuid: xmlPayload.ExamManagementEventNotification.ExamSchedulingRequestCancellationEvent.@previousEventUuid default null,
           				 eventUuid: xmlPayload.ExamManagementEventNotification.ExamSchedulingRequestCancellationEvent.@eventUuid default null
					):{
						em:Details: error.description,
						em#EventSource @(participatingSystemName: xmlPayload.ExamManagementEventNotification.ExamSchedulingRequestCancellationEvent.EventSource.@participatingSystemName default null,
											contractorName: xmlPayload.ExamManagementEventNotification.Destination.@contractorName default null): null
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
					em#OriginatingSystem @(participatingSystemName: xmlPayload.ExamManagementEventNotification.ExamSchedulingRequestCancellationEvent.EventSource.@participatingSystemName default null, 
											contractorName: xmlPayload.ExamManagementEventNotification.Destination.@contractorName default null): null,
					em#Destination @(participatingSystemName: xmlPayload.ExamManagementEventNotification.Destination.@participatingSystemName default null): null,
					em#ExamRequestAcknowledgementEvent @(eventDtg: xmlPayload.ExamManagementEventNotification.ExamSchedulingRequestCreatedEvent.@eventDtg default null,
						modelVersion: xmlPayload.ExamManagementEventNotification.ExamSchedulingRequestCancellationEvent.@clinicianUniqueId default null, 
						examSchedulingRequestUuid: xmlPayload.ExamManagementEventNotification.ExamSchedulingRequestCancellationEvent.@examSchedulingRequestUuid default null,
           				 previousEventUuid: xmlPayload.ExamManagementEventNotification.ExamSchedulingRequestCancellationEvent.@previousEventUuid default null,
           				 eventUuid: xmlPayload.ExamManagementEventNotification.ExamSchedulingRequestCancellationEvent.@eventUuid default null
					):{
						em#EventSource @(participatingSystemName: xmlPayload.ExamManagementEventNotification.ExamSchedulingRequestCancellationEvent.EventSource.@participatingSystemName default null,
											contractorName:xmlPayload.ExamManagementEventNotification.Destination.@participatingSystemName default null): null
					}
				}
		}else
			null
	}
	