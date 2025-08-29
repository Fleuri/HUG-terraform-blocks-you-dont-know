terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

variable "vm-name" {
  type = string
}

resource "google_compute_instance" "test-vm" {
    name         = var.vm-name
    machine_type = "e2-medium"
    zone         = "us-east1-b"

    boot_disk {
        initialize_params {
        image = "debian-cloud/debian-11"
        }
    }

    network_interface {
        network = "default"
        access_config {}
    }
}