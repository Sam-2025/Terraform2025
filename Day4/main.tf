resource "aws_instance" "name" {
  ami = "ami-0ddfba243cbee3768"
   instance_type = "t2.micro"
   key_name = "samkey"

   tags = {
     Name = "sample"

   }
}
resource "aws_s3_bucket" "National" {
    bucket = "starabdul"
  
}
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.National.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.National.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::starabdul/*"
    }
  ]
}
POLICY
}

resource "aws_s3_object" "public_object" {
  bucket = aws_s3_bucket.National.id
  key    = "terraform.tfstate"
  source = "terraform.tfstatem"

  acl    = "public-read"
}