variable "image" {
  type = string
  default = "ami-0d682f26195e9ec0f"
}
variable "key" {
  type = string
  default = "samkey"
}
variable "instance_type" {
  type = string
  default = "t2.micro"
}
variable "Name-ec2" {
  type = string
  default = "module-server"
}