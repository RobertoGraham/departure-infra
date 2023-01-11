resource "heroku_app" "application" {
  name                  = var.name
  region                = "eu"
  stack                 = "container"
  acm                   = var.acm
  config_vars           = var.config_vars != null ? var.config_vars : null
  sensitive_config_vars = var.sensitive_config_vars != null ? var.sensitive_config_vars : null
}

resource "heroku_build" "application" {
  app_id = heroku_app.application.id
  source {
    version = var.commit_hash
    url     = "https://github.com/RobertoGraham/${var.name}/archive/${var.commit_hash}.tar.gz"
  }
}

resource "heroku_domain" "application" {
  count    = var.hostname != null ? 1 : 0
  app_id      = heroku_app.application.id
  hostname = var.hostname
  depends_on = [heroku_formation.application]
}

resource "heroku_formation" "application" {
  app_id        = heroku_app.application.id
  type       = "web"
  quantity   = 1
  size       = var.size
  depends_on = [heroku_build.application]
}