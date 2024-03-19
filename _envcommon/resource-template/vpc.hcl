locals {
  catalog = read_terragrunt_config(find_in_parent_folders("catalog.hcl"))
  module_url       = local.catalog.locals.github_cloudposse_urls.vpc
}

terraform {
  source = "${local.module_url}"
}

