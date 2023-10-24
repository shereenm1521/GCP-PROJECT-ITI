# resource "google_compute_instance" "private_vm" {
#   name         = "private-vm"
#   machine_type = "e2-medium"  # desired machine type
#   zone         = "us-east1-a" # zone in the subnet's region

#   boot_disk {
#     initialize_params {
#       image = "ubuntu-os-cloud/ubuntu-2204-lts" # desired OS image
#     }
#   }

#   service_account {
#     email  = google_service_account.service_account.email
#     scopes = ["cloud-platform"]
#   }

#   network_interface {
#     subnetwork = module.management_subnet.id
  
#   }

#   # configuration for the VM if needed
# }









# # resource "google_service_account" "vm_service_account" {
# #   account_id   = "vm-service-account"
# #   display_name = "VM Service Account"
# # }

# # resource "google_project_iam_binding" "vm_service_account_binding" {
# #   project = "idyllic-depth-401020"
# #   role    = "roles/compute.instanceAdmin"  # necessary roles for your VM

# #   members = [
# #     "serviceAccount:${google_service_account.vm_service_account.email}"
# #   ]
# # }




# # resource "google_compute_firewall" "iap_firewall" {
# #   name    = "iap-firewall"
# #   network = module.vpc.vpc_name

# #   allow {
# #     protocol = "tcp"
# #     ports    = ["22"]  #  the desired ports for SSH access
# #   }

# #   #  rules or configuration for the firewall if needed
# # }

# # roles = [
# #     "roles/compute.instanceAdmin",
# #     "roles/iam.securityReviewer",
# #     "roles/storage.objectViewer",
# #     "roles/logging.viewer",
# #   ]