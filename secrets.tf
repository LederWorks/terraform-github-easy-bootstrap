#Secrets
locals {
  secrets = {
    for repo_key, repo in var.repos : repo_key => merge(
      var.secrets,
      repo.custom_secrets
    )
  }

  flattened_secrets = flatten([
    for repo_key, secrets in local.secrets : [
      for secret_name, secret_value in secrets : {
        repo_name     = repo_key
        secret_name   = secret_name
        secret_value  = secret_value
        repository_id = github_repository.repo[repo_key].id
      }
    ]
  ])
}

# output "secrets" {
#   value       = local.secrets
#   description = "Normalized GitHub Actions Secrets"
# }

# output "flattened_secrets" {
#   value       = local.flattened_secrets
#   description = "Flattened GitHub Actions Secrets"
# }

resource "github_actions_secret" "secret" {
  for_each        = { for secret in local.flattened_secrets : "${secret.repo_name}_${secret.secret_name}" => secret }
  repository      = each.value.repository_id
  secret_name     = each.value.secret_name
  plaintext_value = each.value.secret_value
}
