terraform {
  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 3.2.0"
    }
  }
  required_version = ">= 0.13"
  backend "pg" {
    schema_name = "departure_app_terraform_remote_state"
  }
}

data "heroku_app" "departure-api" {
  name = "departure-api"
}

module "application" {
  source   = "../../modules/application"
  name     = "departure-app"
  hostname = var.departure_app_domain
  config_vars = {
    DEPARTURE_API_URL = trimsuffix(data.heroku_app.departure-api.web_url, "/")
  }
  commit_hash = var.departure_app_commit_hash
  acm         = true
  size        = "hobby"
}