locals {

  #Hives
  hive_names = { for hive_key, hive in var.hives :
    hive_key => "${var.terraform_provider}-${hive.hive}"
  }

  hives = var.hives != {} ? {
    for hive_key, hive in var.hives : hive_key => {
      name         = local.hive_names[hive_key]
      approvers    = hive.approvers
      contributors = hive.contributors
    }
  } : {}

  #Repositories
  repo_names = { for repo_key, repo in var.repos :
    repo_key => "${repo.name.language}-${var.terraform_provider}-${var.brand}-${repo.name.type}-${repo.name.hive}-${repo.name.suffix}"
  }

  repos = var.repos != {} ? {
    for repo_key, repo in var.repos : repo_key => {
      #Common
      name        = local.repo_names[repo_key]
      description = repo.description
      url         = repo.url
      #General
      private_enabled     = repo.private_enabled
      issues_enabled      = repo.issues_enabled
      discussions_enabled = repo.discussions_enabled
      projects_enabled    = repo.projects_enabled
      wiki_enabled        = repo.wiki_enabled
      archive_enabled     = repo.archive_enabled
      #Custom Inputs
      custom_variables = repo.custom_variables
      custom_secrets   = repo.custom_secrets
      custom_labels    = repo.custom_labels
    }
  } : {}

  #Variables
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

  #Secrets
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