#  $$$$$$\                                                            
# $$  __$$\                                                           
# $$ /  \__| $$$$$$\  $$$$$$\$$$$\  $$$$$$\$$$$\   $$$$$$\  $$$$$$$\  
# $$ |      $$  __$$\ $$  _$$  _$$\ $$  _$$  _$$\ $$  __$$\ $$  __$$\ 
# $$ |      $$ /  $$ |$$ / $$ / $$ |$$ / $$ / $$ |$$ /  $$ |$$ |  $$ |
# $$ |  $$\ $$ |  $$ |$$ | $$ | $$ |$$ | $$ | $$ |$$ |  $$ |$$ |  $$ |
# \$$$$$$  |\$$$$$$  |$$ | $$ | $$ |$$ | $$ | $$ |\$$$$$$  |$$ |  $$ |
#  \______/  \______/ \__| \__| \__|\__| \__| \__| \______/ \__|  \__|

#Provider
variable "provider" {
  type        = string
  default     = "oci"
  description = "The cloud provider to be bootstrapped."
}

#Members
variable "members" {
  type        = set(string)
  default     = []
  description = "Members of the provider team."
}
#Admins
variable "admins" {
  type        = set(string)
  default     = []
  description = "Admins of the provider team."
}

#Variables
variable "variables" {
  type    = map(string)
  default = {}
}

#Secrets
variable "secrets" {
  type      = map(string)
  default   = {}
  sensitive = true
}

#Labels
variable "labels" {
  type = map(object({
    name        = string
    color       = string
    description = optional(string)
  }))
  default = {}
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
    approvers    = optional(set(string), [])
    contributors = optional(set(string), [])
  }))
  default = {}
}

#Repositories
variable "repos" {
  type = map(object({
    #Common
    name = object({
      language = optional(string, "terraform")
      provider = optional(string)
      infix    = optional(string) #easy
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
    custom_teams     = optional(set(string), [])
    custom_variables = optional(map(string), {})
    custom_secrets   = optional(map(string), {})
    custom_labels = optional(map(object({
      name        = string
      color       = string
      description = optional(string)
    })))
  }))
  default     = {}
  description = <<EOT

  EOT
}
