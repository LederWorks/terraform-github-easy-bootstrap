# Module Test
module "github_bootstrap" {
  source = "../.."

  #### Common Variables
  terraform_provider = "azure"
  members            = ["Ledermayer", "Wonka"]
  admins             = ["Ledermayer"]
  variables          = {}
  secrets            = {}
  labels             = {}
  brand              = "ezpz"

  #### Set Variables
  hives = {
    ### Azure Network Modules
    azure-network = {
      hive         = "network"
      approvers    = ["Ledermayer", "Wonka"]
      contributors = ["Ledermayer"]
    }

    ### Azure Compute Modules
    azure-compute = {
      hive         = "compute"
      approvers    = ["Ledermayer", "Wonka"]
      contributors = ["Ledermayer"]
    }
  }

  repos = {
    ### Azure Network NSG Module
    azurerm-network-nsg = {
      #Common
      name = {
        type   = "brick"
        hive   = "network"
        suffix = "nsg"
      }
      description = "Azure Network NSG Module"
      url         = null

      #General
      private_enabled     = false
      issues_enabled      = true
      discussions_enabled = false
      projects_enabled    = false
      wiki_enabled        = false
      archive_enabled     = false

      #Custom Inputs
      custom_teams     = []
      custom_variables = {}
      custom_secrets   = {}
      custom_labels    = {}
    }

    ### Azure Compute NIC Module
    azurerm-compute-nic = {
      name = {
        type   = "brick"
        hive   = "compute"
        suffix = "nic"
      }
      description = "Azure Compute NIC Module"
    }
  }

}
