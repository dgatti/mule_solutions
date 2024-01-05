%dw 2.0

fun convertS3DocumentSapiToS3DocumentCustomObject(payload) =
	if(payload != null)
	{
		"ContentVersionId__c": payload.contentVersionId,
		//"VA_Inbound_Request__c": payload.vaInboundRequest,
		"Document_URL__c": payload.documentURL
		//"ESR__c":	payload.esr,	
		//"VA_Outbound_Request__c": payload.vaOutboundRequest,
		//"Event_Type__c": payload.eventType,
		//"Document_Size_Bytes__c": payload.documentSize
	}
	else
		null
