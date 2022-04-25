terraform {
  required_version = ">= 0.12.2"

  backend "s3" {
    region         = "eu-north-1"
    bucket         = "tform-state-s3-lucas-state"
    key            = "terraform.tfstate"
    dynamodb_table = "tform-state-s3-lucas-state-lock"
    profile        = ""
    role_arn       = ""
    encrypt        = "true"
  }
}
