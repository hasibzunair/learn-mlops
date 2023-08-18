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

AutoML notes.
In last few section we learned how to apply ML with Prebuilt API for vision, language & speech related generic use cases.

Now onwards we will start will auto training with our own custom data using Google Cloud AutoML algorithm.

Exited, Taking more charge on our data & model.

## Section 11

Auto ML Vision.

Prepare data, train, deploy, test.

### Prepare Data

See https://cloud.google.com/vertex-ai/docs/image-data/classification/prepare-data. 

Upload data in Cloud Storage. Open cloud shell, then run
```
gsutil ls gs://my_automl_image_dataset/shoe_sandal_boot_dataset/ # see three folders
```

Make csv file with image path and labels. (image-classify-dataset.csv).

Go to Vertex AI Dataset and create dataset placeholder and import data from Cloud Storage. Add the path to the CSV file created earlier.

### Training
Go to Vertex AI Training and create training job. In model details, do shoe_sandal_boot_training. Data split randomly assigned. After training, see the training job and see what's inside. 

### Deploy to endpoint
This automaitcally takes us to 
Vertex AI Model Registry, then go to Deploy and Test tab, two options: deploy as endpoint or batch predict for offline use.

Either do Deploy to Endpoint or go to Vertex AI Online Prediction tab. Set number of compute nodes to 1 when Deploy to Endpoint. 

The go to Model Registry > shoe_sandal_boot_training > Deploy and test and then simply upload images and test it! To delete, first undeploy endpoint and then delete it. Delete model registry artifacts, dataset from vertex dataset, and storage.

## Section 12

Text classification.

## Section 13

Tabular data

## Section 14

Google Cloud Vertex AI.

Custom training: Own dataset, own model, write algo (scikit-learn, Tensorflow, PyTorch).

Different from AutoML and API, in custom training do everything yourself lol.

Custom training: Prebuilt containers and custom containers. See https://cloud.google.com/vertex-ai/docs/training/pre-built-containers. 

Artifact Registry: Storage for docker images.

Choose training method: AutoML vs Custom Training. See https://cloud.google.com/vertex-ai/docs/start/training-methods.

**Vertex AI**: Platform to build, deploy and scale ML models inside GCP. See https://cloud.google.com/vertex-ai.

## Section 15

### Custom training using IRIS dataset

-Explore data
-Setup cloud storage bucket
-Upload data to bucket
-Create notebook instance
-Training code
-Make docker container
-Push docker image to artifact registry
-Setup custom training with custom container
-Import model from bucket to model registry
-Deploy to endpoint

1. Create a bucket in GCS and upload data csv file.
2. Go to Vertex AI Workbench and create managed notebook
3. Train model and save model to GCS
4. Convert notebook to train.py (`jupyter nbconvert Training.ipynb --to python`). Make req.txt and Dockerfile.
5. Go to Artifact Registry and create artifact repo. Here we want to upload our docker image. Get URL (us-central1-docker.pkg.dev/vertex-course-hzr/custom-training-artifacts).
6. Now give it image name and image tag like: us-central1-docker.pkg.dev/vertex-course-hzr/custom-training-artifacts/iris_custom:v1. Then run `export IMAGE_URI=us-central1-docker.pkg.dev/vertex-course-hzr/custom-training-artifacts/iris_custom:v1` in terminal inside custom training folder where you have all files like train.py req.txt and dockerfile. Then do `echo $IMAGE_URI` to check. 
7. Make image `docker build -f Dockerfile -t ${IMAGE_URI} ./`.
8. Now, we have docker image, before pushing to Artifact Registry we do sth. Go to AR and then setup instructions, copy command and run in terminal.
9. Now push to registry: `docker push ${IMAGE_URI}`. You will see the image in AR named iris_custom version v1.
10. Custom training with custom container: Go to vertex ai training, create new job, use default service account, custom container select the one we made in step 9, model output path is hardcoded in train.py, select no prebuilt container. Start training! Now you should see model.pkl in cloud storage where IRIS.csv is stored.
11. Go to Model Registry, set framework and version, set path to trained model.
12. Deploy model to endpoint, (go to right three dots and click, directly deploy from there or go iris-custom-model). Select machine, compute engine default service account, enable logging. Go to iris-custom-model and Deploy and Test. 
13. Test endpoint. See Sample Request for instructions.

In Cloud Shell:
```
# authenticate in CLI
gcloud auth application-default login
# env variables
ENDPOINT_ID="2126264173095550976"
PROJECT_ID="105664692517"
INPUT_DATA_FILE="INPUT-JSON"
# curl
curl \
-X POST \
-H "Authorization: Bearer $(gcloud auth print-access-token)" \
-H "Content-Type: application/json" \
https://us-central1-aiplatform.googleapis.com/v1/projects/${PROJECT_ID}/locations/us-central1/endpoints/${ENDPOINT_ID}:predict \
-d "@${INPUT_DATA_FILE}"
```

See custom_container_custom_train for codes.

todo: python script request, aiplatofrm not working now.

Undeploy model, delete endpoint, 

Two way to predict:

1. Online prediction (immediate result needed, must be deployed).
2. Batch prediction (high volumes, run as job, no deployment needed from our end).

Go to Batch Predictions, define input and output path, define machine, service accounts.

## Section 16

### Pre-built container training using IRIS dataset

1. Create new bucket, set region to us-central1.
2. Move data from custom-training-bucket to new one.

```bash
gsutil ls # see buckets
gsutil cp gs://my_custom_container_training/IRIS.csv gs://my_prebuilt_container_training/
```

3. Start noteook instance, customnotebooktraining, create new folder prebuilt_container and keep files there. Select kernel TensorFlow 2 (Local).
4. See prebuilt_container_custom_train/train.ipynb for training code that will be submitted as job after converting to script. Run `jupyter nbconvert train.ipynb --to python`.
5. Make a folder trainer in keep train.py there along with empty __init__.py file, and then add a setup.py outside of trainer folder. (prebuilt_container should have trainer/ and setup.py) Then run `python setup.py sdist --format=gztar`.
6. Copy dist/trainer-0.2.tar file in GCS dataset bucket. `gsutil cp dist/trainer-0.1.tar.gz gs://my_prebuilt_container_training/`.
7. Go to Vertex AI Training and create job (iris_prebuilt_training), CE service account, set prebuilt container and add my_prebuilt_container_training/trainer-0.1.tar.gz, python module trainer.train.
8. Go to Vertex AI Model Registry and create new import, define container settings and path to model (my_prebuilt_container_training/model_output/)
9. Go to model import and deploy and test to endpoint, then hit deploy to endpoint, set machine type and service account. Hit deploy!
10. Test JSON, then undeploy and delete endpoint


### Pass arguments while training

In both cases, if we want to change data, and define output again and again. Let's do using arguments. Parameterize inputs and output while submitting jobs, instead of hardcoding it.

1. Make train.py to accept arguments.
2. Make setup.py with new version and package code: `python setup.py sdist --formats=gztar`, download the tar file.
3. Upload tar file to gcs, `gsutil cp dist/trainer-0.2.tar.gz gs://my_prebuilt_container_training/`.
4. Create training job. In arguments add:

```
--input_data=gs://my_prebuilt_container_training/IRIS.csv
--mod_out=gs://my_prebuilt_container_training/mod_out_withargs
```

After training, you will see model artifacts in a new folder in gcs. Then rest of deployment stuff is the same.

## Section 17

Vertex AI Labeling task to label your data.

Vertex AI Pipelines. 

1. Go to Workbench > User managed notebooks > Create new.
2. Open an do pipeline1.ipynb.