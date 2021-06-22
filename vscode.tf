locals {
  extensions_json = templatefile(
    "${path.module}/files/vscode/${var.workspace_image}/extensions.json.tpl",
    {
    }
  )
  settings_json = templatefile(
    "${path.module}/files/vscode/${var.workspace_image}/settings.json.tpl",
    {
    }
  )
}

resource "github_repository_file" "workspace_extensions" {
  repository          = var.repository
  branch              = "main"
  file                = ".vscode/extensions.json"
  content             = local.extensions_json
  overwrite_on_create = true
}

resource "github_repository_file" "workspace_settings" {
  repository          = var.repository
  branch              = "main"
  file                = ".vscode/settings.json"
  content             = local.settings_json
  overwrite_on_create = true
}
