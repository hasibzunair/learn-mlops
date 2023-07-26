# GCP Fundamentals for Beginners Notes

Course Link - [Link](https://www.udemy.com/course/google-cloud-platform-gcp-fundamentals-for-beginners/)

### Section 1
Know building blocks of GCP
Compute, storage, networking, databases, devops, AI and anthers 

### Section 2

Compute, Storage, Network, Database, Data and Analytics, AIML, API management, Migration, Hybrid & multi-cloud, security and devops, finally management tools. 

Key GCP services: Compute, Storage and Databases, Networking, Security and Identity, AIML, Devops Tools, Management tools

### Section 3

Resources belong to project

Each project is a billable resource based on consumption

GCP hierarchy: Organization -> Folders -> Projects -> Resources

GCP can be accessed with web console, cloud shell, mobile app, rest api 

GCP cloud shell: based on a GCE VM, 5GB disk storage, web preview functionality

```gcloud compute regions list```


### Section 4

Compute services: Code is deployed and executed in one of the computer services

Compute services: App engine, Compute engine, Kubernetes engine, Cloud functions

App Engine:
Deploy and executed code, scale when needed. Standard and flexible. 

Compute Engine: 
Launch linux and windows VM. VMs have configurable CPU RAM.
Lose all changes once terminated. Ephimeral. 
Persistence available through local SSDs.

Kubernetes Engine: 
GKE is for deploying containerized applications

Cloud functions: 
Build and connect cloud services
Execute code in response to an event
Write code as function, define entry point and exit point. Does not run forever.
Function as a service (FaaS)

Go to Compute Engine and VM instances, create a VM. And then: 
```
# Launch a GCE instance
gcloud compute instances list
# ssh into VM
 gcloud compute ssh instance-1 --zone us-west4-b
Sudo apt-get update
Sudo apt-get install -y apache2
Sudo systemctl start apache2
# now see external IP, you should see webpage
```

### Section 5

Object, block and file system

GCP Storage: Unstructured data, folder and files.

**Cloud Storage**: GCS API, store large data

Standard storage class: Images (high frequency access)
Nearline: Data accessed less frequently
Coldline: Accessed least frequently

Nearline and coldline for backup or archival data.

**Persistent Disks**: If we want storage attached to compute (GCE/VMs). Lifecycle of PD is not dependent on VMs. Massive storage (64TB).

**Cloud filestore**: mimic local file system.

Bucket -> Folder -> Files

### Section 6

GCP Network services. Premium and standard network tier.

Load balancer distributes traffic across multiple GCE VMs in a single or multiple regions. Deploy app across globe!

HTTPS and Network load balancer.

HTTPS -> web apps, global
Netowrk -> confined to a region 

Internal or external load balancing.

Virtual private cloud (VPC): private networking for VMs.

Hybrid connectivity: Cloud Interconnect, Cloud VPN, Peering.

Go to Compute Engine -> Instances templates and create instance
```bash
# Copy this code in startup script when creating instance

#! /bin/bash
apt-get update
apt-get install -y apache2
cat <<EOF > /var/www/html/index.html
<html><body><h1>Hello from $(hostname)</h1>
</body></html>
EOF
```
Then go to CE -> Instance Groups.

Summary: Instance template, VM Config, Instance Group (2), Health check, all withing GCE. Then network services,load balancing: backend and health check, front end. Gives public IP.

Load balancer talking GCE VMs.

### Section 7

Resources: Projects, Cloud Storage buckets, Compute Engine instances.

Permissions.

Cloud IAM controls access, who has access to what: who ,what, which. Enable or disable a resource for a member.

By default all access denied.

Cloud IAM permissions.

Roles: Owner, Editor, Viewer.

Users: Google account, google group, g suite domain

Resource, permissions, roles and users.

IAM service account.

### Section 8

Database services.

Cloud SQL.

MySQL, PostgreSQL.

**Cloud Bigtable**: Storage engine for large-scale, low-latency applications. Data processing and analytics workload. Datastore for ML applications.

Cloud spanner: Relational database service. Scale across regions.

### Section 9

GCP Data Analytics & Services

Cloud pub/sub, data flow, dataproc, datalab, bigquery

Ingestion collection process analyze and visualize data

Cloud pub/sub: Ingest data, entry point to gcp-based analytics service. Staging location for data. 

Cloud data flow: Preprocess, Transform and enhance data in stream. Apache Beam project. Tighly integrated with Bigquery, Cloud ML, Cloud pub/sub. Easy to integrate Apache Kafka.

Cloud data proc: Scale big data infra. Move big data projects to GCP without redevelopment. 

Cloud datalab: Tool for exploring, vis, ana;yze and query data, analyze, vis and ML. Runs on compute engine and may connect to multiple cloud services. Quick analysis, support python sql java langs. 

BigQuery: Analyze data, cloud data warehouse. Ingest data automatically. In memory BI engine and ML built in. Automatically replicates data to keep history of changes.

### Section 10

ML and AI services
Cloud AI Building Blocks
Cloud AutoML
AI Platform
AI Hub
Use cases of ML and AI services.

**GCP AI Building Blocks**: Sight (Vision, Video), Conversation (Text to speech), Language (translation), Structured data (recommendations). Black boxes, cannot work on custom data.

**Google Cloud AutoML**: Train model but dont write complex code. Custom ML models, Google SOTA ML algo. Sight (Vision and video intelligence), Language, Structured data. Useful for custom data specific to a business problem.

**Google Cloud AI Platform**: Advanced use cases. Covers entires spectrum of ML pipelines, built on kubeflow, include tools for data prep, train, infer.

Google Cloud AI Platform workflow: Ingest data, prepare, process, discover, develop, train, test and analyze, deploy.

**Google Cloud AI Hub**: Hosted repo of AI components. Easy for collab, private and public content. Kubeflow pipeline components, jupyter notebooks, tensorflow modules, VM images, trained model and so on.

**Overview**: 

Cloud building blocks: REST API endpoint (Infuse AI into app with API call)
Cloud AutoML: Based on custom data, no-code approach to training models (Train and deploy models on custom data)
AI Platform: ML Pipelines (Train ML models on-prem and deploy it in the cloud)
AI Hub: ML artifact repo to save models datasets etc. (Reuse existing TensorFlow models share by other users.)

### Section 11

DevOps Services.

Cloud source repositories: private git repo, git workflow, cloud pub/sub, compute services. Unlimited private git repo, mirror code from github. Trigger automatically build, test, deploy code. Code search. 

Cloud Build: CI/CD tool. Any language. Deploy in multiple environments. Integration with github, bitbuket etc. Support docker with auto deploy to Kubernetes or GKE.

Container Registry: Manage container images, GCE, GKE. Very fast, secure private scalable docker registry within GCP. Access, view and download images. 

Dev Tools: VSCode IDE, enhance dev productivity.

Demo time: Go to GCP Container Registry. To go cloud shell and run:

```
# this is demo.sh
gcloud services enable containerregistry.googleapis.com

export PROJECT_ID=focus-semiotics-393216

docker pull busybox
docker images

# build, tag, run
docker build . -t mybusybox # see code snippet below to make dockerfile before running this
docker tag mybusybox gcr.io/$PROJECT_ID/mybusybox:latest
docker run gcr.io/$PROJECT_ID/mybusybox:latest # test local image, should give date and time

# gcp creds with docker cli
gcloud auth configure-docker
docker push gcr.io/$PROJECT_ID/mybusybox:latest
```

```
# this is Dockerfile
from busybox:latest
CMD ["date]
```
Now if you refresh Container Registry page, there will be mybusybox image.

Cloud Source Repo: Store code
Cloud Build: Pipelines to deploy code
Container Registry: Store images in same regions as GKE clusters.
IDE Integration: Manage and deploy apps from the IDE.

### Section 12

### Section 13


