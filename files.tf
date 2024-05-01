#Orchestrated content files
locals {

  files = var.repos != {} ? {
    for repo_key, repo in var.repos : repo_key => merge(
      #### PR Template ####
      repo.pr_template.enabled ? {
        pr_template = {
          repository = local.repo_names[repo_key]
          file       = ".github/PULL_REQUEST_TEMPLATE.md"
          content = templatefile("${path.module}/templates/pull_request_template.md.tftpl", {
            # Add the variables required for the footer.txt template here
          })
          commit_message = "Update PULL_REQUEST_TEMPLATE.md"
        }
      } : {},

      #### Support Template ####
      repo.support.enabled ? {
        support = {
          repository = local.repo_names[repo_key]
          file       = ".github/SUPPORT.md"
          content = templatefile("${path.module}/templates/support.md.tftpl", {
            # Add the variables required for the footer.txt template here
          })
          commit_message = "Update SUPPORT.md"
        }
      } : {},

      #### Documentation ####
      repo.documentation.enabled ? {
        documentation = {
          repository = local.repo_names[repo_key]
          file       = ".github/workflows/documentation.yml"
          content = templatefile("${path.module}/templates/documentation.yml.tftpl", {
            output_file   = repo.documentation.output_file
            output_format = repo.documentation.output_format
          })
          commit_message = "Update documentation.yml"
        }
      } : {},

      repo.documentation.enabled ? {
        documentation-config = {
          repository = local.repo_names[repo_key]
          file       = ".config/.terraform-docs.yml"
          content = templatefile("${path.module}/templates/.terraform-docs.yml.tftpl", {
            output_format = repo.documentation.output_format
            #Content
            inputs               = repo.documentation.inputs_enabled ? "- inputs" : null
            inputs_enabled       = repo.documentation.inputs_enabled
            outputs              = repo.documentation.outputs_enabled ? "- outputs" : null
            outputs_enabled      = repo.documentation.outputs_enabled
            providers            = repo.documentation.providers_enabled ? "- providers" : null
            providers_enabled    = repo.documentation.providers_enabled
            requirements         = repo.documentation.requirements_enabled ? "- requirements" : null
            requirements_enabled = repo.documentation.requirements_enabled
            resources            = repo.documentation.resources_enabled ? "- resources" : null
            resources_enabled    = repo.documentation.resources_enabled
            #Config
            anchor      = repo.documentation.anchor_enabled
            default     = repo.documentation.default_enabled
            description = repo.documentation.description_enabled
            escape      = repo.documentation.escape_enabled
            hide_empty  = repo.documentation.hide_empty_enabled
            html        = repo.documentation.html_enabled
            indent      = repo.documentation.indent
            lockfile    = repo.documentation.lockfile_enabled
            required    = repo.documentation.required_enabled
            sensitive   = repo.documentation.sensitive_enabled
            type        = repo.documentation.type_enabled
          })
          commit_message = "Update .terraform-docs.yml"
        }
      } : {},

      repo.documentation.enabled ? {
        documentation-header = {
          repository = local.repo_names[repo_key]
          file       = ".config/header.txt"
          content = templatefile("${path.module}/templates/header.txt.tftpl", {
            organization = var.organization
            brand        = var.brand
            provider     = var.terraform_provider
            type         = repo.type
            hive         = var.hive
            suffix       = repo.suffix
            about        = repo.documentation.about
          })
          commit_message = "Update header.txt"
        }
      } : {},

      repo.documentation.enabled ? {
        documentation-footer = {
          repository = local.repo_names[repo_key]
          file       = ".config/footer.txt"
          content = templatefile("${path.module}/templates/footer.txt.tftpl", {
            # Add the variables required for the footer.txt template here
          })
          commit_message = "Update footer.txt"
        }
      } : {},

      #### Release ####
      repo.release.enabled ? {
        release = {
          repository = local.repo_names[repo_key]
          file       = ".github/workflows/release.yml"
          content = templatefile("${path.module}/templates/release.yml.tftpl", {
            # Add the variables required for the release.yml template here
          })
          commit_message = "Update release.yml"
        }
      } : {},

      repo.release.enabled ? {
        release_config = {
          repository = local.repo_names[repo_key]
          file       = ".github/gitversionconfig.yml"
          content = templatefile("${path.module}/templates/gitversionconfig.yml.tftpl", {
            # Add the variables required for the gitversionconfig.yml template here
          })
          commit_message = "Update gitversionconfig.yml"
        }
      } : {},

      #### Examples ####
      flatten([
        for example_key, example in repo.examples : [

          #auth.tf
          example.auth_enabled ? {
            "${repo_key}-${example_key}-auth" = {
              repository     = local.repo_names[repo_key]
              file           = "examples/${example.name}/auth.tf"
              content        = templatefile("${path.module}/templates/auth.tf.tftpl", {
                # Variables for auth.tf template here
              })
              commit_message = "Add auth.tf to example/${example.name}"
            }
          } : {},

          #context.tf
          example.context_deployed ? {
            "${repo_key}-${example_key}-context" = {
              repository     = local.repo_names[repo_key]
              file           = "examples/${example.name}/context.tf"
              content        = templatefile("${path.module}/templates/context.tf.tftpl", {
                # Variables for context.tf template here
              })
              commit_message = "Add context.tf to example/${example.name}"
              overwrite      = false
            }
          } : {},

          #data.tf - always deploy when context deployed
          example.context_deployed || example.data_deployed ? {
            "${repo_key}-${example_key}-data" = {
              repository     = local.repo_names[repo_key]
              file           = "examples/${example.name}/data.tf"
              content        = templatefile("${path.module}/templates/data.tf.tftpl", {
                # Variables for data.tf template here
              })
              commit_message = "Add data.tf to example/${example.name}"
              overwrite      = false
            }
          } : {},

          #locals.tf
          example.locals_deployed ? {
            "${repo_key}-${example_key}-locals" = {
              repository     = local.repo_names[repo_key]
              file           = "examples/${example.name}/locals.tf"
              content        = templatefile("${path.module}/templates/locals.tf.tftpl", {
                # Variables for locals.tf template here
              })
              commit_message = "Add locals.tf to example/${example.name}"
              overwrite      = false
            }
          } : {},

          #main.tf
          example.main_deployed ? {
            "${repo_key}-${example_key}-main" = {
              repository     = local.repo_names[repo_key]
              file           = "examples/${example.name}/main.tf"
              content        = templatefile("${path.module}/templates/main.tf.tftpl", {
                # Variables for main.tf template here
              })
              commit_message = "Add main.tf to example/${example.name}"
              overwrite      = false
            }
          } : {},

          #outputs.tf
          example.outputs_deployed ? {
            "${repo_key}-${example_key}-outputs" = {
              repository     = local.repo_names[repo_key]
              file           = "examples/${example.name}/outputs.tf"
              content        = templatefile("${path.module}/templates/outputs.tf.tftpl", {
                # Variables for outputs.tf template here
              })
              commit_message = "Add outputs.tf to example/${example.name}"
              overwrite      = false
            }
          } : {},

          #variables.tf - always deploy when context deployed
          example.context_deployed || example.variables_deployed ? {
            "${repo_key}-${example_key}-variables" = {
              repository     = local.repo_names[repo_key]
              file           = "examples/${example.name}/variables.tf"
              content        = templatefile("${path.module}/templates/variables.tf.tftpl", {
                # Variables for variables.tf template here
              })
              commit_message = "Add variables.tf to example/${example.name}"
              overwrite      = false
            }
          } : {},
        ]
      ])...

      /* {
        for example_key, example in repo.examples : "${repo_key}-${example_key}" => {
          #auth.tf
          auth = example.auth_enabled ? {
            repository     = local.repo_names[repo_key]
            file           = "examples/${example.name}/auth.tf"
            content        = templatefile("${path.module}/templates/auth.tf.tftpl", {
              # Variables for auth.tf template here
            })
            commit_message = "Add auth.tf to example/${example.name}"
          } : {},

          #context.tf
          context = example.context_enabled ? {
            repository     = local.repo_names[repo_key]
            file           = "examples/${example.name}/context.tf"
            content        = templatefile("${path.module}/templates/context.tf.tftpl", {
              # Variables for context.tf template here
            })
            commit_message = "Add context.tf to example/${example.name}"
            overwrite      = false
          } : {},

          #data.tf
          data = example.data_enabled ? {
            repository     = local.repo_names[repo_key]
            file           = "examples/${example.name}/data.tf"
            content        = templatefile("${path.module}/templates/data.tf.tftpl", {
              # Variables for data.tf template here
            })
            commit_message = "Add data.tf to example/${example.name}"
            overwrite      = false
          } : {},

          #locals.tf
          locals = example.locals_enabled ? {
            repository     = local.repo_names[repo_key]
            file           = "examples/${example.name}/locals.tf"
            content        = templatefile("${path.module}/templates/locals.tf.tftpl", {
              # Variables for locals.tf template here
            })
            commit_message = "Add locals.tf to example/${example.name}"
            overwrite      = false
          } : {},

          #main.tf
          main = example.main_enabled ? {
            repository     = local.repo_names[repo_key]
            file           = "examples/${example.name}/main.tf"
            content        = templatefile("${path.module}/templates/main.tf.tftpl", {
              # Variables for main.tf template here
            })
            commit_message = "Add main.tf to example/${example.name}"
            overwrite      = false
          } : {},

          #outputs.tf
          outputs = example.outputs_enabled ? {
            repository     = local.repo_names[repo_key]
            file           = "examples/${example.name}/outputs.tf"
            content        = templatefile("${path.module}/templates/outputs.tf.tftpl", {
              # Variables for outputs.tf template here
            })
            commit_message = "Add outputs.tf to example/${example.name}"
            overwrite      = false
          } : {},

          #variables.tf
          variables = example.variables_enabled ? {
            repository     = local.repo_names[repo_key]
            file           = "examples/${example.name}/variables.tf"
            content        = templatefile("${path.module}/templates/variables.tf.tftpl", {
              # Variables for variables.tf template here
            })
            commit_message = "Add variables.tf to example/${example.name}"
            overwrite      = false
          } : {},
        }
      } */

    )
  } : {}
}

#Files Module
module "files" {
  for_each   = local.files
  source     = "./modules/files"
  depends_on = [github_repository.repo]
  files      = each.value
}
