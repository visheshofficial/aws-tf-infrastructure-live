locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  aws_account_name   = local.account_vars.locals.aws_account_name
  aws_account_id     = local.account_vars.locals.aws_account_id
  # Fetch AWS Mandatory tags map
  account_tags       = try(local.account_vars.locals.aws_mandatory_tags, {})
  region_tags        = try(local.region_vars.locals.aws_mandatory_tags, {})
  aws_mandatory_tags = merge(local.account_tags, local.region_tags)
}

 Generate terraform provider file
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
      provider "aws" {
      region              = "${local.region_vars.locals.aws_region}"
      allowed_account_ids = ["${local.account_vars.locals.aws_account_id}"]
    }
  EOF
}

# All terraform state files will be sored in a S3 backend
# https://terragrunt.gruntwork.io/docs/features/keep-your-remote-state-configuration-dry/#s3-specific-remote-state-settings
remote_state {
  backend = "s3"
  config  = {
    encrypt             = true
    bucket              = "${lower(local.aws_account_name)}-aws-terraform-state"
    key                 = "${path_relative_to_include()}/terraform.tfstate"
    region              = "us-east-1"
    dynamodb_table      = "${lower(local.aws_account_name)}-aws-terraform-locks"
    s3_bucket_tags      = "${local.aws_mandatory_tags}"
    dynamodb_table_tags = "${local.aws_mandatory_tags}"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

