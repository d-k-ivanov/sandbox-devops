terraform {
    required_version    = ">= 0.13.1"

    required_providers {
        aws             = ">= 3.43.0"
        http = {
            source      = "terraform-aws-modules/http"
            version     =   ">= 2.4.1"
        }
    }
}
