variable "transport_api_app_id" {
  type        = string
  description = "Transport API Application ID"
  sensitive   = true
}

variable "transport_api_app_key" {
  type        = string
  description = "Transport API Application Key"
  sensitive   = true
}

variable "departure_api_commit_hash" {
  type        = string
  description = "Commit hash of the departure-api change to deploy"
}