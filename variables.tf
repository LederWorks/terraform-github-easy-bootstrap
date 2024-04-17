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

variable "hives" {
  type = map(object({
    provider  = string
    hive      = string
    members   = optional(set(string), [])
    variables = optional(map(string), {})
    secrets   = optional(map(string), {})
    labels = optional(map(object({
      name        = string
      color       = string
      description = optional(string)
    })))
  }))
  default = {}
}

variable "repos" {
  type = map(object({
    name = object({
      language = optional(string, "terraform")
      provider = optional(string)
      infix    = optional(string) #easy
      type     = optional(string)
      hive     = optional(string)
      suffix   = string
    })
    private          = optional(bool, false)
    project_enabled  = optional(bool, false)
    custom_teams     = optional(set(string), [])
    custom_variables = optional(map(string), {})
    custom_secrets   = optional(map(string), {})
    custom_labels = optional(map(object({
      name        = string
      color       = string
      description = optional(string)
    })))

  }))
  default = {}
}