#Repositories
locals {
  repo_names = { for repo_key, repo in var.repos :
    repo_key => "terraform-${var.terraform_provider}-${var.brand}-${repo.type}-${var.hive}-${repo.suffix}"
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
}

output "repos" {
  value       = local.repos
  description = "Repository Configuration"
}

resource "github_repository" "repo" {
  for_each = local.repos != {} ? local.repos : {}
  provider = github

  #Common
  name         = each.value.name
  description  = each.value.description
  homepage_url = each.value.url

  #General
  visibility      = each.value.private_enabled ? "private" : "public"
  has_issues      = each.value.issues_enabled
  has_discussions = each.value.discussions_enabled
  has_projects    = each.value.projects_enabled
  has_wiki        = each.value.wiki_enabled

  #Commits
  allow_merge_commit          = false
  allow_squash_merge          = true
  allow_rebase_merge          = false
  allow_auto_merge            = false
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  merge_commit_title          = "PR_TITLE"
  merge_commit_message        = "PR_BODY"
  delete_branch_on_merge      = true
  auto_init                   = true
  archive_on_destroy          = each.value.archive_enabled

  #Templates
  gitignore_template = "Terraform"
  license_template   = "mit"

  #Security
  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }
}
