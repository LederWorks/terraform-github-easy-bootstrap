## Examples

%{ for example in examples ~}
  %{ if example.auth_enabled and example.auth_docs_enabled ~}
  ### Authentication Example: ${example.name}

  ```hcl
  #auth.tf
  {{ include "examples/${example.name}/auth.tf" }}
  ```
  %{ endif ~}
%{ endfor ~}