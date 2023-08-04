from google.cloud import language_v1

# for local dev
# pip install google-cloud-language
# create service account and get key in gcp IAM (get json)
# export GOOGLE_APPLICATION_CREDENTIALS="KEY_PATH"
# run python request.py

def sample_analyze_sentiment(content):
    client = language_v1.LanguageServiceClient()

    # content = 'Your text to analyze, e.g. Hello, world!'

    if isinstance(content, bytes):
        content = content.decode("utf-8")

    type_ = language_v1.Document.Type.PLAIN_TEXT
    document = {"type_": type_, "content": content}

    response = client.analyze_sentiment(request={"document": document})
    sentiment = response.document_sentiment
    print(f"Score: {sentiment.score}")
    print(f"Magnitude: {sentiment.magnitude}")


sample_analyze_sentiment("Hey man, good job!")