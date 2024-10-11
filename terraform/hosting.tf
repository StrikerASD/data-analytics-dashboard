# Random ID for unique bucket naming
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Google Cloud Storage Bucket for Frontend
resource "google_storage_bucket" "frontend_bucket" {
  name     = "data-analytics-frontend-${random_id.bucket_suffix.hex}"
  location = "europe-west3"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  uniform_bucket_level_access = true
  force_destroy              = true
}

# IAM Member to allow public access
resource "google_storage_bucket_iam_member" "public_access" {
  bucket = google_storage_bucket.frontend_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

# Local MIME Types
locals {
  mime_types = jsondecode(file("${path.module}/mime_types.json"))
}

# Upload Frontend Files to GCS
resource "google_storage_bucket_object" "frontend_files" {
  for_each = local.mime_types

  name         = each.key
  bucket       = google_storage_bucket.frontend_bucket.name
  source       = "${path.module}/../frontend/build/${each.key}"
  content_type = each.value
}
