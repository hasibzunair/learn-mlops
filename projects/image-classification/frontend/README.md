# Gradio Frontend
This is deployed as a web app in Cloud Run. More details at [imagercg-waiter/frontend](https://github.com/hasibzunair/imagercg-waiter/tree/main/frontend).

## Deploy Webapp to Cloud Run

~~~markdown

1. Build image:

  ```bash
  # build
  docker build -t webappimagercg:v1 .
  ```

2. Run:

  ```bash
  # run
  docker run -p 8000:8080 webappimagercg:v1
  # app should be live in http://0.0.0.0:8000
  ```

3. Deploy:

  ```bash
  # Set an environment variable with your GCP Project ID
  export GOOGLE_CLOUD_PROJECT=<PROJECT_ID>

  # Submit a build using Google Cloud Build
  gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/webappimagercg

  # Deploy to Cloud Run
    gcloud run deploy webappimagercg \
    --image gcr.io/${GOOGLE_CLOUD_PROJECT}/webappimagercg
  ```

~~~

Now, simply upload your images to see the predictions made by the model in a web interface at https://webappimagercg-j3y7zumhxa-uc.a.run.app/.
