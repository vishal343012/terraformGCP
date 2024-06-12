provider "google-beta" {
  access_token = var.access_token
  project      = var.project
  region       = var.region
  zone         = var.zone
}
provider "google" {
  access_token = var.access_token
  project      = var.project
  region       = var.region
  zone         = var.zone
}

# Defining google/kubernetest providers

terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "5.30.0"
    }
  }
}

resource "google_compute_instance" "jenkins-20240613-130624" {
  project = var.project
  # region      = var.region
  zone = var.zone

  boot_disk {
    auto_delete = true
    device_name = "jenkins-20240613-130624"

    initialize_params {
      image = "projects/cos-cloud/global/images/cos-stable-113-18244-85-14"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    container-vm = "cos-stable-113-18244-85-14"
    goog-ec-src  = "vm_add-tf"
  }

  machine_type = "n2-standard-2"

  metadata = {
    gce-container-declaration = "spec:\n  containers:\n  - name:jenkins-20240613-130624\n    image:asia-south1-docker.pkg.dev/jenkins-beanstalkapp/jenkins2024/jenkinsv1.0:latest    securityContext:\n      privileged: true\n    stdin: false\n    tty: false\n  restartPolicy: Always\n# This container declaration format is not public API and may change without notice. Please\n# use gcloud command-line tool or Google Cloud Console to run Containers on Google Compute Engine."
    google-logging-enabled    = "true"

  }

  metadata_startup_script = "iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080"


  name = "jenkins-20240601-170445"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = "projects/jenkins-beanstalkapp/regions/asia-south1/subnetworks/default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = "vs-167@jenkins-beanstalkapp.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  tags = ["http-server", "https-server"]
}