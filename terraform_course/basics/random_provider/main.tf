resource random_string rstring {
    length = 20
}

# like print statement
output name1 {
  value = random_string.rstring.result
}
