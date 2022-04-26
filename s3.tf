resource "aws_s3_bucket" "bkt" {
  bucket = var.domain

  tags = {
    Name        = "Blog-bucket"
    Environment = "Prod"
    Owner       = "Lucas"
    App         = "blog"
    Description = "Used to host static website in S3"
  }
}

resource "aws_s3_bucket_acl" "pub-acl" {
  bucket = aws_s3_bucket.bkt.id
  acl    = "public-read"
}


resource "aws_s3_bucket_website_configuration" "s3_bkt_web_conf" {
  bucket = aws_s3_bucket.bkt.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
