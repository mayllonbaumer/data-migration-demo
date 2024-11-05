terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.1.0"
    }
  }
  required_version = ">= 1.8.3"
  backend "gcs" {
    bucket = "the_bucket_name"
    prefix = "terraform/state/resources"
  }
}

provider "google" {
  project = var.project_name
}