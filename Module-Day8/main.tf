resource "aws_instance" "signal2025" {
    ami = var.image
    key_name = var.key
    instance_type = var.instance_type
    tags = {
        Name = var.Name-ec2
    }
}
