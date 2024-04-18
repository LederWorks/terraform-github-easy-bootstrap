# Module Test
module "github_bootstrap" {
  source = "../.."

  #### Common Variables
  terraform_provider = "azure"
  members            = local.all_members
  admins             = ["Ledermayer"]
  brand              = "ezpz"

  #Inputs
  variables = {
    one = "pici"
    dog = "tej"
  }

  secrets = {
    my   = "verysecret"
    not = "yoursecret"
  }

  labels = {
    one = {
      name        = "one"
      color       = "0000Ff"
      description = "blue"
    }
    two = {
      name        = "two"
      color       = "ff00ff"
      description = "magenta"
    }
  }

  #### Set Variables
  hives = {
    ### Azure Network Modules
    azure-network = {
      hive         = "network"
      approvers    = local.hu_members
      contributors = local.us_members
    }

    ### Azure Compute Modules
    azure-compute = {
      hive         = "compute"
      approvers    = local.us_members
      contributors = local.hu_members
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
      custom_variables = {
        wait  = "babám"
        never = "menjel"
      }

      custom_secrets = {
        their = "regret"
        our   = "szeglet"
      }

      custom_labels = {
        three = {
          name        = "three"
          color       = "Ff0000"
          description = "red"
        }
        four = {
          name        = "four"
          color       = "00ff00"
          description = "green"
        }
      }
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
