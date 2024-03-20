# Environment folder Terraform sample configuraion

## Services

* Autoscalling group
* DNS zone
* ECS cluster
* ECS serices
* Load Balancer

## Information

### Environments

* Global
* Staging
* Production

## Usage

```bash
# cd to environment forlder
cd <environment_folder>

# Initalize clonned repo
terraform init

# Look at changes
terrafrom plan -out terraform.plan

# Apply changes
terraform apply "terraform.plan"
```
