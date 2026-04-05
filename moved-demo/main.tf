terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "<Your project id here>" # Replace with your GCP project ID
  region  = "europe-north1"
}

# First create this singular VM. Run apply. Then comment this block and uncomment from 'locals' onwards.

resource "google_compute_instance" "vm" {
  name         = "example-vm-big"
  machine_type = "n1-standard-2"
  zone         = "europe-west1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }
}

/*
locals {
  instances = tomap({
    big = {
      instance_type = "n1-standard-2"
    }
    small = {
      instance_type = "e2-medium"
    }
  })
}


resource "google_compute_instance" "vm" {
  for_each = local.instances
  name = "example-vm-${each.key}"
  machine_type = "${each.value.instance_type}"
    zone         = "europe-west1-b"

    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-12"
      }
    }

    network_interface {
      network = "default"

      access_config {}
    }
}

moved {
  from = google_compute_instance.vm
  to   = google_compute_instance.vm["big"]
}
*/