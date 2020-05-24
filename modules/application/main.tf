resource "heroku_app" "application" {
  name                  = var.application_name
  region                = "eu"
  stack                 = "container"
  acm                   = var.custom_domain != null ? true : null
  config_vars           = var.configuration_variables != null ? var.configuration_variables : null
  sensitive_config_vars = var.secret_configuration_variables != null ? var.secret_configuration_variables : null
}

resource "heroku_build" "application" {
  app = heroku_app.application.name
  source = {
    version = var.commit_hash
    url     = "https://github.com/RobertoGraham/${var.application_name}/archive/${var.commit_hash}.tar.gz"
  }
}

resource "heroku_domain" "application" {
  count    = var.custom_domain != null ? 1 : 0
  app      = heroku_app.application.name
  hostname = var.custom_domain
}

resource "heroku_formation" "departure-app" {
  app      = heroku_app.application.name
  type     = "web"
  quantity = 1
  size     = var.custom_domain != null ? "hobby" : "free"
  depends_on = [
  heroku_build.application]
}