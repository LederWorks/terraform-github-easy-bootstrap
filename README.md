<!-- BEGIN_TF_DOCS -->
<!-- markdownlint-disable-file MD033 MD012 -->
# terraform-github-easy-bootstrap
LederWorks Easy Github Bootstrap Module

This module were created by [LederWorks](https://lederworks.com) IaC enthusiasts.

## About This Module
This module has been mainly designed and developed to bootstrap terraform module repositories, however it can be used for any github repository.

## How to Use This Modul
- Ensure Github credentials are [in place](https://registry.terraform.io/providers/integrations/github/latest/docs#authentication)
- Admin role or equivalent is required!
- Create a Terraform configuration that pulls in this module and specifies values for the required variables.

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.3.6)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 3.61.0)

- <a name="requirement_github"></a> [github](#requirement\_github) (>= 6.2.1)

## Providers

The following providers are used by this module:

- <a name="provider_github"></a> [github](#provider\_github) (>= 6.2.1)

## Examples

### Example 1
```hcl
# Module Test
module "github_bootstrap" {
  source = "../.."

  #### Common Variables
  terraform_provider = "mastiff"
  brand              = "ezpz"
  hive               = "rainbow"

  #### Members
  contributors = local.all_members
  approvers    = ["Dilergore"]
  admins       = ["Ledermayer"]

  #### Set Inputs
  variables = {
    one = "pici"
    dog = "tej"
  }

  secrets = {
    my  = "verysecret"
    not = "yoursecret"
  }

  labels = {
    one = {
      name        = "one"
      color       = "0000Ff"
      description = "blue"
    }
    two = {
      name        = "two"
      color       = "ff00ff"
      description = "magenta"
    }
  }

  repos = {
    #All customization options with Pink
    pink = {
      #Common
      type        = "engine"
      suffix      = "pink"
      description = "Mastiff Rainbow Engine Pink Module"
      url         = null

      #General
      private_enabled     = false
      issues_enabled      = true
      discussions_enabled = false
      projects_enabled    = false
      wiki_enabled        = false
      archive_enabled     = false

      #Custom Inputs
      custom_variables = {
        wait  = "babám"
        never = "menjel"
      }

      custom_secrets = {
        their = "regret"
        our   = "szeglet"
      }

      custom_labels = {
        three = {
          name        = "three"
          color       = "Ff0000"
          description = "red"
        }
        four = {
          name        = "four"
          color       = "00ff00"
          description = "green"
        }
      }

      #Documentation
      documentation = {
        #General
        enabled       = true
        output_file   = "USAGE.md"
        output_format = "markdown table"

        #Content
        about = "This is a pink engine module"
        # inputs_enabled    = false #Defaults to true
        # outputs_enabled   = false #Defaults to true
        # providers_enabled = false #Defaults to true
        required_enabled = false #Defaults to true
        # resources_enabled = false #Defaults to true

        #Config
        # anchor_enabled      = false #Defaults to true
        # default_enabled     = false #Defaults to true
        # description_enabled = false #Defaults to true
        # escape_enabled      = false #Defaults to true
        hide_empty_enabled = true #Defaults to false
        # html_enabled        = false #Defaults to true
        indent = 4 #Defaults to 2
        # lockfile_enabled    = true  #Defaults to false
        required_enabled = false #Defaults to true
        # sensitive_enabled   = false #Defaults to true
        # type_enabled        = false #Defaults to true
      }
    }

    #Do not deploy release content for Purple
    /* purple = {
      type   = "brick"
      suffix = "purple"
      documentation = {
        enabled = true
        about   = "This is a purple brick module"
      }
      release = {
        enabled = false
      }
    } */

    #Customize Examples
    violet = {
      type   = "block"
      suffix = "violet"
      examples = {
        everest = {
          name = "01-everest"
          description = "Everest is the highest mountain in the world"
          context_deployed = true
        }

        kaytoo = {
          name = "02-kaytoo"
          description = "K2 is the second highest mountain in the world"
        }

        kangchenjunga = {
          name = "03-kangchenjunga"
          description = "Kangchenjunga is the third highest mountain in the world"
          context_deployed = true
        }
      }
    }

    #Let's add some load
    /* brown = {
      type   = "wrapper"
      suffix = "brown"
    }

    orange = {
      type   = "accelerator"
      suffix = "orange"
    }

    green = {
      type   = "tool"
      suffix = "green"
    }

    black = {
      type   = "context"
      suffix = "black"
    } */
  }
}

```

## Resources

The following resources are used by this module:

- [github_actions_secret.secret](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) (resource)
- [github_actions_variable.variable](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable) (resource)
- [github_issue_label.label](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) (resource)
- [github_repository.repo](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) (resource)
- [github_team.admins](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) (resource)
- [github_team.approvers](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) (resource)
- [github_team.contributors](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) (resource)
- [github_team_members.admins](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members) (resource)
- [github_team_members.approvers](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members) (resource)
- [github_team_members.contributors](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_admins"></a> [admins](#input\_admins)

Description: (Required) Admins of the hive team.

Type: `set(string)`

### <a name="input_approvers"></a> [approvers](#input\_approvers)

Description: (Required) Approvers of the hive team.

Type: `set(string)`

### <a name="input_contributors"></a> [contributors](#input\_contributors)

Description: (Required) Contributors of the hive team.

Type: `set(string)`

### <a name="input_hive"></a> [hive](#input\_hive)

Description: (Required) The name of the hive, such as compute, network, security etc.

Type: `string`

### <a name="input_terraform_provider"></a> [terraform\_provider](#input\_terraform\_provider)

Description: (Required) The terraform provider to be bootstrapped, such as azurerm, google, aws etc.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_brand"></a> [brand](#input\_brand)

Description: (Optional) The brand name to be used in the nomenclature. This appears as an infix in the repository name.

Type: `string`

Default: `"easy"`

### <a name="input_labels"></a> [labels](#input\_labels)

Description:   (Optional) A map of labels to be created for all hive repositories. The labels object supports the following:

  name        - (Required) The name of the label.  
  color       - (Required) The color of the label.  
  description - (Optional) The description of the label.

Type:

```hcl
map(object({
    name        = string
    color       = string
    description = optional(string)
  }))
```

Default: `{}`

### <a name="input_organization"></a> [organization](#input\_organization)

Description: (Required) The name of the organization to create the repositories in.

Type: `string`

Default: `"LederWorks"`

### <a name="input_repo_purpose"></a> [repo\_purpose](#input\_repo\_purpose)

Description: Purpose of the repositories, such as module, infra, etc.

Type: `string`

Default: `"module"`

### <a name="input_repos"></a> [repos](#input\_repos)

Description:   A map of repositories and associated configurations to be created. The repos object support the following:

  type        - (Required) The type of the repository.  
  suffix      - (Required) The suffix of the repository.  
  description - (Optional) The description of the repository.  
  url         - (Optional) The URL of the repository.

  private\_enabled     - (Optional) Whether the repository is private. Defaults to false.  
  issues\_enabled      - (Optional) Whether issues are enabled. Defaults to true.  
  discussions\_enabled - (Optional) Whether discussions are enabled. Defaults to false.  
  projects\_enabled    - (Optional) Whether projects are enabled. Defaults to false.  
  wiki\_enabled        - (Optional) Whether the wiki is enabled. Defaults to false.  
  archive\_enabled     - (Optional) Whether the repository is archived. Defaults to false.

  custom\_variables - (Optional) A map of custom variables to be added to the repository.  
  custom\_secrets   - (Optional) A map of custom secrets to be added to the repository.  
  custom\_labels    - (Optional) A map of custom labels to be added to the repository. The custom\_labels object supports the following:

    name        - (Required) The name of the label.  
    color       - (Required) The color of the label.  
    description - (Optional) The description of the label.

Type:

```hcl
map(object({
    ### Common
    type        = string
    suffix      = string
    description = optional(string)
    url         = optional(string)
    ### General
    private_enabled     = optional(bool, false)
    issues_enabled      = optional(bool, true)
    discussions_enabled = optional(bool, false)
    projects_enabled    = optional(bool, false)
    wiki_enabled        = optional(bool, false)
    archive_enabled     = optional(bool, false)
    ### Custom Inputs
    custom_variables = optional(map(string), {})
    custom_secrets   = optional(map(string), {})
    custom_labels = optional(map(object({
      name        = string
      color       = string
      description = optional(string)
    })), {})

    # $$$$$$$$\                                $$\            $$\                         
    # \__$$  __|                               $$ |           $$ |                        
    #    $$ | $$$$$$\  $$$$$$\$$$$\   $$$$$$\  $$ | $$$$$$\ $$$$$$\    $$$$$$\   $$$$$$$\
    #    $$ |$$  __$$\ $$  _$$  _$$\ $$  __$$\ $$ | \____$$\\_$$  _|  $$  __$$\ $$  _____|
    #    $$ |$$$$$$$$ |$$ / $$ / $$ |$$ /  $$ |$$ | $$$$$$$ | $$ |    $$$$$$$$ |\$$$$$$\  
    #    $$ |$$   ____|$$ | $$ | $$ |$$ |  $$ |$$ |$$  __$$ | $$ |$$\ $$   ____| \____$$\
    #    $$ |\$$$$$$$\ $$ | $$ | $$ |$$$$$$$  |$$ |\$$$$$$$ | \$$$$  |\$$$$$$$\ $$$$$$$  |
    #    \__| \_______|\__| \__| \__|$$  ____/ \__| \_______|  \____/  \_______|\_______/
    #                                $$ |                                                 
    #                                $$ |                                                 
    #                                \__|                                                 

    ### PR Template
    pr_template = optional(object({
      enabled = bool
      }), {
      enabled = true
    })

    ### Support Template
    support = optional(object({
      enabled = bool
      }), {
      enabled = true
    })

    ### Code of Conduct
    code_of_conduct = optional(object({
      enabled = bool
      }), {
      enabled = true
    })

    ### Code Owners
    codeowners = optional(object({
      enabled = bool
      }), {
      enabled = true
    })

    ### GitIgnore
    gitignore = optional(object({
      enabled = bool
      }), {
      enabled = true
    })

    ### GitAttributes
    gitattributes = optional(object({
      enabled = bool
      }), {
      enabled = true
    })

    ### Terraform-Docs
    documentation = optional(object({
      ### General
      enabled       = bool
      output_file   = optional(string, "README.md")
      output_format = optional(string, "markdown document")
      ### Content
      about                = optional(string, "This is a Terraform module.")
      inputs_enabled       = optional(bool, true)
      outputs_enabled      = optional(bool, true)
      providers_enabled    = optional(bool, true)
      requirements_enabled = optional(bool, true)
      resources_enabled    = optional(bool, true)
      ### Config
      anchor_enabled      = optional(bool, true)
      default_enabled     = optional(bool, true)
      description_enabled = optional(bool, true)
      escape_enabled      = optional(bool, true)
      hide_empty_enabled  = optional(bool, false)
      html_enabled        = optional(bool, true)
      indent              = optional(number, 2)
      lockfile_enabled    = optional(bool, false)
      required_enabled    = optional(bool, true)
      sensitive_enabled   = optional(bool, true)
      type_enabled        = optional(bool, true)
      }), {
      enabled = true
    })

    ### Semver + Release
    release = optional(object({
      enabled = bool
      }), {
      enabled = true
    })

    ### Examples - Deploys the following content to examples/%EXAMPLE%/ path for the repository
    examples = optional(map(object({
      #### General
      name        = string
      description = optional(string)

      #### Files
      #auth.tf
      auth_enabled      = optional(bool, true)  # Manage the auth.tf file configuration for the example
      auth_docs_enabled = optional(bool, false) # Configure the auth.tf documentation for the example
      #context.tf
      context_deployed     = optional(bool, false) # Deploy the context.tf sample file for the example
      context_docs_enabled = optional(bool, false) # Configure the context.tf documentation for the example
      #data.tf
      data_deployed     = optional(bool, false) # Deploy the data.tf sample file for the example
      data_docs_enabled = optional(bool, false) # Configure the data.tf documentation for the example
      #dummy.tf
      dummy_deployed = optional(bool, false) # Deploy the dummy.tf sample file for the example
      #locals.tf
      locals_deployed     = optional(bool, true)  # Deploy the locals.tf sample file for the example
      locals_docs_enabled = optional(bool, false) # Configure the locals.tf documentation for the example
      #main.tf
      main_deployed     = optional(bool, true) # Deploy the main.tf sample file for the example
      main_docs_enabled = optional(bool, true) # Configure the main.tf documentation for the example
      #outputs.tf
      outputs_deployed     = optional(bool, true)  # Deploy the outputs.tf sample file for the example
      outputs_docs_enabled = optional(bool, false) # Configure the outputs.tf documentation for the example
      #terratest.tf
      terratest_enabled = optional(bool, true) # Manage the terratest-%EXAMPLE%.yml workflow file and the .test/%EXAMPLE% folder
      terraform_version = optional(string)     # The version of Terraform to be used in the examples workflows.
      #variables.tf
      variables_deployed     = optional(bool, false) # Deploy the variables.tf sample file for the example
      variables_docs_enabled = optional(bool, false) # Configure the variables.tf documentation for the example

      #### Providers for auth.tf
      providers = optional(object({
        #azurerm
        azurerm = optional(object({
          enabled = bool # We use enabled to determine if the provider is to be bootstrapped, as all attributes are optional.
          source  = optional(string, "hashicorp/azurerm")
          version = optional(string, "3.100.0")
          features = optional(object({
            resource_group = optional(object({
              prevent_deletion_if_contains_resources = optional(bool, false)
            }))
          }))
          storage_use_azuread = optional(bool, true)
          }), {
          enabled = true
        })

        #github
        github = optional(object({
          enabled = bool
          source  = optional(string, "integrations/github")
          version = optional(string, "6.2.1")
          }), {
          enabled = false
        })

        #oci
        oci = optional(object({
          enabled = bool
          source  = optional(string, "oracle/oci")
          version = optional(string, "5.38.0")
          }), {
          enabled = false
        })
      }))

      #### Backends for auth.tf
      /* backend_azurerm = optional(object({
        enabled                     = bool
        resource_group_name         = optional(string, "rgrp-pde3-it-terratest") # Can be passed via -backend-config="resource_group_name=<resource group name>" in the init command.
        storage_account_name        = optional(string, "saccpde3itterratest001") # Can be passed via -backend-config="storage_account_name=<storage account name>" in the init command.
        container_name              = optional(string)                           # Can be passed via -backend-config="container_name=<container name>" in the init command.
        key                         = optional(string)                         # Can be passed via -backend-config="key=<blob key name>" in the init command.
        snapshot                    = optional(bool, true)                       # Can also be set via ARM_SNAPSHOT environment variable.
        use_azuread_auth            = optional(bool, true)                       # Can also be set via ARM_USE_AZUREAD environment variable.
        use_msi                     = optional(bool, false)                      # Can also be set via ARM_USE_MSI environment variable.
        msi_endpoint                = optional(string)                           # Can also be set via ARM_MSI_ENDPOINT environment variable.
        use_oidc                    = optional(bool, false)                      # Can also be set via ARM_USE_OIDC environment variable.
        oidc_request_url            = optional(string)                           # Can also be set via ARM_OIDC_REQUEST_URL or ACTIONS_ID_TOKEN_REQUEST_URL environment variables.
        oidc_request_token          = optional(string)                           # Can also be set via ARM_OIDC_REQUEST_TOKEN or ACTIONS_ID_TOKEN_REQUEST_TOKEN environment variables.
        oidc_token                  = optional(string)                           # Can also be set via ARM_OIDC_TOKEN environment variable.
        oidc_token_file_path        = optional(string)                           # Can also be set via ARM_OIDC_TOKEN_FILE_PATH environment variable.
        environment                 = optional(string, "public")                 # Can also be set via ARM_ENVIRONMENT environment variable.
        client_id                   = optional(string)                           # Can also be set via ARM_CLIENT_ID environment variable.
        client_secret               = optional(string)                           # Can also be set via ARM_CLIENT_SECRET environment variable.
        client_certificate_path     = optional(string)                           # Can also be set via ARM_CLIENT_CERTIFICATE_PATH environment variable.
        client_certificate_password = optional(string)                           # Can also be set via ARM_CLIENT_CERTIFICATE_PASSWORD environment variable.
        subscription_id             = optional(string)                           # Can also be set via ARM_SUBSCRIPTION_ID environment variable.
        tenant_id                   = optional(string)                           # Can also be set via ARM_TENANT_ID environment variable.
        }), {
        enabled = true
      }) */

      /* backend_gcs = optional(object({
        enabled     = bool
        bucket      = optional(string, "pde3-it-terratest")
        prefix      = optional(string, "terratest-google")
        credentials = optional(string, "gcp-credentials.json")
        }), {
        enabled = false
      }) */

      /* backend_s3 = optional(object({
        enabled = bool
        bucket  = optional(string, "pde3-it-terratest")
        key     = optional(string, "terratest-oci")
        region  = optional(string, "us-west-2")
        profile = optional(string, "default")
        }), {
        enabled = false
      }) */

    })), {})
  }))
```

Default: `{}`

### <a name="input_secrets"></a> [secrets](#input\_secrets)

Description: (Optional) A map(string) of action secrets to be created for all hive repositories

Type: `map(string)`

Default: `{}`

### <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version)

Description: (Optional) The version of Terraform to be used in the repositories workflows.

Type: `string`

Default: `"1.8.2"`

### <a name="input_variables"></a> [variables](#input\_variables)

Description: (Optional) A map(string) of action variables to be created for all hive repositories

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_flattened_labels"></a> [flattened\_labels](#output\_flattened\_labels)

Description: Flattened GitHub Issue Labels

### <a name="output_flattened_secrets"></a> [flattened\_secrets](#output\_flattened\_secrets)

Description: Flattened GitHub Actions Secrets

### <a name="output_flattened_variables"></a> [flattened\_variables](#output\_flattened\_variables)

Description: Flattened GitHub Actions Variables

### <a name="output_labels"></a> [labels](#output\_labels)

Description: Normalized GitHub Issue Labels

### <a name="output_repos"></a> [repos](#output\_repos)

Description: Repository Configuration

### <a name="output_secrets"></a> [secrets](#output\_secrets)

Description: Normalized GitHub Actions Secrets

### <a name="output_variables"></a> [variables](#output\_variables)

Description: Normalized GitHub Actions Variables

<!-- markdownlint-disable-file MD033 MD012 -->
## Contributing

* If you think you've found a bug in the code or you have a question regarding
  the usage of this module, please reach out to us by opening an issue in
  this GitHub repository.
* Contributions to this project are welcome: if you want to add a feature or a
  fix a bug, please do so by opening a Pull Request in this GitHub repository.
  In case of feature contribution, we kindly ask you to open an issue to
  discuss it beforehand.

## License

```text
MIT License

Copyright (c) 2024 LederWorks

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
<!-- END_TF_DOCS -->