resource "aws_instance" "name" {
  ami = var.ami_Id
  instance_type = var.instance_type
  key_name = var.key
}