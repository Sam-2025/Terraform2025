terraform {
  backend "s3" {
    bucket ="starabdul"
    key    ="terraform.tfstate"
    region = "ap-south-1"
  }
}
