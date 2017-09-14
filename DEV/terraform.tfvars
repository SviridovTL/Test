terragrunt = {
  # Include all the settings from the root .tfvars file
  include {
    path = "${find_in_parent_folders()}"
  }

  # Apply the code in the frontend-app module
  terraform {
    source = "git::git@github.com:foo/modules.git//frontend-app?ref=v0.0.3"
  }
}