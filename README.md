GCP-PROJECT-ITI
Project Description

This project is designed to run on Google Cloud Platform (GCP) and involves setting up a MongoDB database and a Node.js application connected to the database using Kubernetes for container orchestration.
Prerequisites
![image](https://github.com/shereenm1521/GCP-PROJECT-ITI/assets/140805315/73768398-f538-45b3-b408-2d4d99cd541c)


    GCP account with access to create and manage resources
    Installed gcloud command-line tool
    Docker installed on your local machine

Project Overview

Infrastructure Setup

Develop and utilize your own Terraform modules to create the necessary infrastructure on GCP, including the following components:

    - IAM: Create two service accounts with appropriate roles.

    - Network: Establish one Virtual Private Cloud (VPC) with two subnets, configure firewall rules as needed, and set up one NAT gateway.

    - Compute: Deploy one private Virtual Machine (VM) and create one Google Kubernetes Engine (GKE) standard cluster spanning across three zones.

    - Storage: Set up an Artifact Registry repository to store container images.

    - MongoDB Deployment Deploy a MongoDB replica set across the three zones, ensuring high availability and replication.

    - Application Containerization and Deployment Dockerize the Node.js web application, ensuring it can connect to the three MongoDB replicas.

    - Exposing the Web Application Expose the web application using an ingress controller or a load balancer for high availability and load distribution.

    - Identity-Aware Proxy (IAP) Integration Enable Identity-Aware Proxy on the load balancer to restrict access to the web application, allowing traffic only from authorized users.

Setup Steps

    SSH into the VM and run the following command to retrieve cluster credentials:

gcloud container clusters get-credentials my-gke-cluster --region=us-central1 --project=sherein

Note: If you encounter a timeout error when running kubectl get nodes, ensure that the "enable global access" option is enabled in your cluster configuration.

    Build the MongoDB Docker image:
```sh
sudo docker build -t mongo:5.0.15 .
sudo docker tag mongo:5.0.15 us-central1-docker.pkg.dev/sherein/my-repo/mongo:5.0.15
gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin us-central1-docker.pkg.dev
sudo docker push us-central1-docker.pkg.dev/sherein/my-repo/mongo:5.0.15
```
    Pull the Mongo sidecar image and tag it:
```sh
sudo docker pull docker.io/cvallance/mongo-k8s-sidecar
sudo docker tag docker.io/cvallance/mongo-k8s-sidecar:latest us-central1-docker.pkg.dev/sherein/my-repo/cvallance/mongo-k8s-sidecar:latest
gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin us-central1-docker.pkg.dev
sudo docker push us-central1-docker.pkg.dev/sherein/my-repo/cvallance/mongo-k8s-sidecar:latest
```
    Run the following commands to deploy your files using kubectl:

kubectl apply -f filename.yaml

Note: Replace the image name in your files with the actual image name you assigned it when building.

    Check the logs of the Mongo sidecar:

kubectl logs mongo-0 -c mongo-sidecar

    Access the Mongo pod:

kubectl exec -it mongo-0 bash
mongo --host mongo-0.mongo.default.svc.cluster.local:27017 -u shery -p 1521 --authenticationDatabase admin

    Build the Node.js Docker image and connect the app with the database:
```sh
sudo docker build -t node:slim .
sudo docker tag mongo:slim us-central1-docker.pkg.dev/sherein/my-repo/mongo:slim
gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin us-central1-docker.pkg.dev
sudo docker push us-central1-docker.pkg.dev/sherein/my-repo/node:5.0.15
```
    Deploy your application. 🙂
