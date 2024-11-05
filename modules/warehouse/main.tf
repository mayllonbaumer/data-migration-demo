locals {
  tables_settings = yamldecode(file("${path.module}/settings.yaml"))["tables"]
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id = "warehouse"
  location   = var.region
}

resource "google_bigquery_table" "tables" {
  for_each   = local.tables_settings
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = each.key
  time_partitioning {
    field = "transformed_date"
    type  = "DAY"
  }
  clustering = each.value.clustering
  schema = file("${path.module}/schemas/${each.key}.json")
}