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
}

resource google_storage_bucket "default" {
  name = "bucket-from-tf-hasibzunair-121233"
  location      = "US"
  storage_class = "STANDARD"
}