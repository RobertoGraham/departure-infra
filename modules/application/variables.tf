variable "name" {
  type        = string
  description = "Subdomain of herokuapp.com"
}

variable "hostname" {
  type        = string
  default     = null
  description = "Domain to accept traffic from"
}

variable "config_vars" {
  type        = map(string)
  default     = null
  description = "Application environment variables"
}

variable "sensitive_config_vars" {
  type        = map(string)
  default     = null
  description = "Application secret environment variables"
}

variable "commit_hash" {
  type        = string
  description = "Commit hash of the change to deploy"
}

variable "acm" {
  type    = bool
  default = false
}

variable "size" {
  type    = string
  default = "eco"
}