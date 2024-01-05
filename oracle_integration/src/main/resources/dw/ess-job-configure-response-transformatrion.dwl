%dw 2.0
output application/json
---
{
  "ess-job-id": 
payload.parts[0].content.Envelope.Body.submitESSJobRequestResponse.result
  }