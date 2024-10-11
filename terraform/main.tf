# terraform/main.tf

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_bigquery_dataset" "analytics_dataset" {
  dataset_id = "analytics_dataset"
  location    = var.region
}

resource "google_bigquery_table" "sample_table" {
  dataset_id = google_bigquery_dataset.analytics_dataset.dataset_id
  table_id   = "sample_table"

  deletion_protection = false

  schema = jsonencode([
    {
      "name" = "name"
      "type" = "STRING"
      "mode" = "NULLABLE"  # This should be NULLABLE
    },
    {
      "name" = "value"
      "type" = "INTEGER"
      "mode" = "NULLABLE"  # This should be REQUIRED
    }
  ])

  labels = {
    goog-terraform-provisioned = "true"
  }
}


resource "google_cloud_run_service" "backend" {
  name     = "data-analytics-backend"
  location = var.region

  template {
    spec {
      containers {
        image = var.backend_image

        ports {
          container_port = 8080
        }

        env {
          name  = "GOOGLE_CLOUD_PROJECT"
          value = var.project_id
        }

        # Optional: Set up authentication, memory, CPU, etc.
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "invoker" {
  service  = google_cloud_run_service.backend.name
  location = google_cloud_run_service.backend.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "backend_url" {
  value = google_cloud_run_service.backend.status[0].url
}
