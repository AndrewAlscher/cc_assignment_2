How to start minikube:
minikube start --profile kafkaminikube --cpus 6 --memory 14980 --driver docker --no-vtx-check
minikube dashboard --profile=kafkaminikube --url true

How to get contexts:
kubectl config get-contexts

How to remove contexts:
kubectl config unset contexts.minikube

How to deploy this service:

kubectl apply -f 00-leaf-image-management-system.yaml
