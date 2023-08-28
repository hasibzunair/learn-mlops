# PyTorch + FastAPI Backend

This code is deployed as an API in Cloud Run. For more details on the backend, see [imagercg-waiter/backend](https://github.com/hasibzunair/imagercg-waiter/tree/main/backend).

## Deploy API to Cloud Run

~~~markdown

1. Build image:

  ```bash
  # build
  docker build -t classifier:v1 .
  ```

2. Run:

  ```bash
  # run
  docker run -p 8000:8080 classifier:v1
  # get predictions
  curl -X POST -F image=@test1.jpeg "http://0.0.0.0:8000/api/predict"
  ```

3. Deploy:

  ```bash
  # Set an environment variable with your GCP Project ID
  export GOOGLE_CLOUD_PROJECT=<PROJECT_ID>

  # Submit a build using Google Cloud Build
  gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/classifier

  # Deploy to Cloud Run
  gcloud run deploy classifier \
  --image gcr.io/${GOOGLE_CLOUD_PROJECT}/classifier
  ```
~~~

After deployment, run `curl -X POST -F image=@test1.jpeg "https://classifier-j3y7zumhxa-uc.a.run.app/api/predict"` to get predictions for an image.
