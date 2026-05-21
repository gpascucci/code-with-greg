output "bucket_name" {
  description = "S3 bucket name — set as BUCKET_NAME GitHub Actions secret"
  value       = aws_s3_bucket.site.id
}

output "cloudfront_domain" {
  description = "CloudFront distribution domain name — use this URL to preview the site"
  value       = aws_cloudfront_distribution.site.domain_name
}

output "distribution_id" {
  description = "CloudFront distribution ID — set as DISTRIBUTION_ID GitHub Actions secret"
  value       = aws_cloudfront_distribution.site.id
}
