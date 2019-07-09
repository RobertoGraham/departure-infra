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

resource "heroku_app" "bus-api-client" {
  name = "${var.client_app_name}"
  region = "eu"
  stack	= "container"
  config_vars = {
    BUS_API_URL = "https://${var.server_app_name}.herokuapp.com"
  }
}

resource "heroku_app" "bus-api-server" {
  name = "${var.server_app_name}"
  region = "eu"
  stack = "container"
  sensitive_config_vars = {
    TRANSPORT_API_CLIENT_APPLICATION_KEY = "4f329303f632579477c2e265d7be115b"
    TRANSPORT_API_CLIENT_APPLICATION_ID = "01044393"
  }
}

resource "heroku_build" "bus-api-client" {
  app = "${heroku_app.bus-api-client.name}"
  source = {
    url     = "https://bitbucket.org/robertograham/bus-api-client/get/6.tar.gz"
    version = "6"
  }
}

resource "heroku_build" "bus-api-server" {
  app = "${heroku_app.bus-api-server.name}"
  source = {
    url     = "https://bitbucket.org/robertograham/bus-api/get/7.tar.gz"
    version = "7"
  }
}

resource "heroku_formation" "bus-api-server" {
  app        = "${heroku_app.bus-api-server.name}"
  type       = "web"
  quantity   = 1
  size       = "hobby"
  depends_on = ["heroku_build.bus-api-server"]
}

resource "heroku_formation" "bus-api-client" {
  app        = "${heroku_app.bus-api-client.name}"
  type       = "web"
  quantity   = 1
  size       = "free"
  depends_on = ["heroku_build.bus-api-client","heroku_formation.bus-api-server"]
}

output "client_app_url" {
  value = "https://${heroku_app.bus-api-client.name}.herokuapp.com"
}
