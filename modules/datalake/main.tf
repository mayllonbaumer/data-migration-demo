locals {
  base_path  = "${path.module}/schemas"
  schemas = fileset("${local.base_path}", "*.json")

  tables_name = [for schema in local.schemas : replace(schema, ".json", "")]
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id = "datalake"
  location   = var.region
}

resource "google_bigquery_table" "tables" {
  for_each   = toset(local.tables_name)
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = each.key
  time_partitioning {
    field = "ingestion_date"
    type  = "DAY"
  }
  schema = file("${path.module}/schemas/${each.key}.json")
}