variable "name" {
  type        = string
  description = "Base name prefix for network resources."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name to deploy network resources into."
}

variable "address_space" {
  type        = list(string)
  description = "VNet address space."
}

variable "subnets" {
  description = "Map of subnets to create."
  type = map(object({
    address_prefixes = list(string)
  }))
}
