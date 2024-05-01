name: Release - terraform-provider-easy-brick-category-purpose

on:
  push:
    branches:
      - main

jobs:
  docs:
    runs-on: ubuntu-latest

    steps:
    - name: Install GitVersion
      uses: gittools/actions/gitversion/setup@v1.1.1
      with:
        versionSpec: '5.x'

    - name: Checkout
      uses: actions/checkout@v4
      with:
        fetch-depth: 0

    - name: Git Configuration
      uses: oleksiyrudenko/gha-git-credentials@v2-latest
      with:
        token: '${{ secrets.GITHUB_TOKEN }}'

    - name: Generate Changelog
      id: changelog
      run: npm i conventional-changelog-angular
    
    - name: Determine Version
      id:   gitversion
      uses: gittools/actions/gitversion/execute@v1.1.1
      with:
        useConfigFile: true
        configFilePath: ./.github/gitversionconfig.yml


    - name: Display GitVersion Output
      run: echo "The determined version is v${{ steps.gitversion.outputs.MajorMinorPatch }}"

    - name: Create Git Semver Tag
      run: git tag --annotate --message "PR#${{ github.event.number }}" v${{ steps.gitversion.outputs.MajorMinorPatch }}
    
    - name: Create Git Short Tag
      run: git tag --force "v${{ steps.gitversion.outputs.Major }}.${{ steps.gitversion.outputs.Minor }}"
    
    - name: Create Git Latest Tag
      run: git tag --force "latest"

    - name: Create Git Stable Tag - Optional
      if: contains(github.event.head_commit.message, '+stable') || contains(github.event.pull_request.body, '+stable')
      run: git tag --force "v${{ steps.gitversion.outputs.major }}.${{ steps.gitversion.outputs.minor }}-stable"

    - name: Push tags to repository
      run: git push --force --verbose --tags
  
    - name: Create Release
      id: create_release
      uses: actions/create-release@v1
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        tag_name: ${{ steps.gitversion.outputs.MajorMinorPatch }}
        release_name: v${{ steps.gitversion.outputs.MajorMinorPatch }}
        body: ${{ steps.changelog.outputs.changelog }}
        draft: false
        prerelease: false

    - name: Publish Release
      uses: actions/upload-release-asset@v1
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        upload_url: ${{ steps.create_release.outputs.upload_url }}
        asset_path: CHANGELOG.md
        asset_name: CHANGELOG.md
        asset_content_type: application/markdown