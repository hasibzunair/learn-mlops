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
