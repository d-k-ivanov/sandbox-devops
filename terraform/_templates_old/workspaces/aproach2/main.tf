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
    environment         = "${local.workspace["environment"]}"
    project             = "${local.workspace["project"]}"
    ssh_key_pair        = "${local.workspace["ssh_key_pair"]}"
}
