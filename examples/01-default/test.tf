# Module Test
module "github_bootstrap" {
  source = "../.."

  #### Common Variables
  terraform_provider = "azure"
  members            = ["Wonka", "Ledermayer"]
  admins             = ["Ledermayer"]
  variables          = {}
  secrets            = {}
  labels             = {}



  #### Set Variables
  hives = {
    #Azure Network Modules
    azure-network = {
      hive         = "network"
      approvers    = ["Ledermayer", "Wonka"]
      contributors = ["Ledermayer"]
    }

    #Azure Compute Modules
    azure-compute = {
      hive         = "compute"
      approvers    = ["Ledermayer", "Wonka"]
      contributors = ["Ledermayer"]
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
