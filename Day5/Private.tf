resource "aws_eip" "private" {
     domain = "vpc"
     tags = {
       Name = "elastic_ip"
     }
  
}
resource "aws_nat_gateway" "private" {
       subnet_id = aws_subnet.cust.id
       allocation_id = aws_eip.private.id 
       tags = {
         Name = "my-natgw"
     }
}
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.cust.id
    cidr_block = "10.0.1.128/28"
    availability_zone = "ap-south-1c"
    tags = {
      Name = "private-subnet"
    }

}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.cust.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.private.id
  }

  tags = {
    Name = "NatRT"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_instance" "private" {
  ami             = "ami-0ddfba243cbee3768"
  key_name        = "samkey"
  subnet_id       = aws_subnet.private.id
  availability_zone = "ap-south-1c"
  instance_type   = "t3.micro"
}
