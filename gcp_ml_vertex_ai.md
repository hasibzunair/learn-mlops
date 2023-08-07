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
gcloud ml vision --help
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

Python client: see [request_annotate.py](./gcp_vertex_ai_course/request_annotate.py).

OCR: works on images as well as PDF files. See [here](https://cloud.google.com/vision/docs/ocr). Go to cloud shell and run:

```gcloud ml vision detect-text image1.png
```

Landmark: Run the following
```
gcloud ml vision detect-landmarks tower.png
gcloud ml vision detect-logos logo.png
```

Image properties: `gcloud ml vision detect-image-properties tower.png` cropHintsAnnotation suggest where to crop image, gives good fit. dominantColors show colors in image.

Object localization: `gcloud ml vision detect-objects train2757.jpg`.

Web entities: `gcloud ml vision detect-web elon.png`. Find similar or same images on internet.

Safe search: `gcloud ml vision detect-safe-search violence.png`.

Face detection: `gcloud ml vision detect-faces faces.png`. 

So far, demos are done with gcloud, see guides to access using Python API: https://cloud.google.com/vision/docs/how-to.

## Section 8

Natural language API: Entity analysis, Sentiment analysis, Syntax analysis, Content classification. See https://cloud.google.com/natural-language.

```
gcloud ml language analyze-entities --content="puppies
gcloud ml language analyze-sentiment --content="the movie was really good"
gcloud ml language analyze-entity-sentiment --content="good job man"
gcloud ml language classify-text --content="As a passionate traveler, I have had the privilege of visiting some of the most breathtaking places in the U.S, and along the way, I've discovered several spots that radiate romance. From awe-inspiring natural wonders to charming historic towns, here are my top 10 romantic spots in the U.S, each paired with helpful travel tips to make your visit even more special"
```
For API demo: https://cloud.google.com/natural-language/docs/analyzing-sentiment#analyzing_sentiment_in_a_string

## Section 9

Speech to and from Text API. 125 langs, stream speech recognition. Content filtering, Automatic punctuation.

Demo: https://cloud.google.com/speech-to-text#section-2

## Section 10

Auto ML Vision. 