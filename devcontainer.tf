locals {
  devcontainer_dockerfile = templatefile(
    "${path.module}/files/devcontainer/${var.workspace_image}/Dockerfile.tpl",
    {
      workspace_image     = var.workspace_image
      workspace_image_tag = var.workspace_image_tag
      image_registry      = var.image_registry
    }
  )
  devcontainer_json = templatefile(
    "${path.module}/files/devcontainer/${var.workspace_image}/devcontainer.json.tpl",
    {
    }
  )
}

resource "github_repository_file" "devcontainer_dockerfile" {
  repository          = var.repository
  branch              = "main"
  file                = ".devcontainer/Dockerfile"
  content             = local.devcontainer_dockerfile
  overwrite_on_create = true
}

resource "github_repository_file" "devcontainer_json" {
  repository          = var.repository
  branch              = "main"
  file                = ".devcontainer/devcontainer.json"
  content             = local.devcontainer_json
  overwrite_on_create = true
}
