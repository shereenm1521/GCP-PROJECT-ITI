resource "google_service_account" "kubernetes" {
  account_id = "kubernetes"
}


resource "google_project_iam_member" "kubernetes_role" {
  project = var.k8s_service_project #sherein"
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.kubernetes.email}"
}
resource "google_project_iam_member" "kubernetes_role2" {
  project = var.k8s_service_project #sherein"
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.kubernetes.email}"
}
resource "google_project_iam_member" "kubernetes_role3" {
  project = var.k8s_service_project #sherein"
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.kubernetes.email}"
}
resource "google_container_cluster" "primary" {
  name       = var.k8s_cluster_name       #"my-gke-cluster"
  location   = var.k8s_cluster_location   #"us-central1"
  network    = var.k8s_cluster_network    #"vpc-network"
  subnetwork = var.k8s_cluster_subnetwork #"second-subnet"
  deletion_protection = false             #to enable delete cluster using terraform 
  remove_default_node_pool = true
  initial_node_count       = var.k8s_cluster_count 

  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = var.k8s_cluster_master_cider #"172.16.0.0/28"
    # first create without this block, then add
    master_global_access_config {  
      enabled = true
    }
  }

  ip_allocation_policy {
    
  }

  master_authorized_networks_config {
    cidr_blocks {
      display_name = "management-subnet"
      cidr_block   = "10.0.1.0/24"
    }
  }

}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.k8s_cluster_node_name
  location   = "us-central1"
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    disk_type    = "pd-standard"
    disk_size_gb = 10

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
           "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

