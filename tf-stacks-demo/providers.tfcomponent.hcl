required_providers {
  google = {
    source  = "hashicorp/google"
    version = "~> 6.47"
  }
}

provider "google" "this" {
  config {
    region  = "europe-north1"
    project = "<My project ID>" # Replace with your GCP project ID
    credentials = var.gcp-creds
  }
}

variable "gcp-creds" {
  sensitive   = true
  ephemeral   = true
  description = "The credentials for the Google Cloud provider"
  type        = string
}
