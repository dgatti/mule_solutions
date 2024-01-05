%dw 2.0

	
fun buildVAPeriodOfServiceCustomObjectPayload(payload) =
	if(payload != null)
	{
		"VA_Inbound_Request__c": payload.VA_Inbound_Request,
		"Branch_Of_Service__c": payload.Branch_Of_Service,
		"Entry_On_Duty__c": payload.Entry_On_Duty,
		"Rad_Date__c": payload.Rad_Date,
		"Conflict_Era__c": payload.Conflict_Era,
		"Era__c": payload.Era
	}
	else
		null

fun buildVAESRCustomObjectPayload(payload) =
	payload mapObject ((value, key) -> {
		("$(key)__c": if (key as String == "Birthdate") value as Date {format: "yyyy-MM-dd"} else value)
	})
		
fun buildVAContentionsCustomObjectPayload(payload) =
	payload mapObject ((value, key) -> {
		("$(key)__c": value)
	})
