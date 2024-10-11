# terraform/variables.tf

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "europe-west3"
}

variable "backend_image" {
  description = "Docker image for the backend service"
  type        = string
}

variable "mime_types" {
  description = "Mapping of file extensions to MIME types"
  type = map(string)
  default = {
    "html" = "text/html"
    "js"   = "application/javascript"
    "css"  = "text/css"
    "png"  = "image/png"
    "jpg"  = "image/jpeg"
    "jpeg" = "image/jpeg"
    "gif"  = "image/gif"
    "svg"  = "image/svg+xml"
    "json" = "application/json"
    "ico"  = "image/x-icon"
  }
}