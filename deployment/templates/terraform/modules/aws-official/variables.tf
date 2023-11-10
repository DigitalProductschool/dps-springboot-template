
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


variable "subdomains" {
  type        = list
  description = "The DNS subdomain"
}

variable "ip" {
  type        = string
  description = "The Ingress IP"
}
