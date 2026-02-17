variable "log_bucket_name" {
  description = "Name of the S3 log bucket (must be globally unique)"
  type        = string
}

variable "tags" {
  description = "Common tags applied to resources"
  type        = map(string)
  default     = {}
}
