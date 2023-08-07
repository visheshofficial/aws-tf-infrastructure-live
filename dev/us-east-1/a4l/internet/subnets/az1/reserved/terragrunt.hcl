locals {
  tenant_vars   = read_terragrunt_config(find_in_parent_folders("tenant.hcl"))
  region_vars   = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account_vars  = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  workload_vars = read_terragrunt_config(find_in_parent_folders("workload.hcl"))

  tenant             = local.tenant_vars.locals.tenant_name
  region             = local.region_vars.locals.aws_region_name
  account            = local.account_vars.locals.aws_account_name
  workload           = local.workload_vars.locals.workload_type
  subnet_cidr_blocks = local.workload_vars.locals.subnet_cidr_blocks

  subnet_name = format("%s-%s-%s-%s", local.account, local.region, local.workload, local.tenant)
}

include "root" {
  path   = find_in_parent_folders("base-terragrunt.hcl")
  expose = true
}

include "subnet" {
  path           = format("%s/_envcommon/resource-template/subnet.hcl", dirname(find_in_parent_folders("base-terragrunt.hcl")))
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  ipv4_cidrs = [
    {
      private = [
        local.subnet_cidr_blocks.az1.reserved,
        local.subnet_cidr_blocks.az2.reserved,
        local.subnet_cidr_blocks.az3.reserved,
      ],
      public = [],
    }
  ]
  public_subnets_enabled = false
  subnets_per_az_count   = 1
  nat_gateway_enabled    = false
  nat_instance_enabled   = false
  availability_zone_ids  = [
    local.workload_vars.locals.subnet_cidr_blocks.az1.az_id,
    local.workload_vars.locals.subnet_cidr_blocks.az2.az_id,
    local.workload_vars.locals.subnet_cidr_blocks.az3.az_id,
  ]
  subnets_per_az_names = ["reserved"]
  private_label        = "reserved"
  #  ipv4_enabled
  #  ipv6_enabled
}


