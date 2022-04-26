resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket_website_configuration.s3_bkt_web_conf.website_endpoint
    origin_id   = "myWebsiteS3"
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cert.arn
    ssl_support_method  = "sni-only"
  }


  aliases = ["cederqvist.dev"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "myWebsiteS3"

    cache_policy_id        = data.aws_cloudfront_cache_policy.policy.id
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 7200
    max_ttl                = 86400
  }

  ordered_cache_behavior {
    path_pattern     = "/posts/*"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "myWebsiteS3"

    cache_policy_id        = data.aws_cloudfront_cache_policy.policy.id
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 7200
    max_ttl                = 86400
  }
  ordered_cache_behavior {
    path_pattern     = "/tags/*"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "myWebsiteS3"

    cache_policy_id        = data.aws_cloudfront_cache_policy.policy.id
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 7200
    max_ttl                = 86400
  }

  price_class = "PriceClass_200"

  tags = {
    Name        = "Blog-bucket"
    Environment = "Prod"
    Owner       = "Lucas"
    App         = "blog"
    Description = "CDN for ${var.domain}"
  }

}

data "aws_cloudfront_cache_policy" "policy" {
  id = var.cache-optimized-policy
}
