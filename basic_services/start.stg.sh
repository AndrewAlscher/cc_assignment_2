# !/bin/bash

# Deploy main namespace
echo "Deploying the basic namespace"
cd common

kubectl apply -f 00-leaf-image-management-system.yaml

cd ../


# Deploy the kafka cluster
echo "Deploying the kafka cluster"
cd kafka/dev

kubectl apply -f 00-zookeeper-deployment.dev.yaml
kubectl apply -f 01-zookeeper-service.dev.yaml
kubectl apply -f 02-kafka-deployment.dev.yaml
kubectl apply -f 03-kafka-service.dev.yaml

cd ../../


# Deploy the databases
echo "Deploying the databases"
cd mongodb


echo "Deploying the consumer database"
cd consumer_db/plant_db/dev

kubectl apply -f 00-mongodb-consumer-deployment.dev.yaml
kubectl apply -f 01-mongodb-consumer-service.dev.yaml

cd ../../../


echo "Deploying the producer database"
cd producer_db/plant_db/dev

kubectl apply -f 00-mongodb-producer-deployment.dev.yaml
kubectl apply -f 01-mongodb-producer-service.dev.yaml

cd ../../../../


# Deploy the apis
echo "Deploying the apis"
cd api

echo "Deploying the image api"
cd image_api/stg

kubectl apply -f 00-image-api-deployment.stg.yaml
kubectl apply -f 01-image-api-service.stg.yaml


cd ../../


echo "Deploying the image analyzer api"
cd image_analyzer_api/stg

kubectl apply -f 00-image-analyzer-api-deployment.stg.yaml
kubectl apply -f 01-image-analyzer-api-service.stg.yaml

cd ../../../

# Deploy the jobs
echo "Starting the jobs"

echo "Starting the camera job"
cd jobs/inner_jobs/camera/stg

kubectl apply -f 00-camera-deployment.stg.yaml
kubectl apply -f 01-camera-service.stg.yaml

cd ../../../../

echo "Starting the users job"
cd jobs/inner_jobs/users/stg

kubectl apply -f 00-users-deployment.stg.yaml
kubectl apply -f 01-users-service.stg.yaml

cd ../../../../

echo "Starting the leaf disease recognizer job"
cd jobs/inner_jobs/leaf-disease-recognizer/stg

kubectl apply -f 00-leaf-disease-recognizer-deployment.stg.yaml
kubectl apply -f 01-leaf-disease-recognizer-service.stg.yaml

cd ../../../../

echo "Starting the db synchronizer job"
cd jobs/outer_jobs/db_synchronizer/stg

kubectl apply -f 00-db-synchronizer-deployment.stg.yaml
kubectl apply -f 01-db-synchronizer-service.stg.yaml

cd ../../../../


# Start the services
# !/bin/bash
echo "Starting the kafka cluster"
nohup kubectl port-forward svc/kafka-service 9093:9093 -n leaf-image-management-system > /dev/null 2>&1 &

echo "Starting the services"
echo "Starting the apis"
nohup kubectl port-forward svc/image-api 8080:8080 -n leaf-image-management-system > /dev/null 2>&1 &
nohup kubectl port-forward svc/image-analyzer-api 8080:8081 -n leaf-image-management-system > /dev/null 2>&1 &

echo "Starting the databases"
nohup kubectl port-forward svc/mongodb-producer 27017:27017 -n leaf-image-management-system > /dev/null 2>&1 &
nohup kubectl port-forward svc/mongodb-consumer 27018:27017 -n leaf-image-management-system > /dev/null 2>&1 &

echo "Starting the jobs"



