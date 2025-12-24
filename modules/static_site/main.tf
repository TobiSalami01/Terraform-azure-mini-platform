data "azurerm_storage_account" "this" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_storage_account_static_website" "this" {
  storage_account_id = data.azurerm_storage_account.this.id
  index_document     = "index.html"
  error_404_document = "404.html"
}
