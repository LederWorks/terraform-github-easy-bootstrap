# Module Test
module "github_bootstrap" {
  source = "../.."

  ### Common Variables ###
  owner = "Ledermayer"

  ### General Variables ###

  ### Global Variables ###

  ### Set Variables ###
  hives = {
    #Azure Network Modules
    azurerm-network = {
      provider  = "azurerm"
      hive      = "network"
      members   = []
      variables = {}
      secrets   = {}
      labels = {
        azurerm-compute = {
          name        = "azurerm-network"
          color       = "blue"
          description = "Azure Network Modules"
        }
      }
    }

    #Azure Compute Modules
    azurerm-compute = {
      provider  = "azurerm"
      hive      = "compute"
      members   = []
      variables = {}
      secrets   = {}
      labels = {
        azurerm-compute = {
          name        = "azurerm-compute"
          color       = "blue"
          description = "Azure Compute Modules"
        }
      }
    }
  }

  repos = {
    #Azure Network NSG Module
    azurerm-network-nsg = {
      name = {
        language = "terraform"
        provider = "azurerm"
        infix    = "easy"
        type     = "brick"
        hive     = "azurerm-network"
        suffix   = "nsg"
      }
    }

    #Azure Compute NIC Module
    azurerm-compute-nic = {
      name = {
        language = "terraform"
        provider = "azurerm"
        infix    = "easy"
        type     = "brick"
        hive     = "azurerm-compute"
        suffix   = "nic"
      }
    }
  }

}
