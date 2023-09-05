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
      network = "default"
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

}