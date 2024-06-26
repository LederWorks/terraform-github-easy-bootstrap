terraform {

  required_version = ">= 1.3.6"

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.61.0"
    }

    github = {
      source  = "integrations/github"
      version = ">= 6.2.1"
    }
  }
}
