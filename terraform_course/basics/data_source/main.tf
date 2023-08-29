# read file
data local_file name {
  filename = "sample1.txt"
}

# print
output name1 {
  value = data.local_file.name.content
}

