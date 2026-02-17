output "log_bucket_name" {
  description = "S3 log bucket name"
  value       = aws_s3_bucket.this.bucket
}

output "kms_key_arn" {
  description = "KMS key ARN used for bucket encryption"
  value       = aws_kms_key.this.arn
}
