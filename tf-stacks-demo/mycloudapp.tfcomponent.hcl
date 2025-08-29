component "vms" {
  for_each = var.regions

  source = "./modules/vm"

  inputs = {
    name         = "${var.deployment_name}-vm-${each.value}"
    machine_type = "e2-medium"
    zone         = "${each.value}-b"
    image        = "debian-11-bullseye-v20240415"
  }

  providers = {
    google = provider.google.this
  }
}

component "storage" {
  for_each = var.deploy_gcs

  source = "./modules/gcs"

  inputs = {
    name     = "prod-storage-bucket"
    location = "EU"
  }

  providers = {
    google = provider.google.this
  }
}

variable "regions" {
  description = "List of regions to deploy VMs in"
  type        = set(string)
}

variable "deployment_name" {
  description = "The name of the deployment"
  type        = string
}

variable "deploy_gcs" {
  description = "Flag to deploy Google Cloud Storage bucket. Because stacks are stupid this way, any one value will do. Leave empty to not deploy."
  default     = []
  type        = set(string)
  /* Apparently we are still in beta, therefore this VERY BASIC block is not supported. Sigh.
  validation {
  #  condition     = length(var.deploy_gcs) <= 1
    error_message = "deploy_gcs must be an empty set or a set with any one string value (It won't be used). Read the description"
  }
   */
}

