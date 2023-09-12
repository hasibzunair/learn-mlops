# Create bucket
resource "google_storage_bucket" "bucket" {
    name = "bucket_for_func_tf"
    location = "US"
}

# Upload index.zip
resource "google_storage_bucket_object" "archive" {
    name = "index.zip"
    bucket = google_storage_bucket.bucket.name
    source = "./index.zip"
}

# # Deploy
resource "google_cloudfunctions_function" "function" {
    name = "function-from-tf"
    runtime = "python39"
    description = "My first function from Terraform script."

    available_memory_mb = 128
    source_archive_bucket = google_storage_bucket.bucket.name
    source_archive_object = google_storage_bucket_object.archive.name
  
    trigger_http = true
    entry_point = "hello_http_tf"
}

# Policy binding
resource "google_cloudfunctions_function_iam_member" "allowaccess" {
    region = google_cloudfunctions_function.function.region
    cloud_function = google_cloudfunctions_function.function.name
    role = "roles/cloudfunctions.invoker"
    member = "allUsers" 

}