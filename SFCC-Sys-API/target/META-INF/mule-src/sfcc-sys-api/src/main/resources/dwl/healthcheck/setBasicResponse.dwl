%dw 2.0
output application/json
---
{
	timestamp: now(),
	status: if(vars.httpStatus != 500) "healthy" else "degraded",
	details: {
		appName: app.name,
		(error: {
			description: vars.error.description
		}) if (vars.error != null)
	}
}
