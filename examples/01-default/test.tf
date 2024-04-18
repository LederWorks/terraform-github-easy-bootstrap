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
    azure-network = {
      provider  = "azure"
      hive      = "network"
      description = "Azure Network Terraform Team"
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
    azure-compute = {
      provider  = "azure"
      hive      = "compute"
      description = "Azure Compute Terraform Team"
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
        infix    = "baby"
        type     = "brick"
        hive     = "network"
        suffix   = "nsg"
      }
    }

    #Azure Compute NIC Module
    azurerm-compute-nic = {
      name = {
        language = "terraform"
        provider = "azurerm"
        infix    = "baby"
        type     = "brick"
        hive     = "compute"
        suffix   = "nic"
      }
    }
  }

}
