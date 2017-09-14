terragrunt = {
  remote_state {
    backend = "s3"
    config {
      bucket     = "test12132134esq"
      key        = "${path_relative_to_include()}/terraform.tfstate"
      region     = "us-east-2"
      encrypt    = true
      lock_table = "my-lock-table"
    }
  }
}