resource "aws_s3_bucket" "app_storage" {
  bucket = var.bucket_id
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.app_storage.id

  rule {
    object_ownership = var.ownobject
  }
}

resource "aws_s3_bucket_acl" "sample" {
  bucket = aws_s3_bucket.app_storage.id
  acl    = var.acl_list

  depends_on = [aws_s3_bucket_ownership_controls.ownership]
}
