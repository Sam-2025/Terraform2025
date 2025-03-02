resource "aws_vpc" "cust" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "my-vpc"
    }
}
resource "aws_internet_gateway" "cust" {
     vpc_id = aws_vpc.cust.id
     tags = {
        Name = "my-igw"
     }
  
}
resource "aws_route_table" "cust" {
    vpc_id = aws_vpc.cust.id
      route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.cust.id 
     }
     tags = {
      Name = "My_RT"
    }
  
}
resource "aws_subnet" "cust" {
    vpc_id = aws_vpc.cust.id
     cidr_block = "10.0.0.0/25"
     availability_zone = "ap-south-1a"
     tags = {
       Name = "cust subnet"
       
     }
  
}
resource "aws_route_table_association" "cust" {
    subnet_id = aws_subnet.cust.id
    route_table_id = aws_route_table.cust.id
  
}
resource "aws_security_group" "cust" {
  vpc_id = aws_vpc.cust.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysg"
  }
}
resource "aws_instance" "cust" {
     ami = "ami-0ddfba243cbee3768"
     key_name = "samkey"
     instance_type = "t2.micro"
     subnet_id = aws_subnet.cust.id
     vpc_security_group_ids = [aws_security_group.cust.id]

}