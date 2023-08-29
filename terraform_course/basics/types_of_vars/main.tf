resource local_file sample_res {
  filename = var.filename1
  #sensitive_content = var.content1[0] # for lists
  sensitive_content = var.content1["name"] # for maps
}