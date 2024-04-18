#Resource Group
resource "azurerm_resource_group" "rgrp" {
  name     = "rgrp-tde3-ic-terratest-github-bootstrap"
  location = "germanywestcentral"
}
output "resource_group_name" {
  value = azurerm_resource_group.rgrp.name
}

#Subscription ID
data "azurerm_client_config" "current" {}
output "subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
}
