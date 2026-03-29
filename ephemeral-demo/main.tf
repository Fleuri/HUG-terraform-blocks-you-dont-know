terraform {
  required_version = ">= 1.10.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.40.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0"
    }
  }
}

provider "google" {
    project     = "<Your Project ID>" # Replace with your GCP project ID
    region      = "europe-north1"
}

ephemeral "random_password" "db_password" {
  length           = 16
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "google_secret_manager_secret" "db_password" {
  secret_id = "db-password"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "db_password" {
  secret      = google_secret_manager_secret.db_password.id
  secret_data_wo = ephemeral.random_password.db_password.result
  secret_data_wo_version = 1
}

ephemeral "google_secret_manager_secret_version" "db_password_access" {
  secret      = google_secret_manager_secret.db_password.id
  version     = "latest"
  depends_on = [google_secret_manager_secret_version.db_password]
}

resource "google_sql_database_instance" "example" {
  name             = "test-instance"
  region           = "europe-north1"
  database_version = "POSTGRES_15"

  settings {
    tier = "db-f1-micro"
  }
  deletion_protection = false
}

resource "google_sql_user" "example" {
  name     = "example"
  instance = google_sql_database_instance.example.name
  password_wo = ephemeral.google_secret_manager_secret_version.db_password_access.secret_data
  password_wo_version = google_secret_manager_secret_version.db_password.secret_data_wo_version
}
