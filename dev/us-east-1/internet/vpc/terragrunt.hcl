
include "root" {
  path   = find_in_parent_folders("base-terragrunt.hcl")
  expose = true
}


include "vpc" {
  path           = format("%s/_envcommon/resource-template/vpc.hcl", dirname(find_in_parent_folders("base-terragrunt.hcl")))
  expose         = true
  merge_strategy = "deep"
}
