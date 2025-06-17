# SNS Topic for API invocation alerts
resource "aws_sns_topic" "api_invocation_alerts" {
  name = "${local.name_prefix}-api-invocation-info-alerts"
}

# SNS Topic Subscription for email
resource "aws_sns_topic_subscription" "api_alerts_email" {
  topic_arn = aws_sns_topic.api_invocation_alerts.arn
  protocol  = "email"
  endpoint  = "sampleemail@example.com"  # Replace with your actual email
}