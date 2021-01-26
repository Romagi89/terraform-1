output "publicip" {
  value = aws_instance.example.public_ip
}

output "public_dns_name" {
  value = aws_instance.example.public_dns
}