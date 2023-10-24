
module "vpc" {
  source                 = "./vpc"
  vpc_project            = "sherein"
  vpc_name               = "vpc-network"
  vpc_auto_create_subnet = false
  vpc_mtu                = 1460
}


#----------------MODULES ----------------

module "firewalls" {
  source                 = "./firewall"
  firewall_name          = "allow-ssh"
  firewall_network       = module.vpc.vpc_name
  firewall_priority      = 1000
  firewall_direction     = "INGRESS"
  firewall_project       = module.vpc.vpc_project
  firewall_source_ranges = ["35.235.240.0/20"]
  firewall_protocol      = "tcp"
  firewall_ports         = ["22"]
  firewall_tags          = ["private"]
}

module "management_subnet" {
  source         = "./subnet"
  subnet_name    = "management-subnet"
  subnet_cider   = "10.0.1.0/24"
  subnet_region  = "us-east1"
  subnet_network = module.vpc.vpc_id
  depends_on = [
    module.vpc
  ]
}

module "second_subnet" {
  source         = "./subnet"
  subnet_name    = "second-subnet"
  subnet_cider   = "192.168.1.0/24"
  subnet_region  = "us-central1"
  subnet_network = module.vpc.vpc_id
  depends_on = [
    module.vpc
  ]
}
module "nat" {
  source         = "./nat"
  router_name    = "my-router"
  router_region  = module.management_subnet.subnet_region
  router_network = module.vpc.vpc_name

  nat_router_name            = "gateway-router"
  nat_router_subnetwork_name = module.management_subnet.subnet_name
}

#--------------------------- 
module "private_vm" {
  source                  = "./vm"
  service_account_id      = "management-cluster"  
  service_account_project = module.vpc.vpc_project
  service_account_role    = "roles/container.admin"
  vm_name                 = "my-vm-shereen"
  vm_type                 = "e2-micro"
  vm_zone                 = "us-east1-b"
  vm_project              = "sherein"
  vm_tags                 = ["private"]
  vm_network              = "management-subnet"
  vm_image                = "debian-cloud/debian-11" #  or  "ubuntu-os-cloud/ubuntu-2204-lts" 
  depends_on              = [
    module.management_subnet
  ]
}

module "kubernetes_cluster" {
  source                    = "./GKE"
  k8s_service_project       = module.vpc.vpc_project
  k8s_cluster_name          = "my-gke-cluster"
  k8s_cluster_location      = "us-central1"
  k8s_cluster_network       = module.vpc.vpc_name
  k8s_cluster_subnetwork    = module.second_subnet.subnet_name
  k8s_cluster_count         = 1
  k8s_cluster_master_cider  = "172.16.0.0/28"
  k8s_cluster_node_name     = "my-node-pool"
  depends_on = [
    module.second_subnet
  ]
}
