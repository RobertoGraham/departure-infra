provider "heroku" {
  version = "~> 2.4.0"
}

terraform {
  backend "pg" {
    schema_name = "departure_app_terraform_remote_state"
  }
}

data "terraform_remote_state" "departure_api" {
  backend   = "pg"
  workspace = "default"
  config = {
    schema_name = "departure_api_terraform_remote_state"
    conn_str    = var.database_url
  }
}

module "application" {
  source           = "../../modules/application"
  application_name = "departure-app"
  custom_domain    = var.departure_app_domain
  configuration_variables = {
    DEPARTURE_API_URL = trimsuffix(data.terraform_remote_state.departure_api.outputs.departure_api_url, "/")
  }
  commit_hash = var.departure_app_commit_hash
}