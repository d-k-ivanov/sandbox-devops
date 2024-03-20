
Write-Host "------------------------- AWS Deployment Service Account -------------------------"
Write-Host "Prod:"
terraform workspace select prod
terraform output -json |jq [.aws_service_deployer.value] | ConvertFrom-Json

Write-Host "Prod China:"
terraform workspace select prodcn
terraform output -json |jq [.aws_service_deployer.value] | ConvertFrom-Json

Write-Host "Stage:"
terraform workspace select stage
terraform output -json |jq [.aws_service_deployer.value] | ConvertFrom-Json

Write-Host "Stage China:"
terraform workspace select stagecn
terraform output -json |jq [.aws_service_deployer.value] | ConvertFrom-Json

Write-Host "Dev:"
terraform workspace select dev
terraform output -json |jq [.aws_service_deployer.value] | ConvertFrom-Json

Write-Host "Dev China:"
terraform workspace select devcn
terraform output -json |jq [.aws_service_deployer.value] | ConvertFrom-Json

Write-Host "------------------------- AWS Downoader Service Account  -------------------------"
Write-Host "Prod:"
terraform workspace select prod
terraform output -json |jq [.aws_service_downloader.value] | ConvertFrom-Json

Write-Host "Prod China:"
terraform workspace select prodcn
terraform output -json |jq [.aws_service_downloader.value] | ConvertFrom-Json

Write-Host "Stage:"
terraform workspace select stage
terraform output -json |jq [.aws_service_downloader.value] | ConvertFrom-Json

Write-Host "Stage China:"
terraform workspace select stagecn
terraform output -json |jq [.aws_service_downloader.value] | ConvertFrom-Json

Write-Host "Dev:"
terraform workspace select dev
terraform output -json |jq [.aws_service_downloader.value] | ConvertFrom-Json

Write-Host "Dev China:"
terraform workspace select devcn
terraform output -json |jq [.aws_service_downloader.value] | ConvertFrom-Json
