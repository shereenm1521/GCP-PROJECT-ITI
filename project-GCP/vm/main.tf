resource "google_service_account" "manage_cluster" {
  account_id = var.service_account_id #"manage-cluster"
}

resource "google_project_iam_member" "gke_management" {
  project = var.service_account_project #"sherein"
  role    = var.service_account_role    #"roles/container.admin"
  member  = "serviceAccount:${google_service_account.manage_cluster.email}"
}
resource "google_project_iam_member" "artifact-admin" {
  project = var.service_account_project
  role    = "roles/artifactregistry.repoAdmin" # Access to manage artifacts in repositories.
  member  = "serviceAccount:${google_service_account.manage_cluster.email}"
}

resource "google_project_iam_member" "artifact-admin2" {
  project = var.service_account_project
  role    = "roles/artifactregistry.admin" # Access to manage artifacts in repositories.
  member  = "serviceAccount:${google_service_account.manage_cluster.email}"
}



resource "google_project_iam_member" "artifact-reader" {
  project = var.service_account_project
  role    = "roles/artifactregistry.writer" # push images
  member  = "serviceAccount:${google_service_account.manage_cluster.email}"

}

resource "google_project_iam_member" "artifact-writer" {
  project = var.service_account_project
  role    = "roles/artifactregistry.reader" # pull 
  member  = "serviceAccount:${google_service_account.manage_cluster.email}"

}
resource "google_project_iam_member" "artifact-object-viewer" {
  project = var.service_account_project
  role    = "roles/storage.objectAdmin" 
  member  = "serviceAccount:${google_service_account.manage_cluster.email}"

}
resource "google_project_iam_member" "artifact-viewer" {
  project = var.service_account_project
  role    = "roles/iam.serviceAccountTokenCreator" 
  member  = "serviceAccount:${google_service_account.manage_cluster.email}"

}

resource "google_compute_instance" "vm_private" {
  name         = var.vm_name
  machine_type = var.vm_type
  zone         = var.vm_zone
  project      = var.vm_project
  tags         = var.vm_tags
 
  network_interface {
    subnetwork = var.vm_network
  }

  boot_disk {
    initialize_params {
      image = var.vm_image
      type  = "pd-standard"
      size  = 10
    }



  }
    service_account {
    email  = google_service_account.manage_cluster.email
    scopes = ["cloud-platform"]
  }
    metadata_startup_script = <<-EOF
  sudo apt-get install -y kubectl
  sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
  gcloud container clusters get-credentials my-gke-cluster --region=us-central1 --project=sherein
  sudo apt install -y docker.io
  sudo usermod -aG docker $USER
  sudo systemctl start docker
  sudo systemctl enable docker
  
  EOF
}
  #sudo usermod -aG docker ${USER} 

#gcloud builds submit --region=us-west2 --tag us-west2-docker.pkg.dev/project-id/quickstart-docker-repo/quickstart-image:tag1







 #   metadata_startup_script = <<-EOF
  #   #!/bin/bash
  #   sudo apt update
  #   curl https://sdk.cloud.google.com | bash
  #   exec -l $SHELL
  #   gcloud components install kubectl
  #   gcloud container clusters get-credentials my-gke-cluster --region=us-central1 --project=sherein

  # EOF
#    gcloud compute ssh --zone "us-east1-b" "my-vm" --tunnel-through-iap --project "sherein" // to ssh 



