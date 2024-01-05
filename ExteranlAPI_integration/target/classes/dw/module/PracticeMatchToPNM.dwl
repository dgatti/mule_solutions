fun selectPhoneNumber(phoneNumbers) = do {
    var workPhones = phoneNumbers filter ((phone) -> phone.PhoneType == "Work")
    ---
    if (isEmpty(workPhones)) (phoneNumbers[0].PhoneNumber default "") else workPhones[0].PhoneNumber
}

fun mapSpecialty(specialty) = do {
	var mappedSpecialty = Mule::p(specialty)
	---
	if (mappedSpecialty != null) (mappedSpecialty) else Mule::p("DefaultValue")
}