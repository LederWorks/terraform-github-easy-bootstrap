#### Provider Default Team
resource "github_team" "team" {
  name                      = "${var.terraform_provider}-team"
  description               = "${var.terraform_provider} team"
  privacy                   = "closed"
  create_default_maintainer = true
}
resource "github_team_members" "team" {
  team_id = github_team.team.id
  dynamic "members" {
    for_each = var.members
    content {
      username = members.value
      role     = "member"
    }
  }
}

#### Provider Admins
resource "github_team" "admins" {
  name                      = "${var.terraform_provider}-admins"
  description               = "Admins of the ${var.terraform_provider} provider"
  privacy                   = "closed"
  create_default_maintainer = true
}
resource "github_team_members" "admins" {
  count   = var.admins != [] ? 1 : 0
  team_id = github_team.admins.id
  dynamic "members" {
    for_each = var.admins
    content {
      username = members.value
      role     = "maintainer"
    }
  }
}

#### Hive Approvers
resource "github_team" "approvers" {
  for_each = local.hives != {} ? local.hives : {}

  name                      = "${each.value.name}-approvers"
  description               = "Approvers of the ${each.value.name} hive"
  privacy                   = "closed"
  create_default_maintainer = true
}
resource "github_team_members" "approvers" {
  for_each = local.hives != {} ? local.hives : {}

  team_id = github_team.approvers[each.key].id
  dynamic "members" {
    for_each = each.value.members
    content {
      username = members.value
      role     = "member"
    }
  }
}

#### Hive Contributors
resource "github_team" "contributors" {
  for_each = local.hives != {} ? local.hives : {}

  name                      = "${each.value.name}-contributors"
  description               = "Contributors for the ${each.value.name} hive"
  privacy                   = "closed"
  create_default_maintainer = true
}
resource "github_team_members" "members" {
  for_each = local.hives != {} ? local.hives : {}

  team_id = github_team.contributors[each.key].id
  dynamic "members" {
    for_each = each.value.members
    content {
      username = members.value
      role     = "member"
    }
  }
}
