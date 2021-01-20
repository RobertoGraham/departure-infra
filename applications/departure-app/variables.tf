variable "departure_app_domain" {
  type        = string
  description = "Domain to accept traffic from"
  sensitive   = true
}

variable "departure_app_commit_hash" {
  type        = string
  description = "Commit hash of the departure-app change to deploy"
}