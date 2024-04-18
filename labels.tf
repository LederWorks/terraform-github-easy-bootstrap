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
        repo_key          = repo_key
        label_name        = label_name
        label_color       = label.color
        label_description = label.description
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

resource "github_repository_label" "label" {
  for_each = { for label in local.flattened_labels : "${label.repo_key}_${label.label_name}" => label }

  repository  = each.value.repo_key
  name        = each.value.label_name
  color       = each.value.label_color
  description = each.value.label_description
}

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
