variable "default_region" {
  type = string
}

variable "acm-cert" {
  type = string
}

variable "domain" {
  type    = string
  default = "cederqvist.dev"
}

variable "cache-optimized-policy" {
  type    = string
  default = "658327ea-f89d-4fab-a63d-7e88639e58f6"
}
