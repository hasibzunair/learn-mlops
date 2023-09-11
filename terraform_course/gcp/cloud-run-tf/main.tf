# Create cloud run
resource "google_cloud_run_service" "run-app-from-tf" {
    name = "run-app-from-tf"
    location = "us-central1"

    template {
        spec {
            containers {
            image = "gcr.io/google-samples/hello-app:2.0"
            }
        }
    }

    # divide traffic among two versions of docker images.
    traffic {
        revision_name = "run-app-from-tf-00002-p48"
        percent = 50
    }

    traffic {
        revision_name = "run-app-from-tf-00001-69x"
        percent = 50
    }
}

# Public access
resource "google_cloud_run_service_iam_policy" "pub_access" {
    service = google_cloud_run_service.run-app-from-tf.name
    location = google_cloud_run_service.run-app-from-tf.location
    policy_data = data.google_iam_policy.pub-1.policy_data
}

# Policy
data "google_iam_policy" "pub-1" {
  binding {
    role = "roles/run.invoker"
    members = [ "allUsers" ]
  }
}
