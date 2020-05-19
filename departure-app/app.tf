resource "heroku_app" "departure-app" {
  name   = var.departure_app_name
  region = "eu"
  stack  = "container"
  acm    = true
  config_vars = {
    DEPARTURE_API_URL = trimsuffix(data.terraform_remote_state.departure_api.outputs.departure_api_url, "/")
  }
}