variable "bucket_name" {
  description = "S3 bucket name for the static site (must be globally unique)"
  type        = string
}

variable "aws_region" {
  description = "AWS region for S3 bucket"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default = {
    Project     = "kode-with-greg"
    Environment = "production"
    ManagedBy   = "terraform"
  }
}
