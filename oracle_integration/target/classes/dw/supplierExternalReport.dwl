%dw 2.0
import * from dw::core::Binaries
import * from dw::core::Strings

fun buildExternalReportBody(pubItemName, pubItemValue, reportAbsolutePath) = do {
    ns soap http://www.w3.org/2003/05/soap-envelope 
    ns pub http://xmlns.oracle.com/oxp/service/PublicReportService
    ---
    {
        soap#Envelope @('xmlns:pub': pub):{
            "soap:Header":{
            },
            "soap:Body":{
                "pub:runReport":{
                    "pub:reportRequest": {
                        "pub:parameterNameValues": {
                            "pub:item":{
                                "pub:name": pubItemName,
                                "pub:values": {
                                    "pub:item": pubItemValue
                                }
                            }
                        },
                        "pub:reportAbsolutePath": reportAbsolutePath,
                        "pub:sizeOfDataChunkDownload": "-1"
                    }
                }
            }
	    }
    }
}

fun convertBase64toXml(base64) = do {
    var xml = fromBase64(base64)
    ---
    read(xml, "application/xml")
}

fun convertXmlToJson(body) = do {
	body mapObject ((value, key) -> do {
        if ((value) is Object)
            (camelize(lower(key as String))): convertXmlToJson(value)
        else
            (camelize(lower(key as String))): value
    })
}

fun mapSupplierResponse(body) = do {
	fun getArrayFrom (thisElement) = if ( typeOf(thisElement) == Object ) [thisElement] else thisElement
	---
	{
	    pLegacyNo: body.pLegacyNo,
	    supplier: {
	        supplierId: body.supplier.supplierId,
	        supplierNumber: body.supplier.supplierNumber,
	        supplierName: body.supplier.supplierName,
	        supplierType: body.supplier.supplierType,
	        businessRelationship: body.supplier.businessRelationship,
	        taxpayerCountry: body.supplier.taxpayerCountry,
	        taxpayerId: body.supplier.taxpayerId,
	        taxReportingName: body.supplier.taxReportingName,
	        taxOrganizationType: body.supplier.taxOrganizationType,
	        supplierPartyId: body.supplier.supplierPartyId,
	        supplierAddress: (getArrayFrom(body.supplier.supplierAddress)) map ( supplierAddress , indexOfSupplierAddress ) -> {
	            supplierId: supplierAddress.supplierId,
	            addressName: supplierAddress.addressName,
	            addressLine1: supplierAddress.addressLine1,
	            city: supplierAddress.city,
	            state: supplierAddress.state,
	            country: supplierAddress.country,
	            postalCode: supplierAddress.postalCode,
	            emailAddress: supplierAddress.emailAddress,
	            phoneNumber: supplierAddress.phoneNumber,
	            addressPurposeOrdering: supplierAddress.addressPurposeOrdering,
	            addressPurposeRemitTo: supplierAddress.addressPurposeRemitTo,
	            supplierAddressId: supplierAddress.supplierAddressId
	        },
	        supplierContact: (getArrayFrom(body.supplier.supplierContact)) map ( supplierContact , indexOfSupplierContact ) -> {
	            supplierId: supplierContact.supplierId,
	            salutation: supplierContact.salutation,
	            firstName: supplierContact.firstName,
	            middleName: supplierContact.middleName,
	            lastName: supplierContact.lastName,
	            emailAddress: supplierContact.emailAddress,
	            phoneNumber: supplierContact.phoneNumber,
	            supplierContactId: supplierContact.supplierContactId,
	            contactAddress: (getArrayFrom(supplierContact.contactAddress)) map (supplierContactAddress, indexOfSupplierContactAddress) -> {
	                supplierContactId: supplierContactAddress.supplierContactId,
	                addressName: supplierContactAddress.addressName,
	                contactAddressId: supplierContactAddress.contactAddressId
	            }
	        },
	        supplierSite: (getArrayFrom(body.supplier.supplierSite)) map ( supplierSite , indexOfSupplierSite ) -> {
	            businessUnitName: supplierSite.procurementBu,
                addressName: supplierSite.addressName,
                paymentGroup: supplierSite.paymentGroup,
                sitepurposepayflag: supplierSite.sitepurposepayflag,
                sitepurposeprimarypayflag: supplierSite.sitepurposeprimarypayflag,
                taxreportingsiteflag: supplierSite.taxreportingsiteflag,
                siteName: supplierSite.siteName,
                supplierId: supplierSite.supplierId,
                supplierSiteId: supplierSite.supplierSiteId,
                procurementBU: supplierSite.procurementBu,
                siteAssignment: (getArrayFrom(supplierSite.siteAssignment)) map (siteAssignment, indexOfSiteAssignment) -> {
	                billToBu: siteAssignment.billToBu,
                    clientToBu: siteAssignment.clientToBu,
                    supplierId: siteAssignment.supplierId,
                    supplierSiteId: siteAssignment.supplierSiteId,
                    liabilitydistribution: siteAssignment.liabilitydistribution,
                    supplierSiteAsgId: siteAssignment.supplierSiteAsgId
	            },
                supplierPaymentMethod: (getArrayFrom(supplierSite.supplierPaymentMethod)) map (supplierPaymentMethod, indexOfSupplierPaymentMethod) -> {
	                paymentMethodCode: supplierPaymentMethod.paymentMethodCode,
                    fromDate: supplierPaymentMethod.fromDate,
                    toDate: supplierPaymentMethod.toDate,
                    primaryIndicator: supplierPaymentMethod.primaryIndicator,
                    supplierSiteId: supplierPaymentMethod.supplierSiteId,
                    extPaymentMethodId: supplierPaymentMethod.extPaymentMethodId,
                    extPayeeId: supplierPaymentMethod.extPayeeId
	            },
                externalBankAccount: (getArrayFrom(supplierSite.externalBankAccount)) map (externalBankAccount, indexOfExternalBankAccount) -> {
	                supplierSiteId: externalBankAccount.supplierSiteId,
                    bankAccountNum: externalBankAccount.bankAccountNum,
                    bankName: externalBankAccount.bankName,
                    branchName: externalBankAccount.branchName,
                    maskedIban: externalBankAccount.maskedIban,
                    countryCode: externalBankAccount.countryCode,
                    foreignPaymentUseFlag: externalBankAccount.foreignPaymentUseFlag,
                    extBankAccountId: externalBankAccount.extBankAccountId,
                    allowInternationsPaymentIndicator: externalBankAccount.allowInternationsPaymentIndicator,
                    intent: externalBankAccount.intent,
                    paymentFlow: externalBankAccount.paymentFlow,
                    paymentInstrumentType: externalBankAccount.instrumentType
	            }
	        }
	    }
	}
}

