FROM node:20-slim

WORKDIR /app

COPY package*.json /app

RUN npm install

COPY . /app

# Add environment variables for MongoDB connection
ENV DBuser=shery 
ENV DBpass=1521  
ENV DBhosts=mongo-0.mongo.default.svc.cluster.local:27017

EXPOSE 3000

CMD ["node", "index.js"]





 # ----- use these commands to build and push in repo --------

#gcloud compute ssh --zone "us-east1-b" "my-vm-shereen" --tunnel-through-iap --project "sherein" //sssh 
#suso docker build -t shereen:latest . 
#suso docker tag shereen:latest us-central1-docker.pkg.dev/sherein/my-repo/shereen:latest
#gcloud auth configure-docker us-central1-docker.pkg.dev
#gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin  us-central1-docker.pkg.dev
#sudodocker push us-central1-docker.pkg.dev/sherein/my-repo/shereen:latest


#----------mongo---- will pull mongo image on the vm to push to the local repo so it can use it . 
# sudo docker pull mongo:5.0.15
# sudo docker tag mongo:5.0.15 us-central1-docker.pkg.dev/sherein/my-repo/mongo:5.0.15
# gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin  us-central1-docker.pkg.dev
# sudo docker push us-central1-docker.pkg.dev/sherein/my-repo/mongo:5.0.15

--- 

#then pull mongo-rs-cidecar:latest to use it inside the statefulset .

# sudo docker pull docker.io/cvallance/mongo-k8s-sidecar

# sudo docker tag cvallance/mongo-k8s-sidecar:latest us-central1-docker.pkg.dev/sherein/my-repo/cvallance/mongo-k8s-sidecar:latest

# gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin  us-central1-docker.pkg.dev

# sudo docker push us-central1-docker.pkg.dev/sherein/my-repo/cvallance/mongo-k8s-sidecar:latest

# kubectl get statefulset 
# kubectl delete statefulset mongo-db 
# kubectl apply -f state.yaml 

# kubectl describe pod mongo-db-0 
# kubectl get pod -n gcp 
# kubectl logs  mongo-db-0 

#   openssl rand -base64 756 > keyfile  // create keyfile 
#   chmod 400 keyfile

   #mongo --host  mongo-0.mongo.default.svc.cluster.local:27017  -u shery -p  1521  --authenticationDatabase admin

#   kubectl logs  mongo-0 -c mongo-sidecar


#kubectl scale --replicas=5 statefulset mongo

#-----------build docker file to create node image  -----------

#sudo docker build -t node:slim .
#sudo docker tag node:slim us-central1-docker.pkg.dev/sherein/my-repo/node:slim 

## gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin  us-central1-docker.pkg.dev
#sudo docker push us-central1-docker.pkg.dev/sherein/my-repo/node:slim
