#  $$$$$$\                                                            
# $$  __$$\                                                           
# $$ /  \__| $$$$$$\  $$$$$$\$$$$\  $$$$$$\$$$$\   $$$$$$\  $$$$$$$\  
# $$ |      $$  __$$\ $$  _$$  _$$\ $$  _$$  _$$\ $$  __$$\ $$  __$$\ 
# $$ |      $$ /  $$ |$$ / $$ / $$ |$$ / $$ / $$ |$$ /  $$ |$$ |  $$ |
# $$ |  $$\ $$ |  $$ |$$ | $$ | $$ |$$ | $$ | $$ |$$ |  $$ |$$ |  $$ |
# \$$$$$$  |\$$$$$$  |$$ | $$ | $$ |$$ | $$ | $$ |\$$$$$$  |$$ |  $$ |
#  \______/  \______/ \__| \__| \__|\__| \__| \__| \______/ \__|  \__|

#Organization
variable "organization" {
  type        = string
  description = "(Required) The name of the organization to create the repositories in."
  default     = "LederWorks"
}
#Provider
variable "terraform_provider" {
  type        = string
  description = "(Required) The terraform provider to be bootstrapped, such as azurerm, google, aws etc."
}

#Brand
variable "brand" {
  type        = string
  default     = "easy"
  description = "(Optional) The brand name to be used in the nomenclature. This appears as an infix in the repository name."
}

#Hive
variable "hive" {
  type        = string
  description = "(Required) The name of the hive, such as compute, network, security etc."
}

#  $$$$$$\                       $$$$$$\  $$\           
# $$  __$$\                     $$  __$$\ \__|          
# $$ /  \__| $$$$$$\  $$$$$$$\  $$ /  \__|$$\  $$$$$$\  
# $$ |      $$  __$$\ $$  __$$\ $$$$\     $$ |$$  __$$\ 
# $$ |      $$ /  $$ |$$ |  $$ |$$  _|    $$ |$$ /  $$ |
# $$ |  $$\ $$ |  $$ |$$ |  $$ |$$ |      $$ |$$ |  $$ |
# \$$$$$$  |\$$$$$$  |$$ |  $$ |$$ |      $$ |\$$$$$$$ |
#  \______/  \______/ \__|  \__|\__|      \__| \____$$ |
#                                             $$\   $$ |
#                                             \$$$$$$  |
#                                              \______/ 

variable "terraform_version" {
  type        = string
  description = "(Required) The version of Terraform to be used in the repositories workflows."
  default     = "1.8.2"
}

# $$\      $$\                         $$\                                     
# $$$\    $$$ |                        $$ |                                    
# $$$$\  $$$$ | $$$$$$\  $$$$$$\$$$$\  $$$$$$$\   $$$$$$\   $$$$$$\   $$$$$$$\ 
# $$\$$\$$ $$ |$$  __$$\ $$  _$$  _$$\ $$  __$$\ $$  __$$\ $$  __$$\ $$  _____|
# $$ \$$$  $$ |$$$$$$$$ |$$ / $$ / $$ |$$ |  $$ |$$$$$$$$ |$$ |  \__|\$$$$$$\  
# $$ |\$  /$$ |$$   ____|$$ | $$ | $$ |$$ |  $$ |$$   ____|$$ |       \____$$\ 
# $$ | \_/ $$ |\$$$$$$$\ $$ | $$ | $$ |$$$$$$$  |\$$$$$$$\ $$ |      $$$$$$$  |
# \__|     \__| \_______|\__| \__| \__|\_______/  \_______|\__|      \_______/ 

#Contributors
variable "contributors" {
  type        = set(string)
  description = "(Required) Contributors of the hive team."
}

#Approvers
variable "approvers" {
  type        = set(string)
  description = "(Required) Approvers of the hive team."
}

#Admins
variable "admins" {
  type        = set(string)
  description = "(Required) Admins of the hive team."
}

