data "aws_route53_zone" "blog-youyo-info" {
  provider     = "aws.ailas_us_east_1"
  name         = "blog.youyo.info."
  private_zone = false
}

resource "aws_route53_record" "a-blog-youyo-info" {
  zone_id = "${data.aws_route53_zone.blog-youyo-info.zone_id}"
  name    = "${data.aws_route53_zone.blog-youyo-info.name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.cloudfront-blog-youyo-info.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.cloudfront-blog-youyo-info.hosted_zone_id}"
    evaluate_target_health = false
  }
}
