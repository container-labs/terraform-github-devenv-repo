image:
  file: .devcontainer/gitpod.Dockerfile

#tasks:
#  - init: flutter doctor

vscode:
  extensions:
    # base extensions, TODO: abstract
    # I think we can install them in the base image?
    - coenraads.bracket-pair-colorizer-2
    # language-specific
    - erlang-ls.erlang-ls
    - pgourlain.erlang
    - yuce.erlang-otp
    - sztheory.erlang-formatter
    - nigelrook.vscode-linter-erlc
    - sztheory.hex-lens
