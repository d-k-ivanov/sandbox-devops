# Wokrspace-basesTerrinitial configuration aform configuration for XXX services

## Services

* Autoscalling group
* DNS zone
* ECS cluster
* ECS Services
* Load Balancer

## Information

### Environments

* prod
* stage

> Other environments restricted

## Usage

```bash
# Create workspace
terraform workspace create <prod|stage>

# List workspace
terraform workspace list

# Select workspace
terraform workspace select <prod|stage>

# Initalize clonned repo
terraform init

# Look at changes
terrafrom plan -out terraform.plan

# Apply changes
terraform apply "terraform.plan"

# Destroy all
terraform destroy -out terraform.plan

# Destroy partial
terraform plan -destroy -target <resource1> -target <resource2> -target <resourceN> -out terraform.plan
terraform apply "terraform.plan"
```
