terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.6.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}


resource "google_storage_bucket" "data-engineering-zoomcamp-2025-bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true




  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}



resource "google_bigquery_dataset" "data-engineering-zoomcamp-2025-dataset" {
  dataset_id = var.bq_dataset_name
  location   = var.location
  
  lifecycle {
    create_before_destroy = true
    prevent_destroy = false
  }
}