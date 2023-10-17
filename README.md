# CC Assignment 2

# Services

![The entire system](images/2023.10.09%20-%201.jpg)

For detailed information about the system architecture, please refer to the [overview report](report/cc_assignment_2_overview.pdf).

There is some additional infomration for each service below:

## APIs

### Image API

#### Description

This API performs CRUD operations for images using MongoDB and pushes changes to Kafka topics.

#### Kubernetes Configuration Files:

[basic_services/api/image_api](basic_services/api/image_api)

### Image Analyzer API

#### Description

This API contains ML models that analyze leaf diseases based on different image representations.

#### Kubernetes Configuration Files:

[basic_services/api/image_analizer_api](basic_services/api/image_analizer_api)

## Jobs

### Camera

#### Description

This job automatically generates and uploads new pepper, potato, or tomato photos every 30 seconds.

#### Kubernetes Configuration Files:

[basic_services/jobs/inner_jobs/camera](basic_services/jobs/inner_jobs/camera)

### Leaf Disease Recognizer

#### Description

This job identifies diseases for one image every 100 seconds.

#### Kubernetes Configuration Files:

[basic_services/jobs/inner_jobs/leaf_disease_recognizer](basic_services/jobs/inner_jobs/leaf_disease_recognizer)

### Users

#### Description

This job continuously updates information and can also activate and delete images.

This service comprises three distinct jobs:

- Job to activate or deactivate images, which runs 300 seconds.
- Job to update image metadata, which runs every 300 seconds.
- Job to delete images, which runs every 700 seconds.

#### Kubernetes Configuration Files:

[basic_services/jobs/inner_jobs/users](basic_services/jobs/inner_jobs/users)

### Db Synchronizer

#### Description

This job synchronizes the producer and consumer databases using a batch approach.

#### Kubernetes Configuration Files:

## Databases

### Producer DB

#### Description

This database stores images along with their related information.

#### Kubernetes Configuration Files:

[basic_services/jobs/outer_jobs/db_synchronizer](basic_services/jobs/outer_jobs/db_synchronizer)

### Consumer Db

#### Description

#### Kubernetes Configuration Files:

# Deployment Instructions

## Locally

1. Install minikube
2. Start minikube
3. Run the following script:

<pre>
sh start.stg.sh
</pre>

4. Wait 2-3 minutes until all pods are running and the all the data has been loaded into the databases
5. You can expose the ports of all services using the foolowing script: open.stg.sh

<pre>
sh open.stg.sh
</pre>

Each service has been deployed with ClusterIP type:

- image_api: 30001
- image_api_prometheus: 30009
- image_analizer_api: 30002
- camera: 30003
- leaf_disease_recognizer: 30004
- users: 30005
- db_synchronizer: 30006
- db_synchronizer_prometheus: 30010
- consumer_db: 30007
- producer_db: 30008
- kafka: 9092

## Cloud (GCP)

1. Create a GKE cluster

# Delete Instructions

Locally:

1. Run the following script:

<pre>
sh stop.stg.sh
</pre>

Describe stg/prod

Describe how to stop

Describe what to do
