# terraform/outputs.tf

output "bigquery_dataset_id" {
  value = google_bigquery_dataset.analytics_dataset.dataset_id
}

output "bigquery_table_id" {
  value = google_bigquery_table.sample_table.table_id
}

output "cloud_run_backend_url" {
  value = google_cloud_run_service.backend.status[0].url
}

output "frontend_url" {
  value = "http://${google_storage_bucket.frontend_bucket.self_link}"
}
