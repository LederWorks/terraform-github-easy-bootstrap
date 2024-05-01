# Module Test
module "github_bootstrap" {
  source = "../.."

  #### Common Variables
  terraform_provider = "mastiff"
  brand              = "ezpz"
  hive = "rainbow"

  #### Members
  contributors = local.all_members
  approvers = ["Dilergore"]
  admins = ["Ledermayer"]

  #### Inputs
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

  repos = {
    pink = {
      #Common
      type   = "engine"
      suffix = "pink"
      description = "Mastiff Rainbow Engine Pink Module"
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

      #Documentation
      documentation = {
        enabled = true
        about = "This is a pink engine module"
      }
    }
    #Do not deploy release content
    purple = {
      type   = "brick"
      suffix = "purple"
      documentation = {
        about = "This is a purple brick module"
      }
      release = {
        enabled      = false
      }
    }
    /* violet = {
      type   = "block"
      suffix = "violet"
    } */
    /* brown = {
      type   = "wrapper"
      suffix = "brown"
    } */
    /* orange = {
      type   = "accelerator"
      suffix = "orange"
    } */
  }
}
