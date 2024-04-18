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
  allow_merge_commit          = true
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
    advanced_security {
      status = "enabled"
    }
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }
}