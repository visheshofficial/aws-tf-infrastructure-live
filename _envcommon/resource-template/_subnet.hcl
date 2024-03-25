locals {
  modules_git_urls = read_terragrunt_config(find_in_parent_folders("modules-git-urls.hcl"))
  module_url       = local.modules_git_urls.locals.github_cloudposse_urls.subnet
}

dependency "vpc" {
  config_path                             = format("${get_original_terragrunt_dir()}/../../../vpc")
  mock_outputs_allowed_terraform_commands = ["validate", "show", "plan"]
  mock_outputs                            = {
    vpc_id = "vpc_id"
  }
}
terraform {
  source = "${local.module_url}"
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
}
