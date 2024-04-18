#Hives
output "hives" {
  value = local.hives
}

#Repositories
output "repos" {
  value = local.repos
}

#Inputs
output "variables" {
  value = local.variables
}
output "variables2" {
  value = local.flattened_variables
}
output "secrets" {
  value = local.secrets
}
output "secrets2" {
  value = local.flattened_secrets

}