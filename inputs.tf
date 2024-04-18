#Variables
resource "github_actions_variable" "variable" {
  for_each = local.variables[github_repository.repo[each.key].name] 

  repository    = github_repository.repo[each.key].id
  variable_name = each.key
  value         = each.value
}

#Secrets
resource "github_actions_secret" "secret" {
  for_each = local.secrets[github_repository.repo[each.key].name] 

  repository      = github_repository.repo[each.key].id
  secret_name     = each.key
  # encrypted_value = each.value
  plaintext_value = each.value
}

#Labels
resource "github_issue_label" "labels" {
   for_each = toset(flatten([
    for repo_key, repo in var.repos : [
      for label_key, label in (repo.custom_labels != null ? repo.custom_labels : {}) : {
        repo_key    = repo_key
        label_key   = label_key
        label_value = label
      }
    ]
  ]))

  repository  = each.value.repo_key
  name        = each.value.label_value.name
  description = each.value.label_value.description
  color       = each.value.label_value.color
}
