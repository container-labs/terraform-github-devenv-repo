variable "repository" {
  type = string
}

variable "image_registry" {
  default = "us-central1-docker.pkg.dev/containerlabs/gitpod"
  type    = string
}

variable "workspace_image" {
  default = "terraform"
  type    = string
}

variable "workspace_image_tag" {
  default = "latest"
  type    = string
}

// default has to be an empty string
// otherwise the template function barfs
variable "workspace_image_digest" {
  default = ""
  type    = string
}
