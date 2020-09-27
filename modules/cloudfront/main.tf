module "label" {
  source = "../label"

  namespace  = var.namespace
  stage      = var.stage
  delimiter  = var.delimiter
  attributes = var.attributes
  tags       = var.tags
}

module "s3" {
  source = "../../commons/s3-bucket"

  namespace     = module.label.namespace
  stage         = module.label.stage
  name          = module.label.name
  delimiter     = module.label.delimiter
  attributes    = module.label.attributes
  override      = true
  bucket_name   = var.bucket_name
  acl           = "public-read"
  region        = var.region
  tags          = module.label.tags
  force_destroy = true

  website = {
    index_document = "index.html"
    error_document = "index.html"
  }

  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"AddPerm",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${var.bucket_name}/*"]
    }
  ]
}
POLICY
}

resource "aws_cloudfront_distribution" "www_distribution" {
  // origin is where CloudFront gets its content from.
  origin {
    custom_origin_config {
      // These are all the defaults.
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    // Here we're using our S3 bucket's URL!
    domain_name = module.s3.website_endpoint
    // This can be any name to identify this origin.
    origin_id = var.cloudfront_origin_id
  }

  enabled             = true
  default_root_object = "index.html"

  // All values are defaults from the AWS console.
  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    // This needs to match the `origin_id` above.
    target_origin_id = var.cloudfront_origin_id
    min_ttl          = 0
    default_ttl      = 0
    max_ttl          = 0

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  aliases             = var.cloudfront_domain_aliases
  wait_for_deployment = false
  tags                = module.label.tags


  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  // 404 Handling
  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/"
  }

  // Here's where our certificate is loaded in!
  viewer_certificate {
    acm_certificate_arn = var.aws_acm_certificate_arn
    ssl_support_method  = "sni-only"
  }
}
