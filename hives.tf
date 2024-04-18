#Teams
resource "github_team" "team" {
  for_each = local.hives != {} ? local.hives : {}

  name                      = each.value.name
  description               = each.value.description
  privacy                   = "closed"
  create_default_maintainer = true
}