#!/bin/bash
# Expose the services
echo "Starting the kafka cluster..."
nohup kubectl port-forward svc/kafka-service 9093:9093 -n leaf-image-management-system > /dev/null 2>&1 &

if [ $? -eq 0 ]; then
    echo "Kafka cluster started successfully."
else
    echo "Failed to start Kafka cluster."
fi

echo "Open the ports the services"
# Start APIs
echo "Starting the APIs' ports..."
nohup kubectl port-forward svc/image-api 8080:8080 8050:8050 -n leaf-image-management-system > /dev/null 2>&1 &
nohup kubectl port-forward svc/image-analyzer-api 8081:8080 -n leaf-image-management-system > /dev/null 2>&1 &

# Start Databases
echo "Starting the databases' ports..."
nohup kubectl port-forward svc/mongodb-producer 27017:27017 -n leaf-image-management-system > /dev/null 2>&1 &
nohup kubectl port-forward svc/mongodb-consumer 27018:27017 -n leaf-image-management-system > /dev/null 2>&1 &

# Start Jobs
echo "Starting the jobs' ports..."
nohup kubectl port-forward svc/camera 5050:5050 -n leaf-image-management-system > /dev/null 2>&1 &
nohup kubectl port-forward svc/leaf-disease-recognizer 5051:5050 -n leaf-image-management-system > /dev/null 2>&1 &
nohup kubectl port-forward svc/users 5052:5050 -n leaf-image-management-system > /dev/null 2>&1 &
nohup kubectl port-forward svc/db-synchronizer 5053:5050 8051:8050 -n leaf-image-management-system > /dev/null 2>&1 &