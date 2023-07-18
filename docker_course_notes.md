### Docker for the Absolute Beginner - Hands On - DevOps Notes

Course Link: https://concordia.udemy.com/course/learn-docker/learn/lecture/7894186#overview, this link is for Concordia students. See general link at 
[Docker for the Absolute Beginner - Hands On - DevOps](https://www.udemy.com/course/learn-docker/).

## Some doocker commands:

#### Run a container from an image, specify image name
```
docker run centos
docker run -it centos bash # run bash in centos, get inside the container
cat /etc/*release*
exit
```

#### Containers running
`docker ps`

#### All container, running or not
`docker ps -a`

#### Stop container
`docker stop container_id/name`

#### Remove container
`docker rm container_name`

#### Remove many containers at once
`docker rm container_name_partial container_name_partial container_name_partial`

#### List images
`docker images`

#### Delete image 
`docker rmi container_name`

Need to remove container before removing image

#### Pull image only and store locally, does not run container immediately 
`docker pull image`

### Run Ubuntu and see what’s inside.
```
#Run an instance of ubuntu in background
docker run -d ubuntu sleep 100
# Will be excited state, container lives long as the process is there
docker ps -a 
# Execute command on running container. We see contents by running cat command
docker exec container_id cat /etc/*release*
```

#### Port mapping, 80 is outside host port and 5000 is docker container port.

Host port : docker port

```
docker run -p 80:5000 kodekloud/webapp 
docker run -p 81:5000 kodekloud/webapp 
```

#### Volume mapping
`docker run mysql`

#### Data will remain even if container is deleted at the given mount
`docker run -v /opt/datadir:/var/lib/mysql mysql`

#### Details of container
`docker inspect container_name`

#### See logs of container 
`docker logs container_name`

#### Detach, run container in background
`docker run -d ubuntu sleep 50`

#### Attach, bring it back to the foreground
`docker attach container_id`

#### Jenkins
`docker run jenkins/jenkins`

#### Build image
`docker build .`

#### Push
```
docker login
docker build . -t username/container_name
docker push username/container_name
```

Q. Run a container named blue-app using image kodekloud/simple-webapp and set the environment variable APP_COLOR to blue. Make the application available on port 38282 on the host. The application listens on port 8080.
A. `docker run --name blue-app -e APP_COLOR=blue -p 38282:8080 kodekloud/simple-webapp`

Q. Deploy a mysql database using the mysql image and name it mysql-db. Set the database password to use db_pass123. See docker inspect to get env variable names 
A. `docker run --name mysql-db -e MYSQL_ROOT_PASSWORD=db_pass123 mysql`

Some containers lives as long as the process inside it

```
ENTRYPOINT [“sleep”], 
CMD [“5”]
invoked when input in terminal docker run ubuntu-sleeper 10
```

#### Connect two containers 
```
docker run —links
docker run -d —name=redis redis
docker run -d name=vote -p 5000:80 —link reis:reis voting-app
```

#### Compose labs 
```
docker run -d --name redis redis:alpine
docker run --name clickcounter -p 8085:5000 --link redis:redis kodekloud/click-counter
```

#### docker compose.yml
```
services:
  redis:
    image: redis:alpine
  clickcounter:
    image: kodekloud/click-counter
    ports:
    - 8085:5000
version: '3.0'
```

`docker-compose up -d #(-d to run in background)`

#### Docker registry
```
docker run -d -p 5000:5000 --restart=always --name my-registry registry:2
docker pull nginx:latest
docker image tag nginx:latest localhost:5000/nginx:latest
docker push localhost:5000/nginx:latest

docker pull httpd:latest
docker image tag httpd:latest localhost:5000/httpd:latest
docker push localhost:5000/httpd:latest
```


### Volumes

#### Volume mounting
`docker run -v data_volume: /var/lib/mysql mysql`

#### Bind mounting 
`docker run -v /data/mysql:/var/lib/mysql mysql`

#### new way to mount
`docker run —mount type=bind, source=/data/mysql, target=/var/lib/mysql mysql`


### Docker storage 

`docker history image_name`

#### Run a mysql container again, but this time map a volume to the container so that the data stored by the container is stored at /opt/data on the host.
Use the same name : mysql-db and same password: db_pass123 as before. Mysql stores data at /var/lib/mysql inside the container.

`docker run --name mysql-db -e MYSQL_ROOT_PASSWORD=db_pass123 -v /opt/data:/var/lib/mysql mysql`

#### Container orchestration

Solution that hosts containers.

`docker service create —replicas=100 nodejs`

###  Docker swarm and kubernetes

#### Swarm
Swarm manager -> Workers
Docker service -> Run instances of service, replicas 

#### Kubernetes

Docker - single instance of application
Kubernetes - thousand instance of the same application, scale up and down depending of user load

It uses docker host to host applications in form of docker containers. 

Cluster - set of nodes, if one application fails, others will work

Master - watches over nodes, responsible for actual orchestration