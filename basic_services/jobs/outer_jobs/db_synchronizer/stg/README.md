How to deploy this service:

kubectl apply -f 00-db-synchronizer-deployment.stg.yaml
kubectl apply -f 01-db-synchronizer-service.stg.yaml

kubectl logs db-synchronizer-7c6bb59cbc-z2htt -n leaf-image-management-system

How to run deompyment without ingress:
kubectl port-forward deployment/db-synchronizer 5050:5050 -n leaf-image-management-system
kubectl port-forward svc/db-synchronizer 5050:5050 -n leaf-image-management-system
kubectl port-forward svc/db-synchronizer 5050:5050 8050:8050 -n leaf-image-management-system (with prometheus port - 8050)
