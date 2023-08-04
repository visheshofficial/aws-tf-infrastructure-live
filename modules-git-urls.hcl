locals {

  github_cloudposse_base = "git::https://github.com/cloudposse"
  github_cloudposse_urls = {
    vpc = "${local.github_cloudposse_base}/terraform-aws-vpc.git?ref=2.1.0"
  }
#  github_cloudposse_urls = "git::https://github.com/cloudposse/terraform-aws-vpc.git?ref=2.1.0"

}