variable "database_url" {
  type        = string
  description = "URL of the departure-api PG backend"
}

variable "departure_app_domain" {
  type        = string
  description = "Domain to accept traffic from"
}

variable "departure_app_commit_hash" {
  type        = string
  description = "Commit hash of the departure-app change to deploy"
}