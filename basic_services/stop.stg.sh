# !/bin/bash

# Stop apis
echo "Stopping the apis"

echo "Stopping the image api"
kubectl delete deployment image-api -n leaf-image-management-system
kubectl delete service image-api -n leaf-image-management-system

echo "Stopping the image analyzer api"
kubectl delete deployment image-analyzer-api -n leaf-image-management-system
kubectl delete service image-analyzer-api -n leaf-image-management-system

# Stop jobs
echo "Stopping the jobs"

echo "Stopping the camera job"
kubectl delete deployment camera -n leaf-image-management-system
kubectl delete service camera -n leaf-image-management-system

echo "Stopping the users job"
kubectl delete deployment users -n leaf-image-management-system
kubectl delete service users -n leaf-image-management-system

echo "Stopping the leaf disease recognizer job"
kubectl delete deployment leaf-disease-recognizer -n leaf-image-management-system
kubectl delete service leaf-disease-recognizer -n leaf-image-management-system

echo "Stopping the db synchronizer job"
kubectl delete deployment db-synchronizer -n leaf-image-management-system
kubectl delete service db-synchronizer -n leaf-image-management-system

# Stop databases
echo "Stopping the databases"

echo "Stopping the mongodb producer"
kubectl delete deployment mongodb-producer -n leaf-image-management-system
kubectl delete service mongodb-producer -n leaf-image-management-system

echo "Stopping the mongodb consumer"
kubectl delete deployment mongodb-consumer -n leaf-image-management-system
kubectl delete service mongodb-consumer -n leaf-image-management-system

# Stop kafka
echo "Stopping the kafka cluster"
kubectl delete service kafka-service -n leaf-image-management-system
kubectl delete deployment kafka-broker -n leaf-image-management-system
kubectl delete service zookeeper -n leaf-image-management-system
kubectl delete deployment zookeeper -n leaf-image-management-system

# Delete the namespace
echo "Delete the namespace"
kubectl delete namespace leaf-image-management-system
