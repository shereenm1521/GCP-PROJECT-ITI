provider "google" {
  credentials = file("sherein-198b2bbdc92d.json")
  project = "sherein"
  region  = "us-east1"
}




#----------- commands ----------------

# gcloud auth application-default set-quota-project sherein  # to control qouta 
# gcloud auth activate-service-account  --key-file="sherein-198b2bbdc92d.json"  //active the service account with the new project. 

#TO CONNECT THE CLUSTER 
#first step ssh vm 
#curl https://sdk.cloud.google.com | bash   // install gcloud 
#cat /etc/os-release   // to check os 
#gcloud components install gke-gcloud-auth-plugin
#gke-gcloud-auth-plugin --version 

# gcloud container clusters get-credentials my-gke-cluster --region=us-central1 --project=sherein
#     
#    
#gcloud components install kubectl
#kubectl get pod 

#  if your os debian 
#sudo apt-get install -y kubectl
#sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
# gcloud container clusters get-credentials my-gke-cluster --region=us-central1 --project=sherein

#---------Docker file run --------------


#before that you need to install docker 
#sudo apt-get update
#sudo apt-get install docker.io
# docker build -t test:v01 .
# docker tag test:v01 us-central1-docker.pkg.dev/idyllic-depth-401020/my-images/test:v01
# gcloud auth configure-docker us-central1-docker.pkg.dev
# docker push us-central1-docker.pkg.dev/idyllic-depth-401020/my-images/test:v01