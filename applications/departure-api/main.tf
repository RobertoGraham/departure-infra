provider "heroku" {
  version = "~> 2.4.0"
}

terraform {
  backend "pg" {
    schema_name = "departure_api_terraform_remote_state"
  }
}

module "application" {
  source           = "../../modules/application"
  application_name = "departure-api"
  secret_configuration_variables = {
    TRANSPORT_API_CLIENT_APPLICATION_KEY = var.transport_api_app_key
    TRANSPORT_API_CLIENT_APPLICATION_ID  = var.transport_api_app_id
  }
  commit_hash = var.departure_api_commit_hash
}