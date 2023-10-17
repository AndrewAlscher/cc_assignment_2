# CC Assignment 2

# Services

## APIs

### Image API

located: basic_services/api/image_api

### Image Analyzer API

located: basic_services/api/image_analizer_api

## Jobs

### Camera

### Leaf Disease Recognizer

### Users

### Db Synchronizer

## Databases

### Consumer Db

### Producer DB

# Deployment Instructions

Locally:

1. Install minikube
2. Start minikube
3. Run the following script: basic_services/start.stg.sh
4. Wait 2-3 minutes until all pods are running and the all the data has been loaded into the databases
5. You can expose the ports of all services using the foolowing script: basic_services/open.stg.sh

Each service has been deployed with ClusterIP type:

- image_api: 30001
- image_analizer_api: 30002
- camera: 30003
- leaf_disease_recognizer: 30004
- users: 30005
- db_synchronizer: 30006
- consumer_db: 30007
- producer_db: 30008

Cloud:

#

# Delete Instructions

Locally:

1. Run the following script: basic_services/stop.stg.sh

Describe stg/prod

Describe how to stop

Describe what to do
