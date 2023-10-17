How to start minikube:
minikube start --profile kafkaminikube --cpus 6 --memory 14980 --driver docker --no-vtx-check
minikube dashboard --profile=kafkaminikube --url true

How to get contexts:
kubectl config get-contexts

How to remove contexts:
kubectl config unset contexts.minikube

Check minikube:
minikube status

How to deploy this service:
kubectl apply -f 00-image-api-deployment.stg.yaml
kubectl apply -f 01-image-api-service.stg.yaml

How to check:
kubectl get all -n leaf-image-management-system

kubectl get deployment -n leaf-image-management-system

kubectl get pods -n leaf-image-management-system

kubectl describe pods image-api-57949b7945-qk8v6 -n leaf-image-management-system
kubectl logs image-api-7c6bb59cbc-z2htt -n leaf-image-management-system

How to delete:
kubectl delete deployment image-api -n leaf-image-management-system
kubectl delete service image-api -n leaf-image-management-system
kubectl delete ingress image-api -n leaf-image-management-system

How to run deompyment without ingress:
kubectl port-forward deployment/image-api 8080:8080 -n leaf-image-management-system
kubectl port-forward svc/image-api 8080:8080 -n leaf-image-management-system
kubectl port-forward svc/image-api 8080:8080 8050:8050 -n leaf-image-management-system
minikube service image-api -n leaf-image-management-system

kubectl logs image-api-7c6bb59cbc-z2htt

Check:
curl 127.0.0.1:8080/ping

How to run this servise as a background process:
1

# Move the job to the background

kubectl port-forward svc/image-api 8080:8080 -n leaf-image-management-system &

# List background jobs

jobs

# Bring the job to the foreground if needed

fg %1 # assuming it is job 1

# Move a foreground job to the background

bg

# Kill a background job

kill %1 # replace 1 with your actual job number

2
nohup kubectl port-forward svc/image-api 8080:8080 -n leaf-image-management-system > /dev/null 2>&1 &
