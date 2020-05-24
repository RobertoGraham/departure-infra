provider "heroku" {
  version = "~> 2.4.0"
}

terraform {
  backend "pg" {
    schema_name = "departure_app_terraform_remote_state"
  }
}

data "heroku_app" "departure-api" {
  name = "departure-api"
}

module "application" {
  source           = "../../modules/application"
  application_name = "departure-app"
  custom_domain    = var.departure_app_domain
  configuration_variables = {
    DEPARTURE_API_URL = trimsuffix(data.heroku_app.departure-api.web_url, "/")
  }
  commit_hash = var.departure_app_commit_hash
}