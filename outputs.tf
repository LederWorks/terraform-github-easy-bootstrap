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
output "secrets" {
  value = local.secrets
  
}