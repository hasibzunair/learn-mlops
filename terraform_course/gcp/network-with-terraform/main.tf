resource "google_compute_network" "auto_vpc_tf" {
    name = "auto-vpc-tf"  
}

resource "google_compute_network" "custom_vpc_tf" {
    name = "custom-vpc-tf"
    auto_create_subnetworks = true
}

# subnet inside our VPCs
resource "google_compute_subnetwork" "sub-sg" {
    name = "sub-sg"
    network = google_compute_network.custom_vpc_tf.id
    ip_cidr_range = "10.1.0.0/24"
    region = "us-central1"
    private_ip_google_access = true
  
}

# add firewall rule
resource "google_compute_firewall" "allow-icmp" {
  name = "allow-icmp"
  network = google_compute_network.custom_vpc_tf.id
  allow {
    protocol = "icmp"
  }
  source_ranges = ["174.113.25.28/32"]
  priority = 455
}


output "auto" {
    value = google_compute_network.auto_vpc_tf.id
}

output "custom" {
    value = google_compute_network.custom_vpc_tf.id
}