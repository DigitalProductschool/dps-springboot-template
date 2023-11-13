module "aws-dns" {
    count = var.ingress_provider == "aws-official" ? 1 : 0
    source     = "./modules/aws-official"
    dns_name   = var.dns_name
    zone_name  = var.zone_name
    subdomains = ["${var.subdomain_prod}", "${var.subdomain_dev}"]
    ip         = var.ip
}

module "others-dns" {
    count = var.ingress_provider == "aws-official" ? 0 : 1
    source     = "./modules/others"
    dns_name   = var.dns_name
    zone_name  = var.zone_name
    subdomains = ["${var.subdomain_prod}", "${var.subdomain_dev}"]
    ip         = var.ip 
}