output "url" {
  value       = heroku_app.application.web_url
  description = "URL of the Heroku app"
}