locals {
    environment = {
        prod = {
            aws                                 = "aws"
            environment                         = "prod"
            project_name                        = "project-name"
            region                              = "us-west-1"
            is_s3_tfstate_handler               = true

            // Services
            aws_service_deployer                = true
            aws_service_downloader              = true

            // Users Admins:
            admin_user                          = true

            // Users Dev:
            dev_user                            = false

            // Users QA:
            qa_user                             = false

            // Users TA:
            ta_user                             = false

            // Policies
            policy_admin   = [
                "arn:aws:iam::aws:policy/AdministratorAccess"
            ]
            policy_dev     = [
                "arn:aws:iam::aws:policy/ReadOnlyAccess"
            ]
            policy_qa     = [
                "arn:aws:iam::aws:policy/ReadOnlyAccess"
            ]
            policy_ta     = [
                "arn:aws:iam::aws:policy/ReadOnlyAccess"
            ]
            policy_read_only    = [
                "arn:aws:iam::aws:policy/ReadOnlyAccess"
            ]
        }
        prodcn = {
            aws                                 = "aws-cn"
            environment                         = "prodcn"
            project_name                        = "project-name"
            region                              = "cn-northwest-1"
            is_s3_tfstate_handler               = false

            // Services
            aws_service_deployer                = true
            aws_service_downloader              = true

            // Users Admins:
            admin_user                          = true

            // Users Dev:
            dev_user                            = false

            // Users QA:
            qa_user                             = false

            // Users TA:
            ta_user                             = false

            // Policies
            policy_admin   = [
                "arn:aws-cn:iam::aws:policy/AdministratorAccess"
            ]
            policy_dev     = [
                "arn:aws-cn:iam::aws:policy/ReadOnlyAccess"
            ]
            policy_qa     = [
                "arn:aws-cn:iam::aws:policy/ReadOnlyAccess"
            ]
            policy_ta     = [
                "arn:aws-cn:iam::aws:policy/ReadOnlyAccess"
            ]
            policy_read_only    = [
                "arn:aws-cn:iam::aws:policy/ReadOnlyAccess"
            ]
        }
        stage = {
            aws                                 = "aws"
            environment                         = "stage"
            project_name                        = "project-name"
            region                              = "us-west-1"
            is_s3_tfstate_handler               = false

            // Services
            aws_service_deployer                = true
            aws_service_downloader              = true

            // Users Admins:
            admin_user                          = true

            // Users Dev:
            dev_user                            = false

            // Users QA:
            qa_user                             = true

            // Users TA:
            ta_user                             = false

            // Policies
            policy_admin   = [
                "arn:aws:iam::aws:policy/AdministratorAccess"
            ]
            policy_dev     = [
                "arn:aws:iam::aws:policy/ReadOnlyAccess"
            ]
            policy_qa     = [
                "arn:aws:iam::aws:policy/ReadOnlyAccess"
            ]
            policy_ta     = [
                "arn:aws:iam::aws:policy/ReadOnlyAccess"
            ]
            policy_read_only    = [
                "arn:aws:iam::aws:policy/ReadOnlyAccess"
            ]
        }
        stagecn = {
            aws                                 = "aws-cn"
            environment                         = "stagecn"
            project_name                        = "project-name"
            region                              = "cn-northwest-1"
            is_s3_tfstate_handler               = false

            // Services
            aws_service_deployer                = true
            aws_service_downloader              = true

            // Users Admins:
            admin_user                          = true

            // Users Dev:
            dev_user                            = false

            // Users QA:
            qa_user                             = true

            // Users TA:
            ta_user                             = false

            // Policies
            policy_admin   = [
                "arn:aws-cn:iam::aws:policy/AdministratorAccess"
            ]
            policy_dev     = [
                "arn:aws-cn:iam::aws:policy/ReadOnlyAccess"
            ]
            policy_qa     = [
                "arn:aws-cn:iam::aws:policy/ReadOnlyAccess"
            ]
            policy_ta     = [
                "arn:aws-cn:iam::aws:policy/ReadOnlyAccess"
            ]
            policy_read_only    = [
                "arn:aws-cn:iam::aws:policy/ReadOnlyAccess"
            ]
        }
        dev = {
            aws                                 = "aws"
            environment                         = "dev"
            project_name                        = "project-name"
            region                              = "us-west-1"
            is_s3_tfstate_handler               = false

            // Services
            aws_service_deployer                = true
            aws_service_downloader              = true

            // Users Admins:
            admin_user                          = true

            // Users Dev:
            dev_user                            = true

            // Users QA:
            qa_user                             = true

            // Users TA:
            ta_user                             = true

            // Policies
            policy_admin   = [
                "arn:aws:iam::aws:policy/AdministratorAccess"
            ]
            policy_dev     = [
                "arn:aws:iam::aws:policy/PowerUserAccess"
            ]
            policy_qa     = [
                "arn:aws:iam::aws:policy/ReadOnlyAccess"
            ]
            policy_ta     = [
                "arn:aws:iam::aws:policy/PowerUserAccess"
            ]
            policy_read_only    = [
                "arn:aws:iam::aws:policy/ReadOnlyAccess"
            ]
        }
        devcn = {
            aws                                 = "aws-cn"
            environment                         = "devcn"
            project_name                        = "project-name"
            region                              = "cn-northwest-1"
            is_s3_tfstate_handler               = false

            // Services
            aws_service_deployer                = true
            aws_service_downloader              = true

            // Users Admins:
            admin_user                          = true

            // Users Dev:
            dev_user                            = true

            // Users QA:
            qa_user                             = true

            // Users TA:
            ta_user                             = true

            // Policies
            policy_admin   = [
                "arn:aws-cn:iam::aws:policy/AdministratorAccess"
            ]
            policy_dev     = [
                "arn:aws-cn:iam::aws:policy/PowerUserAccess"
            ]
            policy_qa     = [
                "arn:aws-cn:iam::aws:policy/ReadOnlyAccess"
            ]
            policy_ta     = [
                "arn:aws-cn:iam::aws:policy/PowerUserAccess"
            ]
            policy_read_only    = [
                "arn:aws-cn:iam::aws:policy/ReadOnlyAccess"
            ]
        }
    }
    workspace = merge(local.environment[terraform.workspace])
}
