output "invoke_url" {
  value = trimsuffix(aws_apigatewayv2_stage.default.invoke_url, "/")
}

output "custom_domain_url" {
  value = "https://${aws_apigatewayv2_domain_name.api.domain_name}"
  description = "Custom domain URL for the API"
}
