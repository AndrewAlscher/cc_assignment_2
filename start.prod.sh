#!/bin/bash

apply_kubectl() {
    file=$1
    kubectl apply -f "$file"
    if [ $? -ne 0 ]; then
        echo "Error applying $file."
    fi
}


try_add_firewall_rule() {
  local rule_name=$1
  local project=$2
  local port=$3

  # Check if the firewall rule exists in the specified project
  if gcloud compute firewall-rules describe "$rule_name" --project="$project" &>/dev/null; then
    echo "Firewall rule $rule_name exists in project $project."
  else
    echo "Firewall rule $rule_name does not exist in project $project."
    echo "Creating firewall rule $rule_name in project $project."
    gcloud compute firewall-rules create "$rule_name" --allow tcp:"$port" --project="$project"
  fi
}


# Deploy main namespace
echo "Started deploying the leaf image management system"

echo "Creating the namespace"
apply_kubectl basic_services/common/00-leaf-image-management-system-namespace.yaml


# Deploy the kafka cluster
echo "Deploying the kafka cluster"
apply_kubectl basic_services/kafka/prod/00-zookeeper-deployment.prod.yaml
apply_kubectl basic_services/kafka/prod/01-zookeeper-service.prod.yaml
apply_kubectl basic_services/kafka/prod/02-kafka-deployment.prod.yaml
apply_kubectl basic_services/kafka/prod/03-kafka-service.prod.yaml


## Deploy the databases
echo "Deploying the databases"

echo "Deploying the producer database"
apply_kubectl basic_services/mongodb/producer_db/plant_db/prod/00-mongodb-producer-deployment.prod.yaml
apply_kubectl basic_services/mongodb/producer_db/plant_db/prod/01-mongodb-producer-service.prod.yaml
try_add_firewall_rule node-mongodb-producer-port leaf-image-management-system 30017

echo "Deploying the consumer database"
apply_kubectl basic_services/mongodb/consumer_db/plant_db/prod/00-mongodb-consumer-deployment.prod.yaml
apply_kubectl basic_services/mongodb/consumer_db/plant_db/prod/01-mongodb-consumer-service.prod.yaml
try_add_firewall_rule node-mongodb-consumer-port leaf-image-management-system 30018


## Deploy the apis
echo "Deploying the apis"

echo "Deploying the image api"
apply_kubectl basic_services/api/image_api/prod/00-image-api-deployment.prod.yaml
apply_kubectl basic_services/api/image_api/prod/01-image-api-service.prod.yaml
apply_kubectl basic_services/api/image_api/prod/02-image-api-backend-config.prod.yaml
apply_kubectl basic_services/api/image_api/prod/03-image-api-ingress.prod.yaml
try_add_firewall_rule node-image-api-port leaf-image-management-system 30080
try_add_firewall_rule node-image-api-metrics-port leaf-image-management-system 30050




# Deploy the jobs
echo "Starting the jobs"

echo "Starting the camera job"
apply_kubectl basic_services/jobs/inner_jobs/camera/prod/00-camera-deployment.prod.yaml
apply_kubectl basic_services/jobs/inner_jobs/camera/prod/01-camera-service.prod.yaml
apply_kubectl basic_services/jobs/inner_jobs/camera/prod/02-camera-ingress.prod.yaml
try_add_firewall_rule node-camera-port leaf-image-management-system 30550

echo "Starting the users job"
apply_kubectl basic_services/jobs/inner_jobs/users/prod/00-users-deployment.prod.yaml
apply_kubectl basic_services/jobs/inner_jobs/users/prod/01-users-service.prod.yaml
apply_kubectl basic_services/jobs/inner_jobs/users/prod/02-users-ingress.prod.yaml
try_add_firewall_rule node-users-port leaf-image-management-system 30551

echo "Starting the db synchronizer job"
apply_kubectl basic_services/jobs/outer_jobs/db_synchronizer/prod/00-db-synchronizer-deployment.prod.yaml
apply_kubectl basic_services/jobs/outer_jobs/db_synchronizer/prod/01-db-synchronizer-service.prod.yaml
apply_kubectl basic_services/jobs/outer_jobs/db_synchronizer/prod/02-db-synchronizer-ingress.prod.yaml
try_add_firewall_rule node-db-synchronizer-port leaf-image-management-system 30552


echo "Finished deploying the leaf image management system"