# $$$$$$\                                 $$\               
# \_$$  _|                                $$ |              
#   $$ |  $$$$$$$\   $$$$$$\  $$\   $$\ $$$$$$\    $$$$$$$\ 
#   $$ |  $$  __$$\ $$  __$$\ $$ |  $$ |\_$$  _|  $$  _____|
#   $$ |  $$ |  $$ |$$ /  $$ |$$ |  $$ |  $$ |    \$$$$$$\  
#   $$ |  $$ |  $$ |$$ |  $$ |$$ |  $$ |  $$ |$$\  \____$$\ 
# $$$$$$\ $$ |  $$ |$$$$$$$  |\$$$$$$  |  \$$$$  |$$$$$$$  |
# \______|\__|  \__|$$  ____/  \______/    \____/ \_______/ 
#                   $$ |                                    
#                   $$ |                                    
#                   \__|                                    

#Variables
variable "variables" {
  type        = map(string)
  default     = {}
  description = "(Optional) A map(string) of action variables to be created for all hive repositories"
}

#Secrets
variable "secrets" {
  type        = map(string)
  default     = {}
  description = "(Optional) A map(string) of action secrets to be created for all hive repositories"
}

#Labels
variable "labels" {
  type = map(object({
    name        = string
    color       = string
    description = optional(string)
  }))
  default     = {}
  description = <<EOT
  (Optional) A map of labels to be created for all hive repositories. The labels object supports the following:

  name        - (Required) The name of the label.
  color       - (Required) The color of the label.
  description - (Optional) The description of the label.
  EOT
}

# $$$$$$$\                                          
# $$  __$$\                                         
# $$ |  $$ | $$$$$$\   $$$$$$\   $$$$$$\   $$$$$$$\ 
# $$$$$$$  |$$  __$$\ $$  __$$\ $$  __$$\ $$  _____|
# $$  __$$< $$$$$$$$ |$$ /  $$ |$$ /  $$ |\$$$$$$\  
# $$ |  $$ |$$   ____|$$ |  $$ |$$ |  $$ | \____$$\ 
# $$ |  $$ |\$$$$$$$\ $$$$$$$  |\$$$$$$  |$$$$$$$  |
# \__|  \__| \_______|$$  ____/  \______/ \_______/ 
#                     $$ |                          
#                     $$ |                          
#                     \__|                          

