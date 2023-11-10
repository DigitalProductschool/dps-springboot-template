terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.5.0"
    }
  }

  required_version = ">= 1.1.0"
}

resource "google_dns_record_set" "c_record" {
  for_each = toset( var.subdomains ) 
  name         = "${each.key}.${var.dns_name}"
  managed_zone = var.zone_name
  type         = "CNAME"
  ttl          = 300

  rrdatas = ["${var.ip}"]

}