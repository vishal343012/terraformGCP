variable "project" {
  type    = string
  default = "jenkins-beanstalkapp"
}

variable "zone" {
  type    = string
  default = "asia-south1-a"
}

variable "region" {
  type    = string
  default = "asia-south1-a"
}
variable "registry" {
  type    = string
  default = "jenkins2024"

}
variable "username" {
  type    = string
  default = "admin"
}

variable "password" {
  type    = string
  default = "Password123#"
}

variable "image" {
  type    = string
  default = "asia-south1-docker.pkg.dev/jenkins-beanstalkapp/jenkins2024/jenkinsv1.0:latest"
}

variable "jenkins_instance_network" {
  type    = string
  default = "default"
}

variable "jenkins_instance_subnetwork" {
  type    = string
  default = "default"
}


variable "service_account" {
  description = "The project ID of the Jenkins network"
  default     = "vs-167@jenkins-beanstalkapp.iam.gserviceaccount.com"
}

variable "jenkins_instance_access_cidrs" {
  type        = list(string)
  description = "CIDRs to allow to access Jenkins over HTTP(s)"
  default     = ["0.0.0.0/0"]
}

variable "jenkins_instance_zone" {
  type    = string
  default = "asia-south1-a"
}

variable "access_token" {
  type = string
}



