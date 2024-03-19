locals {
  tenant_name = basename(get_terragrunt_dir())

  aws_mandatory_tags = {
    "TENANT_NAME" = local.tenant_name
  }
}