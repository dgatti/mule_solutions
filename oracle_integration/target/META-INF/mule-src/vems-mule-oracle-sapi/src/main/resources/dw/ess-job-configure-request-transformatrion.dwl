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
            "typ:submitESSJobRequest":{
            	"typ:jobPackageName": "oracle/apps/ess/financials/commonModules/shared/common/interfaceLoader",
            	"typ:jobDefinitionName": "InterfaceLoaderController",
            	"typ:paramList":"1",
            	"typ:paramList":"1",
            	"typ:paramList":payload.contentId,
            	"typ:paramList":"N",
            	"typ:paramList":"N"
            	
            }
        }
		
	}
}