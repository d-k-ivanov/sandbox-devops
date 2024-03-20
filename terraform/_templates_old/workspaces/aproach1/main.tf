terraform {
    backend "s3" {
        bucket          = "project-tf-states"
        key             = "project.tfstate"
        region          = "us-west-2"
        encrypt         = "true"
    }
}

module "deploy-to-us-west-2" {
    source              = "modules/deploy-to-us-west-2"
    environment         = "${var.environment}"
    project             = "${var.project}"
    ssh_key_pair        = "${var.ssh_key_pair}"
}
