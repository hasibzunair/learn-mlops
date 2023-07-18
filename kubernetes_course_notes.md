Kubernetes for the Absolute Beginners - Hands-on

Course link - [link](https://concordia.udemy.com/course/learn-kubernetes/learn/lecture/9703196#overview). General linl: [here](https://www.udemy.com/course/learn-kubernetes/).


### Section 2 ### 

What is Kubernetes? 

Container + Orchestration

Container
Docker
Setup end-to-end stack, different components, compatible with underlying OS. 
Compatibility of libraries, dependencies and versions. Matrix from hell!

Run each component on separate env with their own dependencies using docker.

Isolated environments. Share same OS.



Orchestration
Scale up or down based on load - automatically deploying and managing containers is container orchestration

Docker swarm, kubernetes, mesos

Kubernetes manages multiple instances running on different nodes. Increase number of containers if needed, increase hardware if needed. 


Basics
Node: VM where kubernetes in installed, container runs here. (Minion)
Cluster: Set of nodes, app accessible from other nodes if one fails.
Master: Watches over all nodes and does orchestration.

API server, etcd (key, value store), kubelet (make sure container running on nodes), container runtime (docker), scheduler (assign to nodes), controller (bring up new containers)

Containers hosted on worker nodes. 
Master has etcd, controller and scheduler

Kubectl commands: 
kubectl run hello-minikube
kubectl cluster-info
kubectl get nodes


### Section 3 ### 

To setup a cluster
Minikube, Microk8s
GCP, AWS, Azure

Kubectl 

### Section 4 ### 

PODs
Single instance of an application, inside is a docker container, encapsulated in a pod.

PODs can have different containers, not the same kind. Example: helper container. 

kubectl run nginx —image nginx 
-> creates a pod, deploy instance of nginx docker image

kubectl get pods
-> see list of pods

kubectl describe pod nginx 


### Section 5 ### 

YAML
Dictionary unordered
Lists ordered 

POD definition: apiversion, kind, metadata, spec

kubectl create -f pod-definition.yml
kubectl get pods
kubectl describe pod myapp-pod


Make pod with YAML

#######pod.yaml######
apiVersion: v1
kind: Pod
metadata:
	name: nginx
	labels: 
		app: nginx
		tier: frontend
spec:
	containers:
		- name: nginx
	  	   image: nginx
###################

cat pod.yaml # see file

# Build POD
kubectl apply -f pod.yaml 
kubectl get pods
kubectl describe nginx

Tools to verify structure of YAML files: VSCode YAML extension

###pod.yaml###
apiVersion: v1
kind: Pod
metadata:
  name: postgres
  labels:
    tier: db-tier
spec:
  containers:
    - name: postgres
      image: postgres
      env:
        - name: POSTGRES_PASSOWRD
          value: mysecretpassword
#############

kubectl run reds —image=redis123 —dry-run=client -o yaml
kubectl edit pot redis


Kubernetes controllers

Replica controller runs multiple instances of a single pod - high availibility
Create multiple pods when users increases, works also on multiple nods if needed, to scale application

Replication controller, replica set


Replication controller
######## rc-definition.yml ############
apiVersion: v1
kind: ReplicationController
metadata:
	name: myapp-rc
	labels:
		app: my app
		type: front-end
spec:
	template:
		POD definition file (see pod.yaml)

replicas: 3

#################### 

Kubectl create -f rc-definition.yml
Kubectl get replication controller


Replica Set

######### replica-definition.yml ########## 
apiVersion: apps/v1
Kind: Replicaset
Metadata:
	name: myapp-repset
	labels: 
		app: my app
		type: front-end

Spec:
	like before

Replica: 3
Selector: 
	matchLabels:
			type: front-end
##############################

Kubectl create -f replicates-definition.yml



Labels and selectors
Monitor existing pods
Deploy new ones if any of them fails
Provide labels as filters, so replicates knows which pods to monitor


Scale
Kubectl replace -f replicates-definition.yml 
Kubectle scale —replicas=6 -f replicaset-definition.yml
Kubectl scale —replicas=6 replicates my-app-replicaset (type name format)


Kubectl create -f replicase-definition.yml
Kubectl get replicates
Kubectl delete replicates myapp-replicaset # also deletes pods

### replicaset.yaml ###
apiVersion: apps/v1
Kind: replicates
Metadata:
	name: myapp-replicaset
	labels:
		app: my app
	spec:
		selector:
			matchlabels:
				app: my app
		replicas: 3
		template:
			metadata: 
				name: nginx-2
				labels:
					app: my app
			spec:
				containers:
					- name: nginx
					   image: nginx
###########################

Kubectl describe replicates myapp-replicaset
Kubectl edit replicaset myapp-replicaset # edit replica set, opens new file, go to spec and change replicates to 4
Kubectl get pods # now it is 4

Kubectl scale replicates myapp-replicaset —replicas=2


##################
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend
  labels:
    app: mywebsite
    tier: frontend
spec:
  replicas: 4
  template:
    metadata:
      name: myapp-pod
      labels:
        app: myapp
    spec:
      containers:
        - name: nginx
          image: nginx
  selector:
    matchLabels:
      app: myapp
##################


Replicates make sure desired PODs are running

Deployment definition

This is one step up in the hierarchy. So we have docker containers encapsulated	in pods that run an instance of our app. Then we have many pods in a replicates. Now, we have Deployment that handles this replicates object. 

Kubectl create -f dep-def.yml
Kubectl get deployments
Kubectl get replicates
Kubectl get pods
Kubectl get all
Kubectl describe deployment my-deployment


##################
Pod-def.yml
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    app: myapp
spec:
  containers:
    - name: nginx
      image: nginx
##################

##################
deployment-definition.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
  labels:
    app: mywebsite
    tier: frontend
spec:
  replicas: 4
  template:
    metadata:
      name: myapp-pod
      labels:
        app: myapp
    spec:
      containers:
        - name: nginx
          image: nginx
  selector:
    matchLabels:
      app: myapp

##################



###
# deployment.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: httpd-frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      name: httpd-frontend
  template:
    metadata:
      labels:
        name: httpd-frontend
    spec:
      containers:
      - name: httpd-frontend
        image: httpd:2.4-alpine
###


Updates and rollbacks in deployment

Rollout and versioning

Track new deployments, go back if needed
kubectl rollout status deployment/my-app-deployment

Deploy strategy
- Recreate
- Take down older, bring up newer (rolling updates)

Kubectl apply -f deployment-def.yml


Create: 
kubectl create -f deployment-def.yml

Get: 
Kubectl get deployments

Update:
Kubectl apply -f deployment-def
Kubectl set image deployment/myapp-deployment nginx=nginx:1.9.1

Status:
kubectl rollout status deployment/myapp-deployment
kubectl rollout history deployment/myapp-deployment

Rollback:
Kubectl rollout undo deployment/myapp-deployment

kubectl edit deployment frontend - change manually 


### Section 6 ### 

Each POD gets its own IP address
10.244.0.0

Setup networking manually
Flannel, Cisco 

Assign diff IP to each node for easy communication. 

### Section 7 ### 

Services 

Enable connectivity between groups of PODs, external data source.

Node port service
ClusterIP
Load balancer


################
service-def.yml
——————————
apiVersion: v1
kind: Service 
Metadata:
	name: my app-service
spec:
	type: NodePort
	ports:
		- targetPort: 80
		   port: 80
		   nodePort: 3008
	selector:
		# refer to pod-def file
		app: my app
		type: front-end
################

Kubectl create -f service-def.yml
Kubectl get services
Curl http://192.168.1.2.30008



What if many pods?
We have many pods running instances of our web app.
No extra config needed!

Kubectl get deployments
Kubectl get pods
Kubectl create -f service-def.yml
Kubectl get sev 
Minikube service my app-service —url 
URL is up and running, we can try to access using our browser



Cluster IP
Establish connectivity

Load balancer

Type: LoadBalancer

Supports with GCP, AWS, Azure

###############
apiVersion: v1
kind: Service
metadata:
  name: frontend
  labels:
    app: myapp
spec:
  type: NodePort
  ports:
    - port: 80
      targetPort: 80
  selector:
    app: myapp


apiVersion: v1
kind: Service
metadata:
  name: image-processing
  labels:
    app: myapp
spec:
  type: ClusterIP
  ports:
    - port: 80
      targetPort: 8080
  selector:
    tier: backend



--
apiVersion: v1
kind: Service
metadata:
  name: webapp-service
  namespace: default
spec:
  ports:
  - nodePort: 30080
    port: 8080
    targetPort: 8080
  selector:
    name: simple-webapp
  type: NodePort
############### 


### Section 8 ### 

Microservices

Goals
Deploy containers
Enable connectivity (what app requires access to what service) 
Enable external access (users access from browsers)

Steps
Deploy PODs (which has docker container of app/service inside it)
Create service (ClusterIP)
- Redis
- db
Create Services (nodeport)
- voting-app
- result-app

Service is needed that needs to be exposed.



### Section 9 ### 

AWS: kops, KubeOne

Kubernetes as a service, GKE

GKE, EKS, AKS for Google cloud, AWS and Azure


### Conclusion ### 

Kubernetes overview
Containers - docker
Container archestration
Demo
Kubernetes concepts - PODs, ReplicaSets, Deployment, Services
Networking in Kubernetes
Kubernetes Management - Kubectl 
Kubernetes definition files - YAML
Kubernetes on Cloud - AWS/GCP














