How to deploy this service:

kubectl apply -f 00-users-deployment.stg.yaml
kubectl apply -f 01-users-service.stg.yaml

kubectl logs users-7c6bb59cbc-z2htt -n leaf-image-management-system

How to run deompyment without ingress:
kubectl port-forward deployment/users 5050:5050 -n leaf-image-management-system
kubectl port-forward svc/users 5050:5050 -n leaf-image-management-system
