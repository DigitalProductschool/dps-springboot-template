resource "google_dns_record_set" "a" {
  count = var.ingress_provider == "aws-official" ? 0 : 1
  name         = "${var.subdomain}.${var.dns_name}"
  managed_zone = var.zone_name
  type         = "A"
  ttl          = 300

  rrdatas = ["${var.ip}"]
}


resource "google_dns_record_set" "a-dev" {
  count = var.ingress_provider == "aws-official" ? 0 : 1
  name         = "dev.${var.subdomain}.${var.dns_name}"
  managed_zone = var.zone_name
  type         = "A"
  ttl          = 300

  rrdatas = ["${var.ip}"]
}

resource "google_dns_record_set" "c" {
  count = var.ingress_provider == "aws-official" ? 1 : 0
  name         = "${var.subdomain}.${var.dns_name}"
  managed_zone = var.zone_name
  type         = "CNAME"
  ttl          = 300

  rrdatas = ["${var.ip}"]
}


resource "google_dns_record_set" "c-dev" {
  count = var.ingress_provider == "aws-official" ? 1 : 0
  name         = "dev.${var.subdomain}.${var.dns_name}"
  managed_zone = var.zone_name
  type         = "CNAME"
  ttl          = 300

  rrdatas = ["${var.ip}"]
}