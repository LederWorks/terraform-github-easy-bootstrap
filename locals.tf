locals {
  #Hives
  hive_names = { for hive_key, hive in var.hives :
    hive_key => "${hive.provider}-${hive.hive}"
  }

  hives = var.hives != {} ? {
    for hive_key, hive in var.hives : hive_key => {
      name      = local.hive_names[hive_key]
      members   = hive.members
      variables = hive.variables
      secrets   = hive.secrets
      labels    = hive.labels
    }
  } : {}

  #Repositories
  repo_names = { for repo_key, repo in var.repos :
    repo_key => "${repo.name.language}-${repo.name.provider}-${repo.name.infix}-${repo.name.type}-${repo.name.hive}-${repo.name.suffix}"
  }

  repos = var.repos != {} ? {
    for repo_key, repo in var.repos : repo_key => {
      name             = local.repo_names[repo_key]
      private          = repo.private
      project_enabled  = repo.project_enabled
      custom_teams     = repo.custom_teams
      custom_variables = repo.custom_variables
      custom_secrets   = repo.custom_secrets
      custom_labels    = repo.custom_labels
    }
  } : {}

}