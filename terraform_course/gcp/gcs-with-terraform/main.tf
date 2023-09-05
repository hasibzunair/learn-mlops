# create bucket
resource "google_storage_bucket" "GCS1" {
    name = "bucket-from-tf-hasibzunair-121233"
    location      = "US"
    storage_class = "STANDARD"

    labels = {
        "env" = "tf_env"
        "dep" = "complience"
    }

    uniform_bucket_level_access = false
}

# upload objects
resource "google_storage_bucket_object" "picture" {
    name = "image_file"
    bucket = google_storage_bucket.GCS1.name
    source = "image1.JPG"
}

