#Variables
locals {
  variables = {
    for repo_key, repo in var.repos : repo_key => merge(
      var.variables,
      repo.custom_variables
    )
  }

  flattened_variables = flatten([
    for repo_key, variables in local.variables : [
      for variable_name, variable_value in variables : {
        repo_name      = repo_key
        variable_name  = variable_name
        variable_value = variable_value
        repository_id  = github_repository.repo[repo_key].id
      }
    ]
  ])
}

output "variables" {
  value       = local.variables
  description = "Normalized GitHub Actions Variables"
}

output "flattened_variables" {
  value       = local.flattened_variables
  description = "Flattened GitHub Actions Variables"
}

resource "github_actions_variable" "variable" {
  for_each      = { for variable in local.flattened_variables : "${variable.repo_name}_${variable.variable_name}" => variable }
  repository    = each.value.repository_id
  variable_name = each.value.variable_name
  value         = each.value.variable_value
}