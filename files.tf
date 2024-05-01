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
          commit_message = "Update .github/PULL_REQUEST_TEMPLATE.md"
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
          commit_message = "Update .github/SUPPORT.md"
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
          commit_message = "Update .github/workflows/documentation.yml"
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
          commit_message = "Update .config/.terraform-docs.yml"
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
          commit_message = "Update .config/header.txt"
        }
      } : {},

      repo.documentation.enabled ? {
        documentation_footer = {
          repository = local.repo_names[repo_key]
          file       = ".config/footer.txt"
          content = templatefile("${path.module}/templates/footer.txt.tftpl", {
            # Add the variables required for the footer.txt template here
          })
          commit_message = "Update .config/footer.txt"
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
          commit_message = "Update .github/workflows/release.yml"
        }
      } : {},

      repo.release.enabled ? {
        release_config = {
          repository = local.repo_names[repo_key]
          file       = ".github/gitversionconfig.yml"
          content = templatefile("${path.module}/templates/gitversionconfig.yml.tftpl", {
            # Add the variables required for the gitversionconfig.yml template here
          })
          commit_message = "Update .github/gitversionconfig.yml"
        }
      } : {},

      ### Files for each example
      flatten([
        for example_key, example in repo.examples : [

          #### Examples ####

          #auth.tf - deploy by default
          example.auth_enabled ? {
            "${local.repo_names[repo_key]}-example-${example_key}-auth.tf" = {
              repository = local.repo_names[repo_key]
              file       = "examples/${example.name}/auth.tf"
              content = templatefile("${path.module}/templates/auth.tf.tftpl", {
                # Add the variables required for the auth.tf template here
              })
              commit_message = "Update examples/${example.name}/auth.tf"
            }
          } : {},

          #context.tf - deploy when context_deployed = true
          example.context_deployed ? {
            "${local.repo_names[repo_key]}-example-${example_key}-context.tf" = {
              repository = local.repo_names[repo_key]
              file       = "examples/${example.name}/context.tf"
              content = templatefile("${path.module}/templates/context.tf.tftpl", {
                # Add the variables required for the context.tf template here
              })
              commit_message = "Deploy examples/${example.name}/context.tf"
              overwrite      = false
            }
          } : {},

          #data.tf - always deploy when context deployed
          example.context_deployed || example.data_deployed ? {
            "${local.repo_names[repo_key]}-example-${example_key}-data.tf" = {
              repository = local.repo_names[repo_key]
              file       = "examples/${example.name}/data.tf"
              content = templatefile("${path.module}/templates/data.tf.tftpl", {
                # Add the variables required for the data.tf template here
              })
              commit_message = "Deploy examples/${example.name}/data.tf"
              overwrite      = false
            }
          } : {},

          #dummy.tf - deployed when the terraform_provider is not azurerm - until other backends are configurable
          var.terraform_provider != "azurerm" || example.dummy_deployed ? {
            "${local.repo_names[repo_key]}-example-${example_key}-dummy.tf" = {
              repository = local.repo_names[repo_key]
              file       = "examples/${example.name}/dummy.tf"
              content = templatefile("${path.module}/templates/dummy.tf.tftpl", {
                resource_group_name = "rgrp-tde3-ic-terratest-${var.terraform_provider}-${repo.type}-${var.hive}-${repo.suffix}"
              })
              commit_message = "Deploy examples/${example.name}/dummy.tf"
              overwrite      = false
            }
          } : {},

          #locals.tf - deploy by default
          example.locals_deployed ? {
            "${local.repo_names[repo_key]}-example-${example_key}-locals.tf" = {
              repository = local.repo_names[repo_key]
              file       = "examples/${example.name}/locals.tf"
              content = templatefile("${path.module}/templates/locals.tf.tftpl", {
                # Add the variables required for the locals.tf template here
              })
              commit_message = "Deploy examples/${example.name}/locals.tf"
              overwrite      = false
            }
          } : {},

          #main.tf - deploy by default
          example.main_deployed ? {
            "${local.repo_names[repo_key]}-example-${example_key}-main.tf" = {
              repository = local.repo_names[repo_key]
              file       = "examples/${example.name}/main.tf"
              content = templatefile("${path.module}/templates/main.tf.tftpl", {
                resource_group_name     = "rgrp-tde3-ic-terratest-${var.terraform_provider}-${repo.type}-${var.hive}-${repo.suffix}"
                resource_group_location = "germanywestcentral"
                module_name             = "${var.terraform_provider}-${repo.type}-${var.hive}-${repo.suffix}"
                module_repository       = "${local.repo_names[repo_key]}"
              })
              commit_message = "Deploy examples/${example.name}/main.tf"
              overwrite      = false
            }
          } : {},

          #outputs.tf - deploy by default
          example.outputs_deployed ? {
            "${local.repo_names[repo_key]}-example-${example_key}-outputs.tf" = {
              repository = local.repo_names[repo_key]
              file       = "examples/${example.name}/outputs.tf"
              content = templatefile("${path.module}/templates/outputs.tf.tftpl", {
                # Add the variables required for the outputs.tf template here
              })
              commit_message = "Deploy examples/${example.name}/outputs.tf"
              overwrite      = false
            }
          } : {},

          #variables.tf - always deploy when context deployed
          example.context_deployed || example.variables_deployed ? {
            "${local.repo_names[repo_key]}-example-${example_key}-variables.tf" = {
              repository = local.repo_names[repo_key]
              file       = "examples/${example.name}/variables.tf"
              content = templatefile("${path.module}/templates/variables.tf.tftpl", {
                # Add the variables required for the variables.tf template here
              })
              commit_message = "Deploy examples/${example.name}/variables.tf"
              overwrite      = false
            }
          } : {},

          #### Terratest ####

          #terratest.yml - deploy by default
          example.terratest_enabled ? {
            "${local.repo_names[repo_key]}-example-${example_key}-terratest-${example.name}.yml" = {
              repository = local.repo_names[repo_key]
              file       = ".github/workflows/terratest-${example.name}.yml"
              content = templatefile("${path.module}/templates/terratest.yml.tftpl", {
                example             = "${example.name}"
                terraform_version   = coalesce(example.terraform_version, var.terraform_version)
                resource_group_name = "rgrp-tde3-ic-terratest-${var.terraform_provider}-${repo.type}-${var.hive}-${repo.suffix}"
              })
              commit_message = "Deploy .github/workflows/terratest-${example.name}.yml"
            }
          } : {},

          #module_test.go - deploy terratest_enabled = true
          example.terratest_enabled ? {
            "${local.repo_names[repo_key]}-test-${example_key}-module_test.go" = {
              repository = local.repo_names[repo_key]
              file       = ".test/${example.name}/module_test.go"
              content = templatefile("${path.module}/templates/module_test.go.tftpl", {
                example              = "${example.name}"
                resource_group_name  = "rgrp-pde3-it-terratest"
                storage_account_name = "saccpde3itterratest001"
                container_name       = "terratest-${var.terraform_provider}"
                key                  = "${var.brand}-${repo.type}-${var.hive}-${repo.suffix}.${example.name}.tfstate"
                snapshot             = "true"
                use_azuread_auth     = "true"
              })
              commit_message = "Deploy .test/${example.name}/module_test.go"
            }
          } : {},


          #go.mod - deploy by default
          example.terratest_enabled ? {
            "${local.repo_names[repo_key]}-test-${example_key}-go.mod" = {
              repository = local.repo_names[repo_key]
              file       = ".test/${example.name}/go.mod"
              content = templatefile("${path.module}/templates/go.mod.tftpl", {
                module_name = local.repo_names[repo_key]
                example = "${example.name}"
              })
              commit_message = "Deploy .test/${example.name}/go.mod"
            }
          } : {},


          #go.sum - deploy by default
          example.terratest_enabled ? {
            "${local.repo_names[repo_key]}-test-${example_key}-go.sum" = {
              repository = local.repo_names[repo_key]
              file       = ".test/${example.name}/go.sum"
              content = templatefile("${path.module}/templates/go.sum.tftpl", {
                # Add the variables required for the go.sum template here
              })
              commit_message = "Deploy .test/${example.name}/go.sum"
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