#Repositories
variable "repos" {
  type = map(object({
    ### Common
    type        = string
    suffix      = string
    description = optional(string)
    url         = optional(string)
    ### General
    private_enabled     = optional(bool, false)
    issues_enabled      = optional(bool, true)
    discussions_enabled = optional(bool, false)
    projects_enabled    = optional(bool, false)
    wiki_enabled        = optional(bool, false)
    archive_enabled     = optional(bool, false)
    ### Custom Inputs
    custom_variables = optional(map(string), {})
    custom_secrets   = optional(map(string), {})
    custom_labels = optional(map(object({
      name        = string
      color       = string
      description = optional(string)
    })), {})

    # $$$$$$$$\                                $$\            $$\                         
    # \__$$  __|                               $$ |           $$ |                        
    #    $$ | $$$$$$\  $$$$$$\$$$$\   $$$$$$\  $$ | $$$$$$\ $$$$$$\    $$$$$$\   $$$$$$$\ 
    #    $$ |$$  __$$\ $$  _$$  _$$\ $$  __$$\ $$ | \____$$\\_$$  _|  $$  __$$\ $$  _____|
    #    $$ |$$$$$$$$ |$$ / $$ / $$ |$$ /  $$ |$$ | $$$$$$$ | $$ |    $$$$$$$$ |\$$$$$$\  
    #    $$ |$$   ____|$$ | $$ | $$ |$$ |  $$ |$$ |$$  __$$ | $$ |$$\ $$   ____| \____$$\ 
    #    $$ |\$$$$$$$\ $$ | $$ | $$ |$$$$$$$  |$$ |\$$$$$$$ | \$$$$  |\$$$$$$$\ $$$$$$$  |
    #    \__| \_______|\__| \__| \__|$$  ____/ \__| \_______|  \____/  \_______|\_______/ 
    #                                $$ |                                                 
    #                                $$ |                                                 
    #                                \__|                                                 

    ### PR Template
    pr_template = optional(object({
      enabled = bool
      }), {
      enabled = true
    })

    ### Support Template
    support = optional(object({
      enabled = bool
      }), {
      enabled = true
    })

    ### Terraform-Docs
    documentation = optional(object({
      ### General
      enabled       = bool
      output_file   = optional(string, "README.md")
      output_format = optional(string, "markdown document")
      ### Content
      about                = optional(string, "This is a Terraform module.")
      inputs_enabled       = optional(bool, true)
      outputs_enabled      = optional(bool, true)
      providers_enabled    = optional(bool, true)
      requirements_enabled = optional(bool, true)
      resources_enabled    = optional(bool, true)
      ### Config
      anchor_enabled      = optional(bool, true)
      default_enabled     = optional(bool, true)
      description_enabled = optional(bool, true)
      escape_enabled      = optional(bool, true)
      hide_empty_enabled  = optional(bool, false)
      html_enabled        = optional(bool, true)
      indent              = optional(number, 2)
      lockfile_enabled    = optional(bool, false)
      required_enabled    = optional(bool, true)
      sensitive_enabled   = optional(bool, true)
      type_enabled        = optional(bool, true)
      }), {
      enabled = true
    })

    ### Semver + Release
    release = optional(object({
      enabled = bool
      }), {
      enabled = true
    })

    ### Examples - Deploys the following content to examples/%EXAMPLE%/ path for the repository
    examples = optional(map(object({
      #### General
      name        = string
      description = optional(string)

      #### Files
      #auth.tf
      auth_enabled      = optional(bool, true) # Manage the auth.tf file configuration for the example
      auth_docs_enabled = optional(bool, true) # Configure the auth.tf documentation for the example
      #context.tf
      context_deployed     = optional(bool, false) # Deploy the context.tf sample file for the example
      context_docs_enabled = optional(bool, false) # Configure the context.tf documentation for the example
      #data.tf
      data_deployed     = optional(bool, false) # Deploy the data.tf sample file for the example
      data_docs_enabled = optional(bool, false) # Configure the data.tf documentation for the example
      #locals.tf
      locals_deployed     = optional(bool, true) # Deploy the locals.tf sample file for the example
      locals_docs_enabled = optional(bool, true) # Configure the locals.tf documentation for the example
      #main.tf
      main_deployed     = optional(bool, true) # Deploy the main.tf sample file for the example
      main_docs_enabled = optional(bool, true) # Configure the main.tf documentation for the example
      #outputs.tf
      outputs_deployed     = optional(bool, true) # Deploy the outputs.tf sample file for the example
      outputs_docs_enabled = optional(bool, true) # Configure the outputs.tf documentation for the example
      #terratest.tf
      terratest_enabled     = optional(bool, true) # Manage the terratest-%EXAMPLE%.yml workflow file in the .test folder for the example
      terraform_version    = optional(string) # The version of Terraform to be used in the examples workflows.
      #variables.tf
      variables_deployed     = optional(bool, false) # Deploy the variables.tf sample file for the example
      variables_docs_enabled = optional(bool, false) # Configure the variables.tf documentation for the example

      #### Providers for auth.tf
      providers = optional(object({
        #azurerm
        azurerm = optional(object({
          enabled = bool # We use enabled to determine if the provider is to be bootstrapped, as all attributes are optional.
          source  = optional(string, "hashicorp/azurerm")
          version = optional(string, "3.100.0")
          features = optional(object({
            resource_group = optional(object({
              prevent_deletion_if_contains_resources = optional(bool, false)
            }))
          }))
          storage_use_azuread = optional(bool, true)
          }), {
          enabled = true
        })

        #github
        github = optional(object({
          enabled = bool
          source  = optional(string, "integrations/github")
          version = optional(string, "6.2.1")
          }), {
          enabled = false
        })

        #oci
        oci = optional(object({
          enabled = bool
          source  = optional(string, "oracle/oci")
          version = optional(string, "5.38.0")
          }), {
          enabled = false
        })
      }))

      #### Backends for auth.tf - We do not enable as default any backends, as there are only one can be configured, and each needs custom input anyway for each examples.
      backends = optional(map(object({
        azurerm = optional(object({
          resource_group_name         = optional(string, "rgrp-pde3-it-terratest") # Can be passed via -backend-config="resource_group_name=<resource group name>" in the init command.
          storage_account_name        = optional(string, "saccpde3itterratest001") # Can be passed via -backend-config="storage_account_name=<storage account name>" in the init command.
          container_name              = optional(string, "terratest-azurerm")      # Can be passed via -backend-config="container_name=<container name>" in the init command.
          key                         = optional(string)                           # Can be passed via -backend-config="key=<blob key name>" in the init command.
          snapshot                    = optional(bool, true)                       # Can also be set via ARM_SNAPSHOT environment variable.
          use_azuread_auth            = optional(bool, true)                       # Can also be set via ARM_USE_AZUREAD environment variable.
          use_msi                     = optional(bool, false)                      # Can also be set via ARM_USE_MSI environment variable.
          msi_endpoint                = optional(string)                           # Can also be set via ARM_MSI_ENDPOINT environment variable.
          use_oidc                    = optional(bool, false)                      # Can also be set via ARM_USE_OIDC environment variable.
          oidc_request_url            = optional(string)                           # Can also be set via ARM_OIDC_REQUEST_URL or ACTIONS_ID_TOKEN_REQUEST_URL environment variables.
          oidc_request_token          = optional(string)                           # Can also be set via ARM_OIDC_REQUEST_TOKEN or ACTIONS_ID_TOKEN_REQUEST_TOKEN environment variables.
          oidc_token                  = optional(string)                           # Can also be set via ARM_OIDC_TOKEN environment variable.
          oidc_token_file_path        = optional(string)                           # Can also be set via ARM_OIDC_TOKEN_FILE_PATH environment variable.
          environment                 = optional(string, "public")                 # Can also be set via ARM_ENVIRONMENT environment variable.
          client_id                   = optional(string)                           # Can also be set via ARM_CLIENT_ID environment variable.
          client_secret               = optional(string)                           # Can also be set via ARM_CLIENT_SECRET environment variable.
          client_certificate_path     = optional(string)                           # Can also be set via ARM_CLIENT_CERTIFICATE_PATH environment variable.
          client_certificate_password = optional(string)                           # Can also be set via ARM_CLIENT_CERTIFICATE_PASSWORD environment variable.
          subscription_id             = optional(string)                           # Can also be set via ARM_SUBSCRIPTION_ID environment variable.
          tenant_id                   = optional(string)                           # Can also be set via ARM_TENANT_ID environment variable.
        }))
        /* gcs = optional(object({
          bucket      = optional(string, "pde3-it-terratest")
          prefix      = optional(string, "terratest-google")
          credentials = optional(string, "gcp-credentials.json")
        })) */
        /* s3 = optional(object({
          bucket  = optional(string, "pde3-it-terratest")
          key     = optional(string, "terratest-oci")
          region  = optional(string, "us-west-2")
          profile = optional(string, "default")
        })) */
      })))
    })), {
      default = {
        name        = "01-default"
        description = "This is the default example."
      }
    })


  }))
  default     = {}
  description = <<EOT
  A map of repositories and associated configurations to be created. The repos object support the following:

  type        - (Required) The type of the repository.
  suffix      - (Required) The suffix of the repository.
  description - (Optional) The description of the repository.
  url         - (Optional) The URL of the repository.

  private_enabled     - (Optional) Whether the repository is private. Defaults to false.
  issues_enabled      - (Optional) Whether issues are enabled. Defaults to true.
  discussions_enabled - (Optional) Whether discussions are enabled. Defaults to false.
  projects_enabled    - (Optional) Whether projects are enabled. Defaults to false.
  wiki_enabled        - (Optional) Whether the wiki is enabled. Defaults to false.
  archive_enabled     - (Optional) Whether the repository is archived. Defaults to false.

  custom_variables - (Optional) A map of custom variables to be added to the repository.
  custom_secrets   - (Optional) A map of custom secrets to be added to the repository.
  custom_labels    - (Optional) A map of custom labels to be added to the repository. The custom_labels object supports the following:

    name        - (Required) The name of the label.
    color       - (Required) The color of the label.
    description - (Optional) The description of the label.
  EOT
}
