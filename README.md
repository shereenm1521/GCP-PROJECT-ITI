# GCP-PROJECT-ITI
# projec-GCP-ITI
first step shh the vm and run the follwing commands 

  gcloud container clusters get-credentials my-gke-cluster --region=us-central1 --project=sherein
  then try to kubectl get nodes if you got error timeout ,makesure the enable global access is anables in your cluster code .
  if you got the nodes successfully .

  then - create docker file to build mongo image including the keyfile path to be copied with the container . 
    ----build mongo image---- 
  sudo docker build -t mongo:5.0.15 
  #sudo docker tag node:latest us-central1-docker.pkg.dev/sherein/my-repo/node:latest  

# gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin  us-central1-docker.pkg.dev
# sudo docker push us-central1-docker.pkg.dev/sherein/my-repo/mongo:5.0.15

------
the same on vm try to pull sidecar-iamge and give a tag and push to the repo to use it later in the the statefulset file . 

 sudo docker pull docker.io/cvallance/mongo-k8s-sidecar

 sudo docker tag cvallance/mongo-k8s-sidecar:latest us-central1-docker.pkg.dev/sherein/my-repo/cvallance/mongo-k8s-sidecar:latest

 gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin  us-central1-docker.pkg.dev

 sudo docker push us-central1-docker.pkg.dev/sherein/my-repo/cvallance/mongo-k8s-sidecar:latest
---------
try to run commands kubectl and apply your files .// makesure to replace the image name in the your files  with the accual image name you gave it to the image when you built it.
don't forget to create service account and role pinding and reference it in the statfulset file to give the cluster permission to list pods . 

kubectl logs  mongo-0 -c mongo-sidecar  -- to check the logs of sidecar 
---------

try to run this command to get inside the mongo pod 
kubectl exec -it mongo-0 bash
 mongo --host  mongo-0.mongo.default.svc.cluster.local:27017  -u shery -p  1521  --authenticationDatabase admin
show databases  --- 

inside the MongoDB shell, run the following command to initiate the replica set configuration: // in case you didn't use sidecar 

rs.initiate()

After initiating the replica set, you can add the other pods as secondary nodes. Use the following command to add a secondary node:

rs.add("<pod-name>")

Repeat the last step for each secondary pod you want to add.
----------
----- run dockerfile node to build the nodejs image and connect the app with the datatabse . 
#sudo docker built -t node:latest .
#sudo docker tag node:latest us-central1-docker.pkg.dev/sherein/my-repo/node:latest  

## gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin  us-central1-docker.pkg.dev
and then the push command -then deploy 


mongosh mongodb://mongo-0.mongo.default.svc.cluster.local  --eval "db.getMongo().setReadPref('nearest')"
