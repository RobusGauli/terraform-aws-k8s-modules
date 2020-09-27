output "cloudfront_domain" {
  description = "Domain name for the Generated Cloudfront Distribution"
  value       = aws_cloudfront_distribution.www_distribution.domain_name
}

output "bucket_name" {
  description = "Name of bucket where frontend web app is hosted"
  value       = module.s3.bucket_name
}
