resource "heroku_build" "departure-app" {
  app = heroku_app.departure-app.name
  source = {
    version = var.departure_app_commit_hash
    url     = "https://github.com/RobertoGraham/departure-app/archive/${var.departure_app_commit_hash}.tar.gz"
  }
}