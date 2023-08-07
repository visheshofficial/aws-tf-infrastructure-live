locals {

  aws_account_id       = "337941034038"
  aws_account_prefix   = "tls-d"
  aws_account_name   = "tls-dev"



  # Account Tags
  aws_mandatory_tags = {
    "Project"     = "TheLandScape"
    "Environment" = "Dev"
  }


}
