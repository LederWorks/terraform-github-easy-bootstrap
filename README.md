<!-- BEGIN_TF_DOCS -->
<!-- markdownlint-disable-file MD033 MD012 -->
# terraform-github-easy-bootstrap
LederWorks Easy Github Bootstrap Module

This module were created by [LederWorks](https://lederworks.com) IaC enthusiasts.

## About This Module
This module has been mainly designed and developed to bootstrap terraform module repositories, however it can be used for any github repository.

## How to Use This Modul
- Ensure Github credentials are [in place](https://registry.terraform.io/providers/integrations/github/latest/docs#authentication)
- _Some_ role or equivalent is required!
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
  hive = "rainbow"

  #### Members
  contributors = local.all_members
  approvers = ["Dilergore"]
  admins = ["Ledermayer"]

  #### Inputs
  variables = {
    one = "pici"
    dog = "tej"
  }

  secrets = {
    my   = "verysecret"
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
    pink = {
      #Common
      type   = "engine"
      suffix = "pink"
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
    }
    purple = {
      type   = "brick"
      suffix = "purple"
    }
    violet = {
      type   = "block"
      suffix = "violet"
    }
    brown = {
      type   = "wrapper"
      suffix = "brown"
    }
    orange = {
      type   = "accelerator"
      suffix = "orange"
    }
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
    #Common
    type        = string
    suffix      = string
    description = optional(string)
    url         = optional(string)
    #General
    private_enabled     = optional(bool, false)
    issues_enabled      = optional(bool, true)
    discussions_enabled = optional(bool, false)
    projects_enabled    = optional(bool, false)
    wiki_enabled        = optional(bool, false)
    archive_enabled     = optional(bool, false)
    #Custom Inputs
    custom_variables = optional(map(string), {})
    custom_secrets   = optional(map(string), {})
    custom_labels = optional(map(object({
      name        = string
      color       = string
      description = optional(string)
    })), {})
  }))
```

Default: `{}`

### <a name="input_secrets"></a> [secrets](#input\_secrets)

Description: (Optional) A map(string) of action secrets to be created for all hive repositories

Type: `map(string)`

Default: `{}`

### <a name="input_variables"></a> [variables](#input\_variables)

Description: (Optional) A map(string) of action variables to be created for all hive repositories

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_repos"></a> [repos](#output\_repos)

Description: Repository Configuration

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