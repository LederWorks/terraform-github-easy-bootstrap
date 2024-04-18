#Variables
resource "github_actions_variable" "variable" {
  for_each = local.variables != {} ? local.variables : {}

  repository    = github_repository.repo[each.key].id
  variable_name = each.key
  value         = each.value.value
}

#Secrets
resource "github_actions_secret" "secret" {
  for_each = local.secrets != {} ? local.secrets : {}

  repository      = github_repository.repo[each.key].id
  secret_name     = each.key
  # encrypted_value = each.value
  plaintext_value = each.value.value
}

#Labels
resource "github_issue_label" "labels" {
  for_each = {
    for repo_name, repo in var.repos : repo_name => {
      for label_name, label in repo.custom_labels : label_name => label
    }
  }

  repository  = each.key
  name        = each.value.name
  description = each.value.description
  color       = each.value.color
}
