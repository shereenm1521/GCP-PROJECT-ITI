resource "google_compute_router" "router" {
  name    = var.router_name    
  region  = var.router_region  #"us-east1"
  network = var.router_network #"vpc-network"
}

resource "google_compute_router_nat" "nat_router" {
  name                               = var.nat_router_name #"nat-router"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = var.nat_router_subnetwork_name #"management-subnet"
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

resource "google_compute_address" "nat_ip" {
  name   = "nat-ip"
  region = "us-east1"  # the region where the NAT IP should be allocated
}