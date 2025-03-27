# products/conversational-agents/infrastructure/providers.tf

terraform {
  required_version = ">= 1.3" # Specify a compatible Terraform version

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.16.0" # Use a recent version supporting required resources
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 5.16.0" # Beta provider often needed for newer CA features
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}