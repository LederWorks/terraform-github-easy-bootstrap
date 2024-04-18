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
      custom_teams     = repo.custom_teams
      custom_variables = repo.custom_variables
      custom_secrets   = repo.custom_secrets
      custom_labels    = repo.custom_labels
    }
  } : {}

}