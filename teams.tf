# $$\      $$\                         $$\                                     
# $$$\    $$$ |                        $$ |                                    
# $$$$\  $$$$ | $$$$$$\  $$$$$$\$$$$\  $$$$$$$\   $$$$$$\   $$$$$$\   $$$$$$$\ 
# $$\$$\$$ $$ |$$  __$$\ $$  _$$  _$$\ $$  __$$\ $$  __$$\ $$  __$$\ $$  _____|
# $$ \$$$  $$ |$$$$$$$$ |$$ / $$ / $$ |$$ |  $$ |$$$$$$$$ |$$ |  \__|\$$$$$$\  
# $$ |\$  /$$ |$$   ____|$$ | $$ | $$ |$$ |  $$ |$$   ____|$$ |       \____$$\ 
# $$ | \_/ $$ |\$$$$$$$\ $$ | $$ | $$ |$$$$$$$  |\$$$$$$$\ $$ |      $$$$$$$  |
# \__|     \__| \_______|\__| \__| \__|\_______/  \_______|\__|      \_______/ 

#### Hive Contributors
resource "github_team" "contributors" {
  name                      = "${var.terraform_provider}-${var.hive}-contributors"
  description               = "Contributors for the ${var.terraform_provider}-${var.hive} hive."
  privacy                   = "closed"
  create_default_maintainer = true
}

resource "github_team_members" "contributors" {
  team_id = github_team.contributors.id
  dynamic "members" {
    for_each = var.contributors
    content {
      username = members.value
      role     = "member"
    }
  }
}

#### Hive Approvers
resource "github_team" "approvers" {
  name                      = "${var.terraform_provider}-${var.hive}-approvers"
  description               = "Approvers of the ${var.terraform_provider}-${var.hive} hive."
  privacy                   = "closed"
  create_default_maintainer = true
}

resource "github_team_members" "approvers" {
  team_id = github_team.approvers.id
  dynamic "members" {
    for_each = var.approvers
    content {
      username = members.value
      role     = "member"
    }
  }
}

#### Hive Admins
resource "github_team" "admins" {
  name                      = "${var.terraform_provider}-${var.hive}-admins"
  description               = "Admins of the ${var.terraform_provider}-${var.hive} hive."
  privacy                   = "closed"
  create_default_maintainer = true
}
resource "github_team_members" "admins" {
  team_id = github_team.admins.id
  dynamic "members" {
    for_each = var.admins
    content {
      username = members.value
      role     = "maintainer"
    }
  }
}
