output "webapp_url" {
  value = var.enable_app_service ? "https://${azurerm_linux_web_app.this[0].default_hostname}" : null
}

output "webapp_name" {
  value = var.enable_app_service ? azurerm_linux_web_app.this[0].name : null
}

output "key_vault_name" {
  value = azurerm_key_vault.this.name
}
