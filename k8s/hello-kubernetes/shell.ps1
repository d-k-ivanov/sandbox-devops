kprodcn apply -f hello-k8s-deploy.yaml
kprodcn apply -f hello-k8s-svc.yaml

kprodcn delete service hello-kubernetes
kprodcn delete deployment hello-kubernetes
