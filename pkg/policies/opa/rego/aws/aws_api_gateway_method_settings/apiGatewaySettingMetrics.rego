package accurics

apiGatewaySettingMetrics[retVal] 
{
	api := input.aws_api_gateway_method_settings[_]
	some i
	data:=api.config.settings[i]
    data.metrics_enabled == false
    
    traverse = sprintf("settings[%d].metrics_enabled",[i])
    retVal := { "Id": api.id, "ReplaceType": "edit", "CodeType": "attribute", "Traverse": traverse, "Attribute": "settings.metrics_enabled", "AttributeDataType": "bool", "Expected": true, "Actual": data.metrics_enabled }

}