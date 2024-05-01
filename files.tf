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
        documentation_config = {
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
        documentation_header = {
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
        documentation_footer = {
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
            "${local.repo_names[repo_key]}-example-${example_key}-auth.tf" = {
              repository     = local.repo_names[repo_key]
              file           = "examples/${example.name}/auth.tf"
              content        = templatefile("${path.module}/templates/auth.tf.tftpl", {
                # Add the variables required for the auth.tf template here
              })
              commit_message = "Update example/${example.name}/auth.tf"
            }
          } : {},

          #context.tf
          example.context_deployed ? {
            "${local.repo_names[repo_key]}-example-${example_key}-context.tf" = {
              repository     = local.repo_names[repo_key]
              file           = "examples/${example.name}/context.tf"
              content        = templatefile("${path.module}/templates/context.tf.tftpl", {
                # Add the variables required for the context.tf template here
              })
              commit_message = "Deploy example/${example.name}/context.tf"
              overwrite      = false
            }
          } : {},

          #data.tf - always deploy when context deployed
          example.context_deployed || example.data_deployed ? {
            "${local.repo_names[repo_key]}-example-${example_key}-data.tf" = {
              repository     = local.repo_names[repo_key]
              file           = "examples/${example.name}/data.tf"
              content        = templatefile("${path.module}/templates/data.tf.tftpl", {
                # Add the variables required for the data.tf template here
              })
              commit_message = "Deploy example/${example.name}/data.tf"
              overwrite      = false
            }
          } : {},

          #locals.tf
          example.locals_deployed ? {
            "${local.repo_names[repo_key]}-example-${example_key}-locals.tf" = {
              repository     = local.repo_names[repo_key]
              file           = "examples/${example.name}/locals.tf"
              content        = templatefile("${path.module}/templates/locals.tf.tftpl", {
                # Add the variables required for the locals.tf template here
              })
              commit_message = "Deploy example/${example.name}/locals.tf"
              overwrite      = false
            }
          } : {},

          #main.tf
          example.main_deployed ? {
            "${local.repo_names[repo_key]}-example-${example_key}-main.tf" = {
              repository     = local.repo_names[repo_key]
              file           = "examples/${example.name}/main.tf"
              content        = templatefile("${path.module}/templates/main.tf.tftpl", {
                # Add the variables required for the main.tf template here
              })
              commit_message = "Deploy example/${example.name}/main.tf"
              overwrite      = false
            }
          } : {},

          #outputs.tf
          example.outputs_deployed ? {
            "${local.repo_names[repo_key]}-example-${example_key}-outputs.tf" = {
              repository     = local.repo_names[repo_key]
              file           = "examples/${example.name}/outputs.tf"
              content        = templatefile("${path.module}/templates/outputs.tf.tftpl", {
                # Add the variables required for the outputs.tf template here
              })
              commit_message = "Deploy example/${example.name}/outputs.tf"
              overwrite      = false
            }
          } : {},

          #terratest.yml
          example.terratest_enabled ? {
            "${local.repo_names[repo_key]}-example-${example_key}-terratest-${example.name}.yml" = {
              repository     = local.repo_names[repo_key]
              file           = ".github/workflows//terratest-${example.name}.yml"
              content        = templatefile("${path.module}/templates/terratest.yml.tftpl", {
                example = "${example.name}"
                terraform_version = coalesce(example.terraform_version, var.terraform_version)
                rgrp_name = "rgrp-tde3-ic-terratest-${var.terraform_provider}-${repo.type}-${var.hive}-${repo.suffix}"
              })
              commit_message = "Deploy example/${example.name}/terratest.yml"
            }
          } : {},

          #variables.tf - always deploy when context deployed
          example.context_deployed || example.variables_deployed ? {
            "${local.repo_names[repo_key]}-example-${example_key}-variables.tf" = {
              repository     = local.repo_names[repo_key]
              file           = "examples/${example.name}/variables.tf"
              content        = templatefile("${path.module}/templates/variables.tf.tftpl", {
                # Add the variables required for the variables.tf template here
              })
              commit_message = "Deploy example/${example.name}/variables.tf"
              overwrite      = false
            }
          } : {},
        ]
      ])...
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
