resource "aws_cloudfront_distribution" "cloudfront-blog-youyo-info" {
  #
  enabled             = true
  is_ipv6_enabled     = true
  comment             = ""
  default_root_object = ""
  http_version        = "http2"
  aliases             = ["blog.youyo.info"]
  price_class         = "PriceClass_All"

  # origin
  origin {
    domain_name = "nonssl.global.fastly.net"
    origin_id   = "Custom-nonssl.global.fastly.net"

    custom_header = [
      {
        name  = "X-Forwarded-Proto"
        value = "https"
      },
    ]

    custom_origin_config = [
      {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols   = ["TLSv1.2", "TLSv1.1", "TLSv1"]
      },
    ]
  }

  # ssl
  viewer_certificate {
    acm_certificate_arn      = "${data.aws_acm_certificate.ssl-youyo-info.arn}"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }

  # log
  logging_config {
    include_cookies = false
    bucket          = "${aws_s3_bucket.aws-blog-youyo-info-logs.bucket_domain_name}"
    prefix          = "logs/cloudfront/"
  }

  # behavior
  default_cache_behavior {
    allowed_methods  = ["HEAD", "GET"]
    cached_methods   = ["HEAD", "GET"]
    compress         = true
    target_origin_id = "Custom-nonssl.global.fastly.net"

    forwarded_values {
      query_string = false
      headers      = ["CloudFront-Forwarded-Proto", "Host", "Origin"]

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 60
    max_ttl                = 60
  }

  # Restrictions
  restrictions = {
    geo_restriction {
      restriction_type = "none"
    }
  }
}
