locals {
    environment = {
        prod  = {
            environment     = "prod"
            project         = "project"
            ssh_key_pair    = ""
        }
        stage = {
            environment     = "stage"
            project         = "project"
            ssh_key_pair    = ""

        }
    }

    workspace = "${merge(local.env[terraform.workspace])}"
}


variable "environment"      {}
variable "project"          {}
variable "ssh_key_pair"     {}
