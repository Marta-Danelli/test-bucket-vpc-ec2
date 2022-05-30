resource "aws_s3_bucket" "bucket" {
  bucket = "marta-bucket-test374658392"

  tags = {
    Name = "bucket_test"
  }
}

