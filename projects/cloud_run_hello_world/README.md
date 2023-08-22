# Usage

1. Build: `docker build --tag helloworld:python .`
2. Run locally: `docker run --rm -p 9090:8080 -e PORT=8080 helloworld:python`, see http://0.0.0.0:9090/.
3. Deploy: 

```bash
# Set an environment variable with your GCP Project ID
export GOOGLE_CLOUD_PROJECT=<PROJECT_ID>

# Submit a build using Google Cloud Build
gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/helloworld

# Deploy to Cloud Run
gcloud run deploy helloworld \
--image gcr.io/${GOOGLE_CLOUD_PROJECT}/helloworld
```

## todos
* TBA.

## References
- https://cloud.google.com/run/docs/quickstarts/build-and-deploy/deploy-python-service
- https://github.com/GoogleCloudPlatform/python-docs-samples/tree/main/run