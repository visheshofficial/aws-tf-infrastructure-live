locals {

  aws_account_id       = "337941034038"
  aws_account_prefix   = "tls-dev"
  aws_account_name     = "tls-dev"



  # Account Tags
  aws_mandatory_tags = {
    "PROJECT"     = "TheLandScape"
    "ENVIRONMENT" = "dev"
  }


}
