resource "heroku_domain" "departure-app" {
  app      = heroku_app.departure-app.name
  hostname = var.departure_app_domain
}