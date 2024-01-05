%dw 2.0
output application/xml writeDeclaration=false
ns soapenv http://schemas.xmlsoap.org/soap/envelope/ 
ns erp http://xmlns.oracle.com/apps/financials/commonModules/shared/model/erpIntegrationService/
ns typ http://xmlns.oracle.com/apps/financials/commonModules/shared/model/erpIntegrationService/types/


---
{
	soapenv#Envelope @('xmlns:erp': erp, 'xmlns:typ': typ):{
        "soapenv:Header":{
        },
        "soapenv:Body":{
            "typ:uploadFileToUcm":{
                "typ:document":{
                    //Base64 format of the file to be passed in Content
                    "erp:Content": payload.content,
                    "erp:FileName": payload.fileName,
                    "erp:DocumentSecurityGroup": "FAFusionImportExport",
                    "erp:DocumentAccount": "fin\$/payables\$/import\$"
                }

            }
        }
		
	}
}