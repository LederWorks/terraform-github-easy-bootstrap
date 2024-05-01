#Orchestrated content files
locals {
  files = var.repos != {} ? {
    for repo_key, repo in var.repos : repo_key => merge(
      #Documentation
      repo.documentation.enabled ? {
        documentation = {
          repository     = local.repo_names[repo_key]
          file           = ".github/workflows/documentation.yml"
          content        = templatefile("${path.module}/templates/documentation.yml.tpl", {
            output_file   = repo.documentation.output_file
            output_format = repo.documentation.output_format
          })
          commit_message = "Update documentation.yml"
        }
        } : {},

        repo.documentation.enabled ? {
        documentation-config = {
          repository     = local.repo_names[repo_key]
          file           = ".config/.terraform-docs.yml"
          content        = templatefile("${path.module}/templates/.terraform-docs.yml.tpl", {
            output_format = repo.documentation.output_format
          })
          commit_message = "Update .terraform-docs.yml"
        }
      } : {},

      #Release
      repo.release.enabled ? {
        release = {
          repository     = local.repo_names[repo_key]
          file           = ".github/workflows/release.yml"
          content        = templatefile("${path.module}/templates/release.yml.tpl", {
            # Add the variables required for the release.yml template here
          })
          commit_message = "Update release.yml"
        }
      } : {},

      repo.release.enabled ? {
        release_config = {
          repository     = local.repo_names[repo_key]
          file           = ".github/gitversionconfig.yml"
          content        = templatefile("${path.module}/templates/gitversionconfig.yml.tpl", {
            # Add the variables required for the .github/gitversionconfig.yml template here
          })
          commit_message = "Update gitversionconfig.yml"
        }
      } : {}
      )
    } : {}
}

#Files Module
module "files" {
  for_each = local.files
  source = "./modules/files"
  files = each.value
}



#Examples
/* data "template_file" "auth" {
  for_each = local.files
  template = file("${path.module}/templates/auth.tf.tpl")
  vars = {
    
  }

} */