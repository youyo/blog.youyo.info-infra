data "aws_acm_certificate" "ssl-youyo-info" {
  provider = "aws.ailas_us_east_1"
  domain   = "*.youyo.info"
}
