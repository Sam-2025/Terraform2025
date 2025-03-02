resource "aws_instance" "web_server" {
  ami           = var.image  # Amazon Linux 2 AMI (Example)
  instance_type = var.machine_size
  key_name      = var.ssh_key
  subnet_id = var.subnt

  tags = {
    Name = var.tag
  }
}
