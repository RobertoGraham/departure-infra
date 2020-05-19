resource "heroku_formation" "departure-api" {
  app        = heroku_app.departure-api.name
  type       = "web"
  quantity   = 1
  size       = "free"
  depends_on = [heroku_build.departure-api]
}