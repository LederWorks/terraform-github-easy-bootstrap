variable "template_repo" {
  description = "The template repository to use for creating new repos"
  type        = string
  default     = null
}

variable "owner" {
  type = string
}

variable "variables" {
  type    = map(string)
  default = {}
}

variable "secrets" {
  type      = map(string)
  default   = {}
  sensitive = true
}

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
    provider    = string
    hive        = string
    description = optional(string)
    members     = optional(set(string), [])
    variables   = optional(map(string), {})
    secrets     = optional(map(string), {})
    labels = optional(map(object({
      name        = string
      color       = string
      description = optional(string)
    })))
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
