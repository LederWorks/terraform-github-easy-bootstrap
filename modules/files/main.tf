resource "github_repository_file" "file" {
  for_each = var.files != {} ? var.files : {}

  repository = each.value.repository
  file = each.value.file
  content = each.value.content
  branch = each.value.branch
  commit_author = each.value.commit_author
  commit_email = each.value.commit_email
  commit_message = each.value.commit_message
  overwrite_on_create = each.value.overwrite
}