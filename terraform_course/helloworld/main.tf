resource local_file sample_res {
  filename = var.filename
  sensitive_content = var.content
}