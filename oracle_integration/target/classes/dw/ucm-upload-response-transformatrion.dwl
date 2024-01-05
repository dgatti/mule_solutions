%dw 2.0
output application/json
---
{
  "contentId": 
payload.parts[0].content.Envelope.Body.uploadFileToUcmResponse.result
  }