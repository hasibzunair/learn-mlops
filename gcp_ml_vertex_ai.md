# Google Cloud Machine Learning - Vertex AI

Course Link - [Link](https://www.udemy.com/course/machine-learning-with-google-cloud/).

## Section 1

GCP basics and account creation

## Section 2

Zones and regions.

Inside regions we have multiple zones.

## Section 3

ML Basics.

## Section 4

GCP services for ML.

Google Compute Engine, Identity and Access Management IAM, Google Cloud Storage.

Identity and Access Management IAM: Roles, Service Accounts.

## Section 5

GCP Product for ML

ML API, AutoML, Custom ML, Vertex AI features, BigQuery ML.

AutoML -> no code training
Vertex AI -> code based custom training
BigQuery ML -> SQL code based training

## Section 6

ML API with Pre Built Model.

For generic use-cases. Vision API (object detection or OCR).

Speech to text, language translation -> NLP API

No training data needed. Use prebuilt REST API. 

## Section 7

Vision API: Text, Landmark, Logo, label detection, object localization, crop hint detection, safe search. Does not work on your own custom image use-cases, for example a type of flower.

Label detection from image.

Try in browzer: https://cloud.google.com/vision/docs/drag-and-drop

API explorer: https://cloud.google.com/vision/docs/detect-labels-image-api

Using command line option (https://cloud.google.com/vision/docs/detect-labels-image-command-line):

```
# Go to cloud shell
gcloud auth print-access-token
```

Enable Cloud Vision API.

Make requst.json in cloud shell:

```json
{
  "requests": [
    {
      "image": {
        "source": {
          "imageUri": "gs://hasib-bucket/images/train2757.jpg"
        }
      },
      "features": [
        {
          "type": "LABEL_DETECTION",
          "maxResults": 30
        },
        {
          "type": "OBJECT_LOCALIZATION",
          "maxResults": 1
        },
        {
          "type": "TEXT_DETECTION",
          "maxResults": 1,
          "model": "builtin/latest"
        }
      ]
    }
  ]
}
```

Then, run:
```bash
curl -X POST \
    -H "Authorization: Bearer "$(gcloud auth print-access-token) \
    -H "Content-Type: application/json; charset=utf-8" \
    -H "X-Goog-User-Project:focus-semiotics-393216" \
    https://vision.googleapis.com/v1/images:annotate -d @request.json
```
You will see a JSON response.

Next, `gcloud` tool: 
```
gcloud ml vision detect-labels gs://hasib-bucket/images/train2757.jpg
gcloud ml vision detect-faces gs://hasib-bucket/images/train2757.jpg # no faces!
```

You will see a JSON response.

Python client: see `request.py`.