#Variables
/* resource "github_actions_variable" "variable" {
  for_each = local.variables

  repository    = github_repository.repo[each.key].id
  variable_name = each.key
  value         = each.value
} */

resource "github_actions_variable" "variable" {
  for_each      = { for variable in local.flattened_variables : "${variable.repo_name}_${variable.variable_name}" => variable }
  repository    = each.value.repository
  variable_name = each.value.variable_name
  value         = each.value.value
}

#Secrets
/* resource "github_actions_secret" "secret" {
  for_each = local.secrets

  repository      = github_repository.repo[each.key].id
  secret_name     = each.key
  plaintext_value = each.value
} */

resource "github_actions_secret" "secret" {
  for_each = { for secret in local.flattened_secrets : "${secret.repo_name}_${secret.secret_name}" => secret }

  repository      = each.value.repository_id
  secret_name     = each.value.secret_name
  plaintext_value = each.value.secret_value
}

#Labels
/* resource "github_issue_label" "labels" {
   for_each = { for item in flatten([
    for repo_key, repo in var.repos : [
      for label_key, label in (repo.custom_labels != null ? repo.custom_labels : {}) : {
        repo_key    = repo_key
        label_key   = label_key
        label_value = label
      }
    ]
  ]) : item.repo_key => item } # creating a map with repo_key as the key and the object as the value

  repository  = each.value.repo_key
  name        = each.value.label_value.name
  description = each.value.label_value.description
  color       = each.value.label_value.color
} */
