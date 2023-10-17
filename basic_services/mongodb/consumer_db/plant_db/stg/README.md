How to deploy this service:
kubectl apply -f 00-mongodb-consumer-deployment.dev.yaml
kubectl apply -f 01-mongodb-consumer-service.dev.yaml

How to check:
kubectl get all -n leaf-image-management-system

How to run deployment without ingress:
kubectl port-forward deployment/mongodb-consumer 27018:27018 -n leaf-image-management-system
kubectl port-forward svc/mongodb-consumer 27018:27018 -n leaf-image-management-system
minikube service mongodb-consumer -n leaf-image-management-system

How to delete:
kubectl delete deployment mongodb-consumer -n leaf-image-management-system
kubectl delete service mongodb-consumer -n leaf-image-management-system

How to run this servise as a background process:
1

# Move the job to the background

kubectl port-forward svc/mongodb-consumer 27018:27018 -n leaf-image-management-system &

# List background jobs

jobs

# Bring the job to the foreground if needed

fg %1 # assuming it is job 1

# Move a foreground job to the background

bg

# Kill a background job

kill %1 # replace 1 with your actual job number

2
nohup kubectl port-forward svc/mongodb-consumer 27018:27018 -n leaf-image-management-system > /dev/null 2>&1 &
