#!/bin/bash
# Expose the services
echo "Starting the prometheus cluster..."
nohup kubectl port-forward service/prometheus-kube-prometheus-prometheus 9090:9090 -n metrics > /dev/null 2>&1 &

echo "Starting the grafana cluster..."
nohup kubectl port-forward service/grafana 3000:3000 -n metrics > /dev/null 2>&1 &