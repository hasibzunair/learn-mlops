import io
import os

from google.cloud import vision 

"""Get labels from images."""

# for local dev
# pip install google-cloud-vision
# create service account and get key in gcp IAM (get json)
# export GOOGLE_APPLICATION_CREDENTIALS="KEY_PATH"
# run python request.py


# def client
client = vision.ImageAnnotatorClient()
file_name = os.path.abspath("train2757.jpg")

# read file
with io.open(file_name, "rb") as image_file:
    content = image_file.read()

# infer
image = vision.Image(content=content)
response = client.label_detection(image=image)
labels = response.label_annotations

# read labels
print("Labels:")
for label in labels:
    print(label.description)