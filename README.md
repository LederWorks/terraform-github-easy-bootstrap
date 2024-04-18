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

  ### Common Variables ###
  # owner = "Ledermayer"

  ### General Variables ###

  ### Global Variables ###

  ### Set Variables ###
  hives = {
    #Azure Network Modules
    azure-network = {
      provider  = "azure"
      hive      = "network"
      description = "Azure Network Terraform Team"
      members   = []
      variables = {}
      secrets   = {}
      labels = {
        azurerm-compute = {
          name        = "azurerm-network"
          color       = "blue"
          description = "Azure Network Modules"
        }
      }
    }

    #Azure Compute Modules
    azure-compute = {
      provider  = "azure"
      hive      = "compute"
      description = "Azure Compute Terraform Team"
      members   = []
      variables = {}
      secrets   = {}
      labels = {
        azurerm-compute = {
          name        = "azurerm-compute"
          color       = "blue"
          description = "Azure Compute Modules"
        }
      }
    }
  }

  repos = {
    #Azure Network NSG Module
    azurerm-network-nsg = {
      name = {
        language = "terraform"
        provider = "azurerm"
        infix    = "baby"
        type     = "brick"
        hive     = "network"
        suffix   = "nsg"
      }
    }

    #Azure Compute NIC Module
    azurerm-compute-nic = {
      name = {
        language = "terraform"
        provider = "azurerm"
        infix    = "baby"
        type     = "brick"
        hive     = "compute"
        suffix   = "nic"
      }
    }
  }

}
```

## Resources

The following resources are used by this module:

- [github_repository.repo](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) (resource)
- [github_team.admins](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) (resource)
- [github_team.approvers](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) (resource)
- [github_team.contributors](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) (resource)
- [github_team.team](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) (resource)
- [github_team_members.admins](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members) (resource)
- [github_team_members.approvers](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members) (resource)
- [github_team_members.members](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members) (resource)
- [github_team_members.team](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members) (resource)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_admins"></a> [admins](#input\_admins)

Description: Admins of the provider team.

Type: `set(string)`

Default: `[]`

### <a name="input_hives"></a> [hives](#input\_hives)

Description: Hives

Type:

```hcl
map(object({
    hive         = string
    approvers    = optional(set(string), [])
    contributors = optional(set(string), [])
  }))
```

Default: `{}`

### <a name="input_labels"></a> [labels](#input\_labels)

Description: Labels

Type:

```hcl
map(object({
    name        = string
    color       = string
    description = optional(string)
  }))
```

Default: `{}`

### <a name="input_members"></a> [members](#input\_members)

Description: Members of the provider team.

Type: `set(string)`

Default: `[]`

### <a name="input_provider"></a> [provider](#input\_provider)

Description: The cloud provider to be bootstrapped.

Type: `string`

Default: `"oci"`

### <a name="input_repos"></a> [repos](#input\_repos)

Description:

Type:

```hcl
map(object({
    #Common
    name = object({
      language = optional(string, "terraform")
      provider = optional(string)
      infix    = optional(string) #easy
      type     = optional(string)
      hive     = optional(string)
      suffix   = string
    })
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
    custom_teams     = optional(set(string), [])
    custom_variables = optional(map(string), {})
    custom_secrets   = optional(map(string), {})
    custom_labels = optional(map(object({
      name        = string
      color       = string
      description = optional(string)
    })))
  }))
```

Default: `{}`

### <a name="input_secrets"></a> [secrets](#input\_secrets)

Description: Secrets

Type: `map(string)`

Default: `{}`

### <a name="input_variables"></a> [variables](#input\_variables)

Description: Variables

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_hives"></a> [hives](#output\_hives)

Description: Hives

### <a name="output_repos"></a> [repos](#output\_repos)

Description: Repositories

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