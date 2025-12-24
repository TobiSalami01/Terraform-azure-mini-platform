variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }

variable "storage_account_name" {
  type        = string
  description = "Globally unique, lowercase, 3-24 chars, letters/numbers only."
}

