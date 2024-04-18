#  $$$$$$\                                                            
# $$  __$$\                                                           
# $$ /  \__| $$$$$$\  $$$$$$\$$$$\  $$$$$$\$$$$\   $$$$$$\  $$$$$$$\  
# $$ |      $$  __$$\ $$  _$$  _$$\ $$  _$$  _$$\ $$  __$$\ $$  __$$\ 
# $$ |      $$ /  $$ |$$ / $$ / $$ |$$ / $$ / $$ |$$ /  $$ |$$ |  $$ |
# $$ |  $$\ $$ |  $$ |$$ | $$ | $$ |$$ | $$ | $$ |$$ |  $$ |$$ |  $$ |
# \$$$$$$  |\$$$$$$  |$$ | $$ | $$ |$$ | $$ | $$ |\$$$$$$  |$$ |  $$ |
#  \______/  \______/ \__| \__| \__|\__| \__| \__| \______/ \__|  \__|

#Provider
variable "terraform_provider" {
  type        = string
  default     = "oci"
  description = "(Optional) The terraform provider to be bootstrapped. Defaults to 'oci'."
}

variable "provider_bootstrap_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Enable provider bootstrap, which creates the provider teams and sets up team members and admins."
}

variable "provider_team_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the already existing provider team. Mutually exclusive with provider_bootstrap_enabled."
}

variable "provider_admin_team_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the already existing provider admin team. Mutually exclusive with provider_bootstrap_enabled."
}

#Members
variable "members" {
  type        = set(string)
  default     = []
  description = "(Optional) Members of the provider team. Required when provider_bootstrap_enabled is set to true."
}

#Admins
variable "admins" {
  type        = set(string)
  default     = []
  description = "(Optional) Admins of the provider team. Required when provider_bootstrap_enabled is set to true."
}

#Variables
variable "variables" {
  type        = map(string)
  default     = {}
  description = "(Optional) value"
}

#Secrets
variable "secrets" {
  type        = map(string)
  default     = {}
  sensitive   = true
  description = "(Optional) value"
}

#Labels
variable "labels" {
  type = map(object({
    name        = string
    color       = string
    description = optional(string)
  }))
  default     = {}
  description = "(Optional) value"
}

#Brand
variable "brand" {
  type        = string
  default     = null
  description = "(Optional) The brand name to be used in the nomenclature. This appears as an infix in the repository name."
}

#  $$$$$$\             $$\           $$\    $$\                              
# $$  __$$\            $$ |          $$ |   $$ |                             
# $$ /  \__| $$$$$$\ $$$$$$\         $$ |   $$ |$$$$$$\   $$$$$$\   $$$$$$$\ 
# \$$$$$$\  $$  __$$\\_$$  _|        \$$\  $$  |\____$$\ $$  __$$\ $$  _____|
#  \____$$\ $$$$$$$$ | $$ |           \$$\$$  / $$$$$$$ |$$ |  \__|\$$$$$$\  
# $$\   $$ |$$   ____| $$ |$$\         \$$$  / $$  __$$ |$$ |       \____$$\ 
# \$$$$$$  |\$$$$$$$\  \$$$$  |         \$  /  \$$$$$$$ |$$ |      $$$$$$$  |
#  \______/  \_______|  \____/           \_/    \_______|\__|      \_______/ 

#Hives
variable "hives" {
  type = map(object({
    hive         = string
    approvers    = set(string)
    contributors = set(string)
  }))
  default     = {}
  description = <<EOT
  A map of competency hives to be created.
  Each hive is a collection of repositories that share a common theme.

  hive         - (Required) The name of the hive.
  approvers    - (Required) A list of usernames that are approvers for the hive.
  contributors - (Required) A list of usernames that are contributors for the hive.

  EOT
}

#Repositories
variable "repos" {
  type = map(object({
    #Common
    name = object({
      language = optional(string, "terraform")
      type     = optional(string)
      hive     = optional(string)
      suffix   = string
    })
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
  }))
  default     = {}
  description = <<EOT
  A map of repositories and associated configurations to be created. The repos object support the following:

  name - (Required) The name of the repository. The name object supports the following:

    language - (Optional) The language of the repository. Defaults to 'terraform'.
    type     - (Optional) The type of the repository.
    hive     - (Optional) The hive of the repository.
    suffix   - (Required) The suffix of the repository.

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
