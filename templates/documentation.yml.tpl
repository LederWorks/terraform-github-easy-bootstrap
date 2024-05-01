#This file is managed by the Github Bootstrap workflow. Any modifications to this file may be overwritten. To make changes, please modify the bootstrap module.
name: Generate README.MD

on:
  push:
    branches:
      - main
  pull_request:

jobs:
  docs:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v4
      with:
        ref: \${{ github.event.pull_request.head.ref }}

    - name: Render terraform docs inside the README.MD and push changes back to PR branch
      uses: terraform-docs/gh-actions@v1.1.0
      with:
        working-dir: .
        config-file: .config/.terraform-docs.yml
        output-file: ${output_file}
        output-method: inject
        output-format: ${output_format}
        git-push: "true"
        git-commit-message: "terraform-docs: autogenerate README.MD"