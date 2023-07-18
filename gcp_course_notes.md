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