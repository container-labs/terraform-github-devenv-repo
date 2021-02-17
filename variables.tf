variable "repository" {
  type = string
}

variable "workspace_image" {
  default = "base"
  type    = string
}

variable "vscode_enabled" {
  default     = true
  type        = bool
  description = "if enabled, writes vscode workspace settings"
}