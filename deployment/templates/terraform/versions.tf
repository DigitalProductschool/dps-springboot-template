terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.5.0"
    }
  }

  required_version = ">= 1.1.0"

  backend "gcs" {
    bucket="dps-tf-state"
    prefix = "dns"
  }
}