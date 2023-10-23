#!/bin/bash

apply_kubectl() {
    file=$1
    kubectl apply -f "$file"
    if [ $? -ne 0 ]; then
        echo "Error applying $file."
    fi
}


# Deploy main namespace
echo "Started deploying the leaf image management system"

echo "Creating the namespace"
apply_kubectl basic_services/common/00-leaf-image-management-system-namespace.yaml


# Deploy the kafka cluster
echo "Deploying the kafka cluster"
apply_kubectl basic_services/kafka/stg/00-zookeeper-deployment.stg.yaml
apply_kubectl basic_services/kafka/stg/01-zookeeper-service.stg.yaml
apply_kubectl basic_services/kafka/stg/02-kafka-deployment.stg.yaml
apply_kubectl basic_services/kafka/stg/03-kafka-service.stg.yaml


## Deploy the databases
echo "Deploying the databases"

echo "Deploying the consumer database"
apply_kubectl basic_services/mongodb/consumer_db/plant_db/stg/00-mongodb-consumer-deployment.stg.yaml
apply_kubectl basic_services/mongodb/consumer_db/plant_db/stg/01-mongodb-consumer-service.stg.yaml


echo "Deploying the producer database"
apply_kubectl basic_services/mongodb/producer_db/plant_db/stg/00-mongodb-producer-deployment.stg.yaml
apply_kubectl basic_services/mongodb/producer_db/plant_db/stg/01-mongodb-producer-service.stg.yaml


# Deploy the apis
echo "Deploying the apis"
echo "Deploying the image api"

apply_kubectl basic_services/api/image_api/stg/00-image-api-deployment.stg.yaml
apply_kubectl basic_services/api/image_api/stg/01-image-api-service.stg.yaml
apply_kubectl basic_services/api/image_api/stg/02-image-api-service-monitor.stg.yaml

echo "Deploying the image analyzer api"
apply_kubectl basic_services/api/image_analyzer_api/stg/00-image-analyzer-api-deployment.stg.yaml
apply_kubectl basic_services/api/image_analyzer_api/stg/01-image-analyzer-api-service.stg.yaml


# Deploy the jobs
echo "Starting the jobs"

echo "Starting the camera job"
apply_kubectl basic_services/jobs/inner_jobs/camera/stg/00-camera-deployment.stg.yaml
apply_kubectl basic_services/jobs/inner_jobs/camera/stg/01-camera-service.stg.yaml

echo "Starting the users job"
apply_kubectl basic_services/jobs/inner_jobs/users/stg/00-users-deployment.stg.yaml
apply_kubectl basic_services/jobs/inner_jobs/users/stg/01-users-service.stg.yaml

echo "Starting the leaf disease recognizer job"
apply_kubectl basic_services/jobs/inner_jobs/leaf_disease_recognizer/stg/00-leaf-disease-recognizer-deployment.stg.yaml
apply_kubectl basic_services/jobs/inner_jobs/leaf_disease_recognizer/stg/01-leaf-disease-recognizer-service.stg.yaml

echo "Starting the db synchronizer job"
apply_kubectl basic_services/jobs/outer_jobs/db_synchronizer/stg/00-db-synchronizer-deployment.stg.yaml
apply_kubectl basic_services/jobs/outer_jobs/db_synchronizer/stg/01-db-synchronizer-service.stg.yaml
apply_kubectl basic_services/jobs/outer_jobs/db_synchronizer/stg/02-db-synchronizer-monitor.stg.yaml

echo "Finished deploying the leaf image management system"