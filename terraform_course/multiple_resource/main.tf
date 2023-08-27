# Multiple resources in a single file

resource local_file cat_res {
  filename = "cat.txt"
  sensitive_content = "I love cats!"
}

resource local_file dog_res {
  filename = "dog.txt"
  sensitive_content = "I love dogs!"
}