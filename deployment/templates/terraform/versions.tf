terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.5.0"
    }
  }

  required_version = ">= 1.1.0"

  cloud {
    organization = "DPS-IDP"

    workspaces {
      name = "idp-gh-actions"
    }
  }
}