output "public_dns-us-east-1" { 
  value = aws_instance.web.public_dns
}
output "public_dns-es-west-2" {
  value = aws_instance.web_west.public_dns 
}