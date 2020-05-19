output "departure_api_url" {
  value       = heroku_app.departure-api.web_url
  description = "URL of the departure-api Heroku app"
}