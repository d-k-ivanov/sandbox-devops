# Terraform configuration

## AWS Profile

You need to creat AWS profile with your AWS credentials in the `~\aws\credentials` file

```sh
[aws-profile-name]
region = eu-west-1
aws_account_id = XXXXXXXXXXXXX
aws_access_key_id = AKIXXXXXXXXXXXXXXXXX
aws_secret_access_key = LSXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

## Prerequisites

* aws-iam-authenticator
* awscli
* kubernetes-cli
* terraform
* wget

## Usage

```bash
# Initalize clonned repo
terraform init

# Look at changes
terrafrom plan
terrafrom plan -out terraform.plan

# Apply changes
terraform apply
terraform apply "terraform.plan"
```

## Shorcats

```sh
bin/init            # init configuration
bin/plan            # plan configurarion
bin/apply           # apply configurarion
bin/destroy         # destroy configurarion
bin/destroy_module  # destroy single module
bin/gpg             # encrypt/decrypt secrets
```
