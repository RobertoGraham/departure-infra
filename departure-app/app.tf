resource "heroku_app" "departure-app" {
  name   = var.departure_app_name
  region = "eu"
  stack  = "container"
  acm    = true
  config_vars = {
    DEPARTURE_API_URL = data.terraform_remote_state.departure_api.departure_api_url
  }
}