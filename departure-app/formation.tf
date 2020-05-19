resource "heroku_formation" "departure-app" {
  app        = heroku_app.departure-app.name
  type       = "web"
  quantity   = 1
  size       = "hobby"
  depends_on = [heroku_build.departure-app]
}
