#!/usr/bin/env bash

echo "------------------------- AWS Deployment Service Account -------------------------"
echo "Prod:"
terraform workspace select prod
terraform output -json |jq -r [.aws_service_deployer.value][0]

echo "Prod China:"
terraform workspace select prodcn
terraform output -json |jq -r [.aws_service_deployer.value][0]

echo "Stage:"
terraform workspace select stage
terraform output -json |jq -r [.aws_service_deployer.value][0]

echo "Stage China:"
terraform workspace select stagecn
terraform output -json |jq -r [.aws_service_deployer.value][0]

echo "Dev:"
terraform workspace select dev
terraform output -json |jq -r [.aws_service_deployer.value][0]

echo "Dev China:"
terraform workspace select devcn
terraform output -json |jq -r [.aws_service_deployer.value][0]

echo "------------------------- AWS Downoader Service Account  -------------------------"
echo "Prod:"
terraform workspace select prod
terraform output -json |jq -r [.aws_service_downloader.value][0]

echo "Prod China:"
terraform workspace select prodcn
terraform output -json |jq -r [.aws_service_downloader.value][0]

echo "Stage:"
terraform workspace select stage
terraform output -json |jq -r [.aws_service_downloader.value][0]

echo "Stage China:"
terraform workspace select stagecn
terraform output -json |jq -r [.aws_service_downloader.value][0]

echo "Dev:"
terraform workspace select dev
terraform output -json |jq -r [.aws_service_downloader.value][0]

echo "Dev China:"
terraform workspace select devcn
terraform output -json |jq -r [.aws_service_downloader.value][0]
