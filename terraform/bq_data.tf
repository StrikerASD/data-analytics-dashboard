resource "null_resource" "insert_sample_data" {
  depends_on = [google_bigquery_table.sample_table]

  provisioner "local-exec" {
    command = "bq load --source_format=NEWLINE_DELIMITED_JSON --autodetect=false analytics_dataset.sample_table sample_data.json"
  }

  # Ensure the bq command is authenticated, possibly by setting GOOGLE_APPLICATION_CREDENTIALS
}
