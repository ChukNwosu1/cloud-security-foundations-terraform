module "vpc" {
  source = "../../../modules/aws-vpc-secure"

  name                     = var.name
  tags                     = var.tags
  vpc_cidr                 = var.vpc_cidr
  azs                      = var.azs
  public_subnet_cidrs      = var.public_subnet_cidrs
  private_subnet_cidrs     = var.private_subnet_cidrs
  enable_nat_gateway       = var.enable_nat_gateway
  enable_vpc_flow_logs     = var.enable_vpc_flow_logs
  flow_logs_retention_days = var.flow_logs_retention_days
}

module "log_bucket" {
  source = "../../../modules/aws-kms-s3-encryption"

  log_bucket_name = var.log_bucket_name
  tags            = var.tags
}
