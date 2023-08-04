locals {

  aws_account_id       = "337941034038"
  aws_region           = "us-east-1"
  aws_account_workload = basename(get_terragrunt_dir())
  aws_account_prefix   = "tls"
  aws_account_name   = "tls-dev"



  # Account Tags
  aws_mandatory_tags = {
    "Project"     = "TheLandScape"
    "Environment" = "Dev"
  }


}
