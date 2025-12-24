data "azurerm_client_config" "current" {}

locals {
  webapp_name = "${var.name}-${var.unique_suffix}-web"
  plan_name   = "${var.name}-${var.unique_suffix}-plan"

  # Key Vault naming rules:
  # - globally unique
  # - 3-24 characters
  # - alphanumeric and hyphens
  # We'll lowercase and trim to 24 chars.
  kv_name = substr(lower("${var.name}-${var.unique_suffix}-kv"), 0, 24)
}

resource "azurerm_service_plan" "this" {
  count               = var.enable_app_service ? 1 : 0
  name                = local.plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "B1" # later you can change to "F1" if App Service is allowed
}

resource "azurerm_linux_web_app" "this" {
  count               = var.enable_app_service ? 1 : 0
  name                = local.webapp_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this[0].id


  site_config {
    always_on = true

    application_stack {
      node_version = "18-lts"
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}

resource "azurerm_key_vault" "this" {
  name                       = local.kv_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
}

resource "azurerm_key_vault_access_policy" "me" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = ["Get", "List", "Set", "Delete"]
}
