variable "name" {
  description = "Prefix/name for resources"
  type        = string
}

variable "tags" {
  description = "Common tags applied to resources"
  type        = map(string)
  default     = {}
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "List of AZs to deploy into (e.g., [\"us-east-1a\",\"us-east-1b\"])"
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
  description = "Whether to create NAT gateways (one per AZ)"
  type        = bool
  default     = true
}

variable "enable_vpc_flow_logs" {
  description = "Enable VPC flow logs to CloudWatch"
  type        = bool
  default     = true
}

variable "flow_logs_retention_days" {
  description = "Retention period in days for flow log group"
  type        = number
  default     = 30
}
