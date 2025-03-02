
module "munaff" {
  source = "../Module-Day8"
  image = "ami-00bb6a80f01f03502"
  instance_type = "t2.micro"
  key = "samkey"
  Name-ec2 = "sample-server"
}