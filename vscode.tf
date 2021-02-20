locals {
  settings_json = templatefile(
    "${path.module}/files/vscode/${var.workspace_image}/settings.json.tpl",
    {
    }
  )
}

resource "github_repository_file" "workspace_settings" {
  repository          = var.repository
  branch              = "main"
  file                = ".vscode/settings.json"
  content             = local.settings_json
  overwrite_on_create = true
}
