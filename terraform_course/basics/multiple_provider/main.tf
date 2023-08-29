resource local_file sample_res {
  filename = "sample.txt"
  content = "This is HCL."
}

resource random_string name {
    length = 10
}