output "static_site_url" {
  value = data.azurerm_storage_account.this.primary_web_endpoint
}
