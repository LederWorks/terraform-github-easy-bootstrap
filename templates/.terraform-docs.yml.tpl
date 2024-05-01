formatter: $${output_format}

version: ""
header-from: .config/header.txt
footer-from: .config/footer.txt


sections:
  show:
    - header
    - footer
    - inputs
    - outputs
    - requirements
    - providers
    - resources

content: |-
  {{ .Header }}

  {{ .Requirements }}

  {{ .Providers }}

  ## Examples

  ### Example 1
  ```hcl
  {{ include "examples/01-default/test.tf" }}
  ```

  {{ .Resources }}

  {{ .Inputs }}

  {{ .Outputs }}

  {{ .Footer }}

output:
  file: ""
  mode: inject
  template: |-
    <!-- BEGIN_TF_DOCS -->
    {{ .Content }}
    <!-- END_TF_DOCS -->

output-values:
  enabled: false

sort:
  enabled: true
  by: required

settings:
  anchor: true
  default: true
  description: true
  escape: true
  hide-empty: false
  html: true
  indent: 2
  lockfile: false
  required: true
  sensitive: true
  type: true