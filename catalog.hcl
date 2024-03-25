locals {
  tf_aws_communmity= "git::https://github.com/terraform-aws-modules"
  tf_aws_communmity_modules = {
    vpc = "${local.tf_aws_communmity}/terraform-aws-vpc.git"
  }
}