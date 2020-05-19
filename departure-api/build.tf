resource "heroku_build" "departure-api" {
  app = heroku_app.departure-api.name
  source = {
    version = var.departure_api_commit_hash
    url     = "https://github.com/RobertoGraham/departure-api/archive/${var.departure_api_commit_hash}.tar.gz"
  }
}