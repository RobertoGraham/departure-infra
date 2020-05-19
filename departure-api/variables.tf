variable "departure_api_name" {
  type        = "string"
  description = "Name of the departure-api Heroku app"
}

variable "transport_api_app_id" {
  type        = "string"
  description = "Transport API Application ID"
}

variable "transport_api_app_key" {
  type        = "string"
  description = "Transport API Application Key"
}

variable "departure_api_commit_hash" {
  type        = "string"
  description = "Commit hash of the departure-api change to deploy"
}