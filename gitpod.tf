locals {
  gitpod_dockerfile = templatefile(
    "${path.module}/files/gitpod/${var.workspace_image}/gitpod.Dockerfile.tpl",
    {
      workspace_image = var.workspace_image
    }
  )
  gitpod_yaml = templatefile(
    "${path.module}/files/gitpod/${var.workspace_image}/gitpod.yml.tpl",
    {
      workspace_image = var.workspace_image
    }
  )
}

resource "github_repository_file" "gitpod_dockerfile" {
  repository          = var.repository
  branch              = "main"
  file                = ".devcontainer/gitpod.Dockerfile"
  content             = local.gitpod_dockerfile
  overwrite_on_create = true
}

resource "github_repository_file" "gitpod_yaml" {
  repository          = var.repository
  branch              = "main"
  file                = ".gitpod.yml"
  content             = local.gitpod_yaml
  overwrite_on_create = true
}
