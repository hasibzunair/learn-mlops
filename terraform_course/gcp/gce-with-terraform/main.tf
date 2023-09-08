# create VM
resource "google_compute_instance" "vm-from-tf" {
    name = "vm-from-tf-hasib"
    zone = "us-central1-a"
    machine_type = "e2-small"

    # To update machine type, uncomment this
    # It will stop machine and start again.
    allow_stopping_for_update = true

    # define network
    network_interface {
      network = "custom-vpc-tf"
    }

    # define hard disk
    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
            size = 35
        }
        auto_delete = false
    }

    # labels
    labels = {
        "dep" = "datascience"
    }

    scheduling {
        preemptible = false
        automatic_restart = false
    }
    
    # attach service account to use gcloud commands inside VM
    service_account {
        email = "terraform-gcp@deployment-stuff.iam.gserviceaccount.com"
        scopes = [ "cloud-platform" ]
    }

    lifecycle {
        ignore_changes = [
        attached_disk
        ]
    }

}


# attach disk
resource "google_compute_disk" "disk-1" {
  name  = "disk-1"
  size = 15
  type  = "pd-ssd"
  zone  = "us-central1-a"
}

resource "google_compute_attached_disk" "default" {
  disk     = google_compute_disk.disk-1.id
  instance = google_compute_instance.vm-from-tf.id
}