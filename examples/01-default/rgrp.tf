#Resource Group
resource "azurerm_resource_group" "rgrp" {
  name     = "rgrp"
  location = "East US 2"
}