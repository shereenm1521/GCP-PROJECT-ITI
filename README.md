#GCP-PROJECT-ITI
##Project Description

This project is designed to run on Google Cloud Platform (GCP) and involves setting up a MongoDB database and a Node.js application connected to the database using Kubernetes for container orchestration.
Prerequisites.
![image](https://github.com/shereenm1521/GCP-PROJECT-ITI/assets/140805315/e52a9b62-85a6-4397-89a0-cd7c8bac52df)


    GCP account with access to create and manage resources
    Installed gcloud command-line tool
    Docker installed on your local machine
    Project Overview
**
    ##Infrastructure Setup
        Develop and utilize your own Terraform modules to create the necessary infrastructure on GCP, including the following components: a. IAM: Create two service accounts with appropriate roles. b. Network: Establish one Virtual Private Cloud (VPC) with two subnets, configure firewall rules as needed, and set up one NAT gateway. c. Compute: Deploy one private Virtual Machine (VM) and create one Google Kubernetes Engine (GKE) standard cluster spanning across three zones. d. Storage: Set up an Artifact Registry repository to store container images.
**

    - MongoDB Deployment
        Deploy a MongoDB replica set across the three zones, ensuring high availability and replication.

    - Application Containerization and Deployment
        Dockerize the Node.js web application, ensuring it can connect to the three MongoDB replicas.

    - Exposing the Web Application
        Expose the web application using an ingress controller or a load balancer for high availability and load distribution.

    - Identity-Aware Proxy (IAP) Integration
        Enable Identity-Aware Proxy on the load balancer to restrict access to the web application, allowing traffic only from authorized users.

##Setup Steps

1.SSH into the VM and run the following command to retrieve cluster credentials:
```sh
    gcloud container clusters get-credentials my-gke-cluster --region=us-central1 --project=sherein
```
```

Note: If you encounter a timeout error when running `kubectl get nodes`, ensure that the "enable global access" option is enabled in your cluster configuration.

2.build the MongoDB Docker image:
sudo docker build -t mongo:5.0.15 .
sudo docker tag mongo:5.0.15 us-central1-docker.pkg.dev/sherein/my-repo/mongo:5.0.15
gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin us-central1-docker.pkg.dev
sudo docker push us-central1-docker.pkg.dev/sherein/my-repo/mongo:5.0.15
```
```
sh
3.Pull the Mongo sidecar image and tag it:
*sudo docker pull docker.io/cvallance/mongo-k8s-sidecar
*sudo docker tag docker.io/cvallance/mongo-k8s-sidecar:latest us-central1-docker.pkg.dev/sherein/my-repo/cvallance/mongo-k8s-sidecar:latest
*gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin us-central1-docker.pkg.dev
*sudo docker push us-central1-docker.pkg.dev/sherein/my-repo/cvallance/mongo-k8s-sidecar:latest
```


```
4.Run the following commands to deploy your files using kubectl:
```sh
kubectl apply -f filename.yaml 

   Note:replace the image name in your files with the actual image name you assigned it when building.

Check the logs of the Mongo sidecar:
```sh
kubectl logs mongo-0 -c mongo-sidecar
```
5.Access the Mongo pod:
```sh
kubectl exec -it mongo-0 bash
mongo --host mongo-0.mongo.default.svc.cluster.local:27017 -u shery -p 1521 --authenticationDatabase admin
``
```sh`
6.Build the Node.js Docker image and connect the app with the database:

*sudo docker build -t node:slim .
*sudo docker tag mongo:slim us-central1-docker.pkg.dev/sherein/my-repo/mongo:slim 
*gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin us-central1-docker.pkg.dev
*sudo docker push us-central1-docker.pkg.dev/sherein/my-repo/node:5.0.15
```
-----------------------
7.Deploy your application . 🙂
``
