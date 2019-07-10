provider "heroku" {
  version = "~> 2.0.1"
}

terraform {
  backend "pg" {
  }
}

variable "client_app_name" {
  description = "Name of the Heroku app provisioned for bus-api-client"
}

variable "server_app_name" {
  description = "Name of the Heroku app provisioned for bus-api-server"
}

variable "transport_api_app_id" {
  description = "Transport API Application ID"
}

variable "transport_api_app_key" {
  description = "Transport API Application Key"
}

variable "client_build_number" {
  description = "Build number of bus-api-client to deploy"
}

variable "server_build_number" {
  description = "Build number of bus-api-server to deploy"
}

resource "heroku_app" "bus-api-client" {
  name   = var.client_app_name
  region = "eu"
  stack  = "container"
  config_vars = {
    BUS_API_URL = "https://${var.server_app_name}.herokuapp.com"
  }
}

resource "heroku_app" "bus-api-server" {
  name   = var.server_app_name
  region = "eu"
  stack  = "container"
  sensitive_config_vars = {
    TRANSPORT_API_CLIENT_APPLICATION_KEY = var.transport_api_app_key
    TRANSPORT_API_CLIENT_APPLICATION_ID  = var.transport_api_app_id
  }
}

resource "heroku_build" "bus-api-client" {
  app = heroku_app.bus-api-client.name
  source = {
    url     = "https://bitbucket.org/robertograham/bus-api-client/get/${var.client_build_number}.tar.gz"
    version = var.client_build_number
  }
}

resource "heroku_build" "bus-api-server" {
  app = heroku_app.bus-api-server.name
  source = {
    url     = "https://bitbucket.org/robertograham/bus-api/get/${var.server_build_number}.tar.gz"
    version = var.server_build_number
  }
}

resource "heroku_formation" "bus-api-server" {
  app        = heroku_app.bus-api-server.name
  type       = "web"
  quantity   = 1
  size       = "hobby"
  depends_on = [heroku_build.bus-api-server]
}

resource "heroku_formation" "bus-api-client" {
  app      = heroku_app.bus-api-client.name
  type     = "web"
  quantity = 1
  size     = "free"
  depends_on = [
    heroku_build.bus-api-client,
    heroku_formation.bus-api-server,
  ]
}

output "client_app_url" {
  value = "https://${heroku_app.bus-api-client.name}.herokuapp.com"
}