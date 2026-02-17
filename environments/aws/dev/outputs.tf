output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "log_bucket_name" {
  value = module.log_bucket.log_bucket_name
}

output "kms_key_arn" {
  value = module.log_bucket.kms_key_arn
}
