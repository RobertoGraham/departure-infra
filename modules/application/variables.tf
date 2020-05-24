variable "application_name" {
  type        = string
  description = "Subdomain of herokuapp.com"
}

variable "custom_domain" {
  type        = string
  default     = null
  description = "Domain to accept traffic from"
}

variable "configuration_variables" {
  type        = map(string)
  default     = null
  description = "Application environment variables"
}

variable "secret_configuration_variables" {
  type        = map(string)
  default     = null
  description = "Application secret environment variables"
}

variable "commit_hash" {
  type        = string
  description = "Commit hash of the change to deploy"
}