#Hives
output "hives" {
  value = module.github_bootstrap.hives
}

#Repositories
output "repos" {
  value = module.github_bootstrap.repos
}

#Inputs
output "variables" {
  value = module.github_bootstrap.variables
}
output "secrets" {
  value = module.github_bootstrap.secrets
}
