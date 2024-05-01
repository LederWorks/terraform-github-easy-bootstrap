#This file is managed by the Github Bootstrap workflow. Any modifications to this file may be overwritten. To make changes, please modify the terraform-github-easy-bootstrap module.
#Providers
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  storage_use_azuread = true
}

provider "github" {}

#Versions
terraform {
  required_version = ">=1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.100.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.2.1"
    }
  }
}

#Backend
terraform {
  backend "azurerm" {
    resource_group_name  = "rgrp-pde3-it-terratest"
    storage_account_name = "saccpde3itterratest001"
    container_name       = "terratest-github"
    key                  = "easy-bootstrap.01.tfstate"
    snapshot             = true
    use_azuread_auth     = true
  }
}
