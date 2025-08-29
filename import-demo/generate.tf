provider "google" {
}

import {
  # This imports my valheim game server to Terraform. Obviously, you can't import my server, so create your own first.
  id = "<My Project ID>/europe-north1-c/valheim-server"
  to = google_compute_instance.valheim_server
}

