variable "project_id" {
  type        = string
  description = "The Google Cloud Project Id"
  default     = "dps-infrastructure"
}

variable "region" {
  type        = string
  description = "The Google Cloud Project Region"
  default     = "europe-west2"
}

variable "dns_name" {
  type        = string
  description = "The Google Cloud DNS Zone Name"
  default     = "dpschool.app."
}

variable "zone_name" {
  type        = string
  description = "The Google Cloud DNS Zone Name"
  default     = "dpschool-app"
}


variable "subdomain" {
  type        = string
  description = "The DNS subdomain"
}

variable "ip" {
  type        = string
  description = "The Ingress IP"
}

variable "provider" {
    type = string
    description = "The cloud provider where the ingress is deployed"
  
}

variable "gcp_credentials" {
  type = string
  sensitive = true
  description = "Google Cloud service account credentials"
}