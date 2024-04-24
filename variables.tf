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
  default     = []
  description = "(Optional) Contributors of the hive team."
}

#Approvers
variable "approvers" {
  type        = set(string)
  default     = []
  description = "(Optional) Approvers of the hive team."
}

#Admins
variable "admins" {
  type        = set(string)
  default     = []
  description = "(Optional) Admins of the hive team."
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
