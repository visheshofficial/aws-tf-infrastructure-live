locals {
  tenant_name = basename(get_terragrunt_dir())

  aws_mandatory_tags = {
    tenant_name = local.tenant_name
  }
}