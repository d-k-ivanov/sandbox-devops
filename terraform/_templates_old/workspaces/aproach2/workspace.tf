locals {
    environment = {
        prod  = {
            environment     = "prod"
            project         = "project"
            ssh_key_pair    = "ssh-rsa"
        }
        stage = {
            environment     = "stage"
            project         = "project"
            ssh_key_pair    = "ssh-rsa"

        }
    }

    workspace               = "${merge(local.environment[terraform.workspace])}"
}

