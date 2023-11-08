terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.5.0"
    }
  }

  required_version = ">= 0.14"

  cloud {
    organization = "DPS-IDP"

    workspaces {
      name = "gh-actions"
    }
  }
}