kprodcn apply -f sample-deployment.yaml
kprodcn apply -f sample-service.yaml

kprodcn get svc sample-service

curl k8s-default-samplese-xxxxxxxxxx-xxxxxxxxxxxxxxxx.elb.us-west-2.amazonaws.com

kprodcn delete service sample-service
kprodcn delete deployment sample-app
