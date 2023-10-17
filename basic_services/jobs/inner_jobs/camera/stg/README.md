How to deploy this service:

kubectl apply -f 00-camera-deployment.stg.yaml
kubectl apply -f 01-camera-service.stg.yaml

kubectl logs camera-7c6bb59cbc-z2htt -n leaf-image-management-system

How to run deompyment without ingress:
kubectl port-forward deployment/camera 5050:5050 -n leaf-image-management-system
kubectl port-forward svc/camera 5050:5050 -n leaf-image-management-system
