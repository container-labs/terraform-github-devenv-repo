locals {
  gitpod_dockerfile = templatefile(
    "${path.module}/files/gitpod/${var.workspace_image}/gitpod.Dockerfile.tpl",
    {
      image_registry      = var.image_registry
      workspace_image     = var.workspace_image
      workspace_image_tag = var.workspace_image_tag
    }
  )
  gitpod_dockerfile_digest = templatefile(
    "${path.module}/files/gitpod/${var.workspace_image}/gitpod.digest.Dockerfile.tpl",
    {
      image_registry         = var.image_registry
      workspace_image        = var.workspace_image
      workspace_image_digest = var.workspace_image_digest
    }
  )
  gitpod_yaml = templatefile(
    "${path.module}/files/gitpod/${var.workspace_image}/gitpod.yml.tpl",
    {
    }
  )
}

resource "github_repository_file" "gitpod_dockerfile" {
  count               = length(var.workspace_image_digest) > 0 ? 1 : 0
  repository          = var.repository
  branch              = "main"
  file                = ".devcontainer/gitpod.Dockerfile"
  content             = local.gitpod_dockerfile
  overwrite_on_create = true
}

resource "github_repository_file" "gitpod_dockerfile_digest" {
  count               = length(var.workspace_image_digest) > 0 ? 0 : 1
  repository          = var.repository
  branch              = "main"
  file                = ".devcontainer/gitpod.Dockerfile"
  content             = local.gitpod_dockerfile_digest
  overwrite_on_create = true
}

resource "github_repository_file" "gitpod_yaml" {
  repository          = var.repository
  branch              = "main"
  file                = ".gitpod.yml"
  content             = local.gitpod_yaml
  overwrite_on_create = true
}
