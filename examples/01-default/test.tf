# Module Test
module "github_bootstrap" {
  source = "../.."

  #### Common Variables
  terraform_provider = "mastiff"
  brand              = "ezpz"
  hive               = "rainbow"

  #### Members
  contributors = local.all_members
  approvers    = ["Dilergore"]
  admins       = ["Ledermayer"]

  #### Inputs
  variables = {
    one = "pici"
    dog = "tej"
  }

  secrets = {
    my  = "verysecret"
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
    #All customization options with Pink
    pink = {
      #Common
      type        = "engine"
      suffix      = "pink"
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
        #General
        enabled       = true
        output_file   = "USAGE.md"
        output_format = "markdown table"

        #Content
        about = "This is a pink engine module"
        # inputs_enabled    = false #Defaults to true
        # outputs_enabled   = false #Defaults to true
        # providers_enabled = false #Defaults to true
        required_enabled = false #Defaults to true
        # resources_enabled = false #Defaults to true

        #Config
        # anchor_enabled      = false #Defaults to true
        # default_enabled     = false #Defaults to true
        # description_enabled = false #Defaults to true
        # escape_enabled      = false #Defaults to true
        hide_empty_enabled = true #Defaults to false
        # html_enabled        = false #Defaults to true
        indent = 4 #Defaults to 2
        # lockfile_enabled    = true  #Defaults to false
        required_enabled = false #Defaults to true
        # sensitive_enabled   = false #Defaults to true
        # type_enabled        = false #Defaults to true
      }
    }

    #Do not deploy release content for Purple
    /* purple = {
      type   = "brick"
      suffix = "purple"
      documentation = {
        enabled = true
        about   = "This is a purple brick module"
      }
      release = {
        enabled = false
      }
    } */

    #Customize Examples
    violet = {
      type   = "block"
      suffix = "violet"
      examples = {
        everest = {
          name = "01-everest"
          description = "Everest is the highest mountain in the world"
          context_deployed = true
        }

        kaytoo = {
          name = "02-kaytoo"
          description = "K2 is the second highest mountain in the world"
        }

        kangchenjunga = {
          name = "03-kangchenjunga"
          description = "Kangchenjunga is the third highest mountain in the world"
          context_deployed = true
        }
      }
    }

    #Let's add some load
    /* brown = {
      type   = "wrapper"
      suffix = "brown"
    }

    orange = {
      type   = "accelerator"
      suffix = "orange"
    }

    green = {
      type   = "tool"
      suffix = "green"
    }

    black = {
      type   = "context"
      suffix = "black"
    } */
  }
}

