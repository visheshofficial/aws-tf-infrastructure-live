locals {
  catalog = read_terragrunt_config(find_in_parent_folders("catalog.hcl"))
  module_url       = local.catalog.locals.tf_aws_communmity_modules.vpc
  module_version   =  "v5.6.0" 
}

terraform {
  source = "${local.module_url}?ref=${local.module_version}"

  before_hook "echo_started" {
    commands     = ["apply", "plan"]
    execute      = ["echo", "Running Terraform"]
  }
  after_hook "echo_finished" {
    commands     = ["apply", "plan"]
    execute      = ["echo", "Finished running Terraform"]
    run_on_error = true
  }
}
