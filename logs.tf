# CloudWatch Log Group for API Gateway access logs
resource "aws_cloudwatch_log_group" "api_gateway_logs" {
  name              = "/aws/apigateway/${aws_apigatewayv2_api.http_api.name}"
  retention_in_days = 7
}

# CloudWatch Log Group for Lambda function logs
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${aws_lambda_function.http_api_lambda.function_name}"
  retention_in_days = 7
}

# CloudWatch Metric Filter to count [INFO] log entries
resource "aws_cloudwatch_log_metric_filter" "info_logs_filter" {
  name           = "${local.name_prefix}-info-logs-filter"
  pattern        = "[INFO]"
  log_group_name = aws_cloudwatch_log_group.lambda_logs.name

  metric_transformation {
    name      = "InfoLogCount"
    namespace = "ApiInvocations"
    value     = "1"
  }
}

# CloudWatch Alarm for high API invocation rate
resource "aws_cloudwatch_metric_alarm" "high_api_invocation" {
  alarm_name          = "${local.name_prefix}-high-api-invocation-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "InfoLogCount"
  namespace           = "ApiInvocations"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  alarm_description   = "This alarm monitors for more than 10 API invocations with [INFO] logs in a minute"
  alarm_actions       = [aws_sns_topic.api_invocation_alerts.arn]
}