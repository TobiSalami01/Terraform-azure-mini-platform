variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "unique_suffix" {
  type        = string
  description = "Used to make globally unique names."
}

variable "enable_app_service" {
  type        = bool
  description = "Create App Service Plan + Web App. Off by default for free/trial subscriptions."
  default     = false
}
