resource "heroku_app" "departure-api" {
  name   = var.departure_api_name
  region = "eu"
  stack  = "container"
  sensitive_config_vars = {
    TRANSPORT_API_CLIENT_APPLICATION_KEY = var.transport_api_app_key
    TRANSPORT_API_CLIENT_APPLICATION_ID  = var.transport_api_app_id
  }
}