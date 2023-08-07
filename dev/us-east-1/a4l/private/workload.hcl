locals {
  workload_type = basename(get_terragrunt_dir())
  cidr_block                             =  "10.16.0.0/16"
}