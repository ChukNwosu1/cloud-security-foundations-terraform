variable "aws_region" {
  description = "AWS region for dev environment"
  type        = string
}

variable "name" {
  description = "Name/prefix for this environment"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "azs" {
  description = "AZs to use"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Map of AZ => public subnet CIDR"
  type        = map(string)
}

variable "private_subnet_cidrs" {
  description = "Map of AZ => private subnet CIDR"
  type        = map(string)
}

variable "enable_nat_gateway" {
  description = "Create NAT gateways"
  type        = bool
  default     = true
}

variable "enable_vpc_flow_logs" {
  description = "Enable VPC flow logs"
  type        = bool
  default     = true
}

variable "flow_logs_retention_days" {
  description = "CloudWatch log retention for VPC flow logs"
  type        = number
  default     = 30
}

variable "log_bucket_name" {
  description = "S3 bucket name for logs (must be globally unique)"
  type        = string
}
