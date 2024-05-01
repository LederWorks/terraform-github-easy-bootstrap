variable "files" {
  type = map(object({
    repository = string
    file = string
    content = string
    branch = optional(string)
    commit_author = optional(string)
    commit_email = optional(string)
    commit_message = optional(string)
    overwrite = optional(bool, true)
  }))
  default = {}
  description = <<EOT
  A map of files to be created in the repository. The files object supports the following attributes:

  - repository: (Required) The repository to create the file in.
  - file: (Required) The path to the file to manage.
  - content: (Required) The content of the file.
  - branch: (Optional) Git branch (defaults to the repository's default branch). The branch must already exist, it will not be created if it does not already exist.
  - commit_author: (Optional) Committer author name to use. NOTE: GitHub app users may omit author and email information so GitHub can verify commits as the GitHub App. This maybe useful when a branch protection rule requires signed commits.
  - commit_email: (Optional) Committer email address to use. NOTE: GitHub app users may omit author and email information so GitHub can verify commits as the GitHub App. This may be useful when a branch protection rule requires signed commits.
  - commit_message: (Optional) The commit message when creating, updating or deleting the managed file.
  - overwrite: (Optional) Enable overwriting existing files. If set to true it will overwrite an existing file with the same name. If set to false it will fail if there is an existing file with the same name. Defaults to true.
  EOT
}