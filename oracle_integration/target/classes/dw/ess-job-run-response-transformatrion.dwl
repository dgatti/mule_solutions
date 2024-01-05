%dw 2.0
output application/json
---
{
  "result": 
payload.parts[0].content.Envelope.Body.submitESSJobRequestResponse.result
  }