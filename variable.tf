# provider
variable "aws_region" {
  default = "ap-northeast-1"
}

# billing alert
variable "billing_count" {
  default = 3
}

variable "billing_threshold" {
  default {
    "0" = 1
    "1" = 5
    "2" = 15
  }
}
