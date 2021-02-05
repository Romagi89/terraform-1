output "my_vpc" {
  value = aws_vpc.myvpc.id
}
output "public_subnet" {
 value = aws_subnet.my_subnet.id
}
