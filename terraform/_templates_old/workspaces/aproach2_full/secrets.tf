locals {
    secrets_vars = {
        prod  = {
            aws_access_key              = ""
            aws_secret_key              = ""
        }
        stage = {
            aws_access_key              = ""
            aws_secret_key              = ""
        }
        dev = {
            aws_access_key              = ""
            aws_secret_key              = ""
        }
    }
    secrets                             = "${merge(local.secrets_vars[terraform.workspace])}"
}
