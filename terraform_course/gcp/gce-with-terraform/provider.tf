terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.80.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "deployment-stuff"
  region = "us-central1"
  zone = "us-central1-a"
  credentials = "keys.json" # new arg added
}