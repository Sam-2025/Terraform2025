provider "aws" {
 
}

module "server_instance" {
  source         = "./Module-/EC2"
  machine_size   = "t2.micro"
  ssh_key        = "samkey"
  image          = "ami-0d682f26195e9ec0f"
  subnt          = "subnet-07282fa9802d2992e"
  tag            = "Module"
}

module "data_storage" {
  source      = "./Module-/S3"
  bucket_id   = "mybuckmy2025"
  acl_list = "private"
  ownobject = "ObjectWriter"

}
