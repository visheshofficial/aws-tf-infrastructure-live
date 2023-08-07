locals {

  tenant_vars  = read_terragrunt_config(find_in_parent_folders("tenant.hcl"))
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  workload_vars = read_terragrunt_config(find_in_parent_folders("workload.hcl"))

  tenant  = local.tenant_vars.locals.tenant_name
  region  = local.region_vars.locals.aws_region_name
  account = local.account_vars.locals.aws_account_name
  workload = local.workload_vars.locals.workload_type
  vpc_cidr_block = local.workload_vars.locals.vpc_cidr_block


  vpc_name = format("%s-%s-%s-%s", local.account, local.region,local.workload, local.tenant)

}


include "root" {
  path   = find_in_parent_folders("base-terragrunt.hcl")
  expose = true
}

include "vpc" {
  path           = format("%s/_envcommon/resource-template/vpc.hcl", dirname(find_in_parent_folders("base-terragrunt.hcl")))
  expose         = true
  merge_strategy = "deep"
}


inputs = {
  name = local.vpc_name
  ipv4_primary_cidr_block = local.vpc_cidr_block
  internet_gateway_enabled = "false"

##   default values from the module
#  instance_tenancy = "default"
#  assign_generated_ipv6_cidr_block = "true"
#  dns_hostnames_enabled = "true"
#  dns_support_enabled = "true"
#  default_route_table_no_routes = "false"
#  default_network_acl_deny_all =  "false"
#  internet_gateway_enabled = "true"
#  ipv6_egress_only_internet_gateway_enabled = "false"
}


