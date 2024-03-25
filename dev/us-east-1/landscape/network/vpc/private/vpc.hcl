locals {

  tenant_vars  = read_terragrunt_config(find_in_parent_folders("tenant.hcl"))
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  tenant_name  = local.tenant_vars.locals.tenant_name
  region_name  = local.region_vars.locals.aws_region_name
  account = local.account_vars.locals.aws_account_name
  root_dir = dirname(find_in_parent_folders("root.hcl"))

  namings=yamldecode(templatefile("${local.root_dir}/namings.tpl.yaml", {
    environment = "env1"
    service_name = "ser1"
  }))

}

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "vpc" {
  path           = format("%s/_envcommon/resource-template/_vpc.hcl", dirname(find_in_parent_folders("root.hcl")))
  expose         = true
  merge_strategy = "deep"
}


inputs = {
  name =  "${local.namings.prefixes.vpc}${local.namings.separators.all}${local.namings.suffixes.vpc}"
  ipv4_primary_cidr_block = "10.22.0.0/16"
  internet_gateway_enabled = "false"
}


