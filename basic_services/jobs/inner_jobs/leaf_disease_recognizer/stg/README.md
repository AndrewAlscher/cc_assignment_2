How to deploy this service:

kubectl apply -f 00-leaf-disease-recognizer-deployment.stg.yaml
kubectl apply -f 01-leaf-disease-recognizer-service.stg.yaml

How to run deompyment without ingress:
kubectl port-forward deployment/leaf-disease-recognizer 5050:5050 -n leaf-image-management-system
kubectl port-forward svc/leaf-disease-recognizer 5050:5050 -n leaf-image-management-system
