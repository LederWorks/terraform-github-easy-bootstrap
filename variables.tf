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
    #Common
    type        = string
    suffix      = string
    description = optional(string)
    url         = optional(string)
    #General
    private_enabled     = optional(bool, false)
    issues_enabled      = optional(bool, true)
    discussions_enabled = optional(bool, false)
    projects_enabled    = optional(bool, false)
    wiki_enabled        = optional(bool, false)
    archive_enabled     = optional(bool, false)
    #Custom Inputs
    custom_variables = optional(map(string), {})
    custom_secrets   = optional(map(string), {})
    custom_labels = optional(map(object({
      name        = string
      color       = string
      description = optional(string)
    })), {})

    #### Templates ####

    #Terraform-Docs
    documentation = optional(object({
      enabled       = bool
      output_file   = optional(string, "README.md")
      output_format = optional(string, "markdown document")
      about         = optional(string, "This is a Terraform module.")
      }), {
      enabled = true
    })

    #Semver + Release
    release = optional(object({
      enabled = bool
      }), {
      enabled = true
    })

    #Examples - Deploys the examples/%EXAMPLE%/auth.tf files configured for the repository
    examples = optional(map(object({
      name = string
      ##Providers for examples
      providers = optional(object({
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
        }))
        github = optional(object({
          enabled = bool
          source  = optional(string, "integrations/github")
          version = optional(string, "6.2.1")
        }))
        oci = optional(object({
          enabled = bool
          source  = optional(string, "oracle/oci")
          version = optional(string, "5.38.0")
        }))
      }))

      ##Backends for examples - We do not enable as default any backends, as there are only one can be configured, and each needs custom input anyway for each examples.
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
    })), {})


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
