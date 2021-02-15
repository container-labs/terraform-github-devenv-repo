image:
  file: .devcontainer/gitpod.Dockerfile

# TODO: make this configurable for monorepo support
tasks:
  - init: flutter doctor

vscode:
  extensions:
    - hashicorp.terraform
