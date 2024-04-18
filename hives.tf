#Hives
locals {
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
}

output "hives" {
  value       = local.hives
  description = "Hive Configuration"
}
