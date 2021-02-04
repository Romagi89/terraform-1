resource "aws_s3_bucket" "bucket" {
  bucket = "arav-bucket"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.bucket.id
  key    = "index.html"
  source = "html/index.html"
  acl    = "public-read"
  content_type = "text/html"
}