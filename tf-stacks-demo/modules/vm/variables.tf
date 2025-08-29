variable "name" {
  description = "The name of the Google Compute instance"
  type        = string
  default     = "example-instance"
}

variable "machine_type" {
  description = "The machine type to use for the instance"
  type        = string
  default     = "n1-standard-1"
}

variable "zone" {
  description = "The zone to deploy the instance in"
  type        = string
  default     = "europe-north1-b"
}

variable "project" {
  description = "The Google Cloud project ID"
  type        = string
  default     = "ringed-valor-196605"
}

variable "image" {
  description = "The image to use for the boot disk"
  type        = string
  default     = "debian-11-bullseye-v20240415"
}

variable "network_name" {
  description = "The name of the network to attach the instance to"
  type        = string
  default     = "default"

  validation {
    condition     = contains(["default","my-vpc"], var.network_name)
    error_message = "Only default network and dev-network are allowed"
  }
}