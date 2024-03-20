terraform {
    backend "s3" {
        bucket      = "XXXXXXXXXXXXXXXX-tf-states"
        key         = "XXXXXXXXXXXXXXXX-production.tfstate"
        region      = "eu-central-1"
        encrypt     = "true"
    }
}
