locals {
  modules_git_urls = read_terragrunt_config(find_in_parent_folders("modules-git-urls.hcl"))
  module_url       = local.modules_git_urls.locals.github_cloudposse_urls.vpc
}

terraform {
  source = "${local.module_url}"
}

inputs = {
  name = "tls-public-vpc"
}