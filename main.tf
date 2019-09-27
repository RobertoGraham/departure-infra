provider "heroku" {
  version = "~> 2.2.0"
}

terraform {
  backend "pg" {
  }
}

variable "departure_app_name" {
  description = "Name of the Heroku app provisioned for departure-app"
}

variable "departure_api_name" {
  description = "Name of the Heroku app provisioned for departure-api"
}

variable "transport_api_app_id" {
  description = "Transport API Application ID"
}

variable "transport_api_app_key" {
  description = "Transport API Application Key"
}

variable "departure_app_commit_hash" {
  description = "Commit ref of departure-app to deploy"
}

variable "departure_api_commit_hash" {
  description = "Commit ref of departure-api to deploy"
}

resource "heroku_app" "departure-app" {
  name   = var.departure_app_name
  region = "eu"
  stack  = "container"
  config_vars = {
    DEPARTURE_API_URL = "https://${var.departure_api_name}.herokuapp.com"
  }
}

resource "heroku_app" "departure-api" {
  name   = var.departure_api_name
  region = "eu"
  stack  = "container"
  sensitive_config_vars = {
    TRANSPORT_API_CLIENT_APPLICATION_KEY = var.transport_api_app_key
    TRANSPORT_API_CLIENT_APPLICATION_ID  = var.transport_api_app_id
  }
}

resource "heroku_build" "departure-app" {
  app = heroku_app.departure-app.name
  source = {
    version = var.departure_app_commit_hash
    path = "./departure-app-${var.departure_app_commit_hash}.tar.gz"
  }
}

resource "heroku_build" "departure-api" {
  app = heroku_app.departure-api.name
  source = {
    version = var.departure_api_commit_hash
    path = "./departure-app-${var.departure_api_commit_hash}.tar.gz"
  }
}

resource "heroku_formation" "departure-api" {
  app        = heroku_app.departure-api.name
  type       = "web"
  quantity   = 1
  size       = "free"
  depends_on = [heroku_build.departure-api]
}

resource "heroku_formation" "departure-app" {
  app      = heroku_app.departure-app.name
  type     = "web"
  quantity = 1
  size     = "free"
  depends_on = [
    heroku_build.departure-app,
    heroku_formation.departure-api,
  ]
}

output "departure_app_url" {
  value = "https://${heroku_app.departure-app.name}.herokuapp.com"
}