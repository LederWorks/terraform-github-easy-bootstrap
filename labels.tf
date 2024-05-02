#Labels
locals {
  labels = {
    for repo_key, repo in var.repos : repo_key => merge(
      var.labels,
      repo.custom_labels
    )
  }

  flattened_labels = flatten([
    for repo_key, labels in local.labels : [
      for label_name, label in labels : {
        repo_name         = local.repo_names[repo_key] # This is the same as repository_id. Funnily this makes create_before_destroy operations to not function properly, as we should add a random element to the repository name, which we are not intended to do.
        label_name        = label_name
        label_color       = label.color
        label_description = label.description
        repository_id     = github_repository.repo[repo_key].id
      }
    ]
  ])
}

output "labels" {
  value       = local.labels
  description = "Normalized GitHub Issue Labels"
}

output "flattened_labels" {
  value       = local.flattened_labels
  description = "Flattened GitHub Issue Labels"
}

resource "github_issue_label" "label" {
  for_each    = { for label in local.flattened_labels : "${label.repo_name}_${label.label_name}" => label }
  repository  = each.value.repository_id
  name        = each.value.label_name
  color       = each.value.label_color
  description = each.value.label_description
}
