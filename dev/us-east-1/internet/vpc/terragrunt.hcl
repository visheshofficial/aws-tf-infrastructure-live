#include "root" {
#  path = find_in_parent_folders()
#}

include "vpc" {
  path           = format("%s/_envcommon/resource-template/vpc.hcl", dirname(find_in_parent_folders()))
  expose         = true
  merge_strategy = "deep"
}
