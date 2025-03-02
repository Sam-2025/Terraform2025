provider "aws" {
  
}
resource "aws_instance" "name" {
  ami = "ami-0ddfba243cbee3768" 
  instance_type = "t2.micro"
  availability_zone = "ap-south-1a"
  key_name = "samkey"
  tags = {
    Name = "munaf"
  }
      lifecycle {
  ignore_changes = [tags]
}
    
  
  }
  
  
  