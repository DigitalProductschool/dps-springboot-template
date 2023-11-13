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


variable "subdomain_prod" {
  type        = string
  description = "The DNS subdomain for prod environment"
}

variable "subdomain_dev" {
  type        = string
  description = "The DNS subdomain for dev environment"
}

variable "ip" {
  type        = string
  description = "The Ingress IP"
}

variable "ingress_provider" {
    type = string
    description = "The cloud provider where the ingress is deployed"
  
}