

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
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

#    accesslogging_bucket_name   = "${lower(local.aws_account_name)}-terraform-state"
#    accesslogging_target_prefix = "self-access-logs"

  }
}

