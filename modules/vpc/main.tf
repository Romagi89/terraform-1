resource "aws_vpc" "myvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
enable_dns_support = true
enable_dns_hostnames = true
  tags = {
    Name = "myvpc"
  }
}
resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
 map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    Name = "my_subnet"
  }
}
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "myigw"
  }
}
resource "aws_route_table" "myroutetable" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
}
resource "aws_route_table_association" "subnet_as" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.myroutetable.id
}
