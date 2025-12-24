locals {
  env      = "dev"
  project  = "azure-core"
  name     = "${local.env}-${local.project}"
  location = "eastus"
}

resource "azurerm_resource_group" "this" {
  name     = "${local.name}-rg"
  location = local.location
}

module "network" {
  source              = "../../modules/network"
  name                = local.name
  location            = local.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.10.0.0/16"]

  subnets = {
    app = {
      address_prefixes = ["10.10.1.0/24"]
    }
    private = {
      address_prefixes = ["10.10.2.0/24"]
    }
  }
}

module "monitoring" {
  source               = "../../modules/monitoring"
  name                 = local.name
  location             = local.location
  resource_group_name  = azurerm_resource_group.this.name
  storage_account_name = "devazurecorestgtobi01"
}
module "app" {
  source              = "../../modules/app"
  name                = local.name
  location            = local.location
  resource_group_name = azurerm_resource_group.this.name
  unique_suffix       = "tobi01"

  enable_app_service = false
}
module "static_site" {
  source               = "../../modules/static_site"
  storage_account_name = module.monitoring.storage_account_name
  resource_group_name  = azurerm_resource_group.this.name
}
# ----------------------------
# Outputs (PRINT VALUES)
# ----------------------------

output "vnet_name" {
  value = module.network.vnet_name
}

output "subnet_names" {
  value = module.network.subnet_names
}

output "subnet_ids" {
  value = module.network.subnet_ids
}

output "log_analytics_workspace_id" {
  value = module.monitoring.log_analytics_workspace_id
}

output "storage_account_name" {
  value = module.monitoring.storage_account_name
}
output "webapp_url" {
  value = module.app.webapp_url
}

output "webapp_name" {
  value = module.app.webapp_name
}

output "key_vault_name" {
  value = module.app.key_vault_name
}

output "static_site_url" {
  value = module.static_site.static_site_url
}