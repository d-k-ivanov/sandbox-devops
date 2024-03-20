terraform {
    backend "s3" {
        bucket          = "XXXXXXXXXXXXXXXX-tf-states"
        key             = "XXXXXXXXXXXXXXXX-global.tfstate"
        region          = "eu-central-1"
        encrypt         = "true"
    }
}

module "ssh-keys-eu-central-1" {
    source              = "../modules/ssh_keys"
    region              = "eu-central-1"
}

module "XXX_project_dns_zone" {
    source              = "../modules/dns_project"
    region              = "eu-central-1"
    project_name        = "XXXXXXXXXXXXXXXX"
    parent_dns_zone_id  = "XXXXXXXXXXXXXXXX"
    parent_dns_suffix   = "XXXXXXXXXXXXXXXX"
}
