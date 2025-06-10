resource "local_file" "send_requests_script" {
  content  = templatefile("${path.module}/send_requests.sh.tpl", {
    invoke_url = "https://${aws_apigatewayv2_domain_name.api.domain_name}"
  })
  filename = "${path.module}/send_requests.sh"
  file_permission = "0755"
}