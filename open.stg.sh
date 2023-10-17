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
nohup kubectl port-forward svc/camera 5050:5050 -n leaf-image-management-system > /dev/null 2>&1 &
nohup kubectl port-forward svc/leaf-image-disease-recognizer 5051:5050 -n leaf-image-management-system > /dev/null 2>&1 &
nohup kubectl port-forward svc/users 5052:5050 -n leaf-image-management-system > /dev/null 2>&1 &
nohup kubectl port-forward svc/camara 5053:5050 -n leaf-image-management-system > /dev/null 2>&1 &