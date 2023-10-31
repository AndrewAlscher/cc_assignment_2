#!/bin/bash

apply_kubectl() {
    file=$1
    kubectl apply -f "$file"
    if [ $? -ne 0 ]; then
        echo "Error applying $file."
    fi
}

check_helm_installed() {
    helm version --short &> /dev/null
    return $?
}

check_helm_repo() {
    repo_name=$1
    helm repo list | grep -q $repo_name
    return $?
}

# Deploy main namespace
echo "Started deploying Prometheus and Grafana"

# Check if helm is installed
if check_helm_installed; then
    echo "Helm is installed, proceeding with deployment."
else
    echo "Helm is not installed, please install Helm first."
    exit 1
fi

echo "Creating the namespace"
apply_kubectl metrics/common/00-metrics-namespace.yaml

echo "Deploying Prometheus"

# Check if the prometheus-community repo exists
if check_helm_repo "prometheus-community"; then
    echo "prometheus-community repo already exists"
else
    echo "Adding prometheus-community repo"
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo update
fi

helm install prometheus prometheus-community/kube-prometheus-stack -n metrics

apply_kubectl basic_services/api/image_api/stg/02-image-api-service-monitor.stg.yaml
apply_kubectl basic_services/jobs/outer_jobs/db_synchronizer/stg/02-db-synchronizer-monitor.stg.yaml

echo "Deploying Grafana"
apply_kubectl metrics/grafana/stg/00-grafana-pvc.stg.yaml
apply_kubectl metrics/grafana/stg/01-grafana-datasources.stg.yaml
apply_kubectl metrics/grafana/stg/02-grafana-deployment.stg.yaml
apply_kubectl metrics/grafana/stg/03-grafana-service.stg.yaml


