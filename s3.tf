resource "aws_s3_bucket" "app_bucket" {
  bucket = "my-unique-bucket-name-${random_id.suffix.hex}"
  force_destroy = true

  tags = {
    Name = "App Bucket"
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket_versioning" "app_bucket_versioning" {
  bucket = aws_s3_bucket.app_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

