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

[basic_services/api/image_analyzer_api](basic_services/api/image_analyzer_api)

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

[basic_services/jobs/outer_jobs/db_synchronizer](basic_services/jobs/outer_jobs/db_synchronizer)

## Databases

Databases stores images along with their related information.

### Producer DB

#### Description

This database is a part of Leaf Image Management System and stores images along with their related information, which are produced.

#### Kubernetes Configuration Files:

[basic_services/mongodb/producer_db/plant_db](basic_services/databases/producer_db/plant_db)

### Consumer Db

#### Description

This database stores images along with their related information, which are consumed.

#### Kubernetes Configuration Files:

[basic_services/mongodb/consumer_db/plant_db](basic_services/databases/consumer_db/plant_db)

## Metrics

Metrics allow us to monitor the important aspects of the system, which are related to the performance, availability, and reliability.

### Prometheus

#### Description

This service collects metrics from the system. In our case, we collect metrics from image-api for stream-processing, and db-synchronizer for batch-processing.

## Metrics for image-api:

- image_api_image - number of images according to their plant, id and disease
- image_api_image_size - size of images in bytes with metadata

## Metrics for db-synchronizer:

- db_synchronizer_job_image - number of images according to their plant, id and disease
- db_synchronizer_job_image_size - size of images in bytes with metadata

#### Kubernetes Configuration Files:

Prometheus is deployed using [Helm](https://helm.sh/) chart. Remember that you should [install](https://helm.sh/docs/intro/quickstart/) Helm before deploying Prometheus.

### Grafana

#### Description

This service visualizes metrics from Prometheus.

#### Kubernetes Configuration Files:

[metrics/grafana](metrics/grafana)

# Deployment Instructions

For this project we use .stg files for staging and .prod files for production.

## Locally

1. Install minikube
2. Start minikube
3. Run the following script:

<pre>
sh start.stg.sh
</pre>

All the services will be deployed locally in 'leaf-image-management-system' namespace.

4. Wait 2-3 minutes until all pods are running and the all the data has been loaded into the databases
5. You can expose the ports of all services using the foolowing script: open.stg.sh

<pre>
sh open.stg.sh
</pre>

Each service has been deployed to 127.0.0.1 with ClusterIP type:

- image_api: 8080
- image_api_prometheus: 8050
- image_analizer_api: 8081
- camera: 5050
- leaf_disease_recognizer: 5051
- users: 5052
- db_synchronizer: 5053
- db_synchronizer_prometheus: 8051
- producer_db: 27017
- consumer_db: 27018
- kafka: 9093

6. You can close the ports using the following script:
<pre>
sh close.stg.sh
</pre>

7. After you implemented your consumer you can deploy Prometheus cluster with Grafana, run the following script:

<pre>
sh start-metrics.stg.sh
</pre>

All the services from this script will be deployed locally in 'metrics' namespace.

8. Wait 2-3 minutes until all pods are running and the all the data has been loaded into the databases
9. You can expose the ports of all services using the foolowing script: open-metrics.stg.sh

<pre>
sh open-metrics.stg.sh
</pre>

Each service has been deployed to 127.0.0.1 with ClusterIP type:

- prometheus: 9090
- grafana: 3000

10. You can close the ports using the following script:

<pre>
sh close-metrics.stg.sh
</pre>

11. In grafana you can see the dashboard showing the batch and stream processing metrics.

## Cloud (GCP)

1. Create a GKE cluster

# Delete Instructions

Locally:

1. Run the following script:

<pre>
sh stop.stg.sh
</pre>

# Task

Based on the [overview report](report/cc_assignment_2_overview.pdf) and the [deployment instructions](#deployment-instructions), you will develop a service, which interacts with this system using and event-driven approach.

This assignment is divided into three parts:

- Task 1 [55%]: Develop a service for consuming and logging data from a Kafka cluster. Test and run the application locally. For this purpose you should use .stg files to deploy the system.
- Task 2 [30%]: Test and run the existing application, the Kafka cluster, and your service on Google Cloud Platform (GCP) using Google Kubernetes Engine (GKE). For this purpose you should use .prod files to deploy the system on GCP.
- Task 3 [15%]: Compare the bandwidth between the pre-implemented batch processing application and the stream processing you are tasked to implement. For this task you can see the difference between two approaches opening Grafana dashboards for the batch and stream processing processing.
