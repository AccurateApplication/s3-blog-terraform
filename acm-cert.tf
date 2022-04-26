resource "aws_acm_certificate" "cert" {
  provider          = aws.east-1
  domain_name       = var.domain
  validation_method = "DNS"

  tags = {
    Environment = "Prod"
    Owner       = "Lucas"
    App         = "blog"
    Description = "Certificate for ${var.domain}"
  }

}
