%dw 2.0
fun buildExternalReportRequestBody(fromDate, toDate, reportAbsolutePath) = do {
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
                                "pub:name": "p_from_date",
                                "pub:values": {
                                    "pub:item": fromDate
                                }
                            },
                            "pub:item":{
                                "pub:name": "p_to_date",
                                "pub:values": {
                                    "pub:item": toDate
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
