output "public_dns" {
  #value = aws_instance.web[*].public_dns
  value = {
    for instance in aws_instance.web:
    instance.id => instance.private_ip
  }
}