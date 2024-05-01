#Repositories
output "repos" {
  value = module.github_bootstrap.repos
}

#Variables
/* output "variables" {
  value = module.github_bootstrap.variables
}
output "flattened_variables" {
  value = module.github_bootstrap.flattened_variables
} */

#Secrets
/* output "secrets" {
  value = module.github_bootstrap.secrets
}
output "flattened_secrets" {
  value = module.github_bootstrap.flattened_secrets
} */

#Labels
output "labels" {
  value = module.github_bootstrap.labels
}
output "flattened_labels" {
  value = module.github_bootstrap.flattened_labels
}
