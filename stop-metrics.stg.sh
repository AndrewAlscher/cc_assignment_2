#!/bin/bash

delete_kubectl() {
    resource_type=$1
    resource_name=$2
    namespace=$3

    case "${resource_type}" in
        namespace|clusterrole|clusterrolebinding|mutatingwebhookconfiguration|validatingwebhookconfiguration)
            kubectl delete "$resource_type" "$resource_name"
            ;;
        *)
            kubectl delete "$resource_type" "$resource_name" -n "$namespace"
            ;;
    esac

    if [ $? -ne 0 ]; then
        echo "Error deleting $resource_name of type $resource_type."
    fi
}

echo "Stopping the prometheus services in metrics namespace"
delete_kubectl service alertmanager-operated metrics
delete_kubectl service prometheus-grafana metrics
delete_kubectl service prometheus-kube-prometheus-alertmanager metrics
delete_kubectl service prometheus-kube-prometheus-operator metrics
delete_kubectl service prometheus-kube-prometheus-prometheus metrics
delete_kubectl service prometheus-kube-state-metrics metrics
delete_kubectl service prometheus-operated metrics
delete_kubectl service prometheus-prometheus-node-exporter metrics


echo "Stopping the prometheus services in kube-system namespace"
delete_kubectl service prometheus-kube-prometheus-coredns kube-system
delete_kubectl service prometheus-kube-prometheus-kube-controller-manager kube-system
delete_kubectl service prometheus-kube-prometheus-kube-etcd kube-system
delete_kubectl service prometheus-kube-prometheus-kube-proxy kube-system
delete_kubectl service prometheus-kube-prometheus-kube-scheduler kube-system
delete_kubectl service prometheus-kube-prometheus-kubelet kube-system


echo "Stopping the prometheus deployments in metrics namespace"
delete_kubectl deployment prometheus-grafana metrics
delete_kubectl deployment prometheus-kube-prometheus-operator metrics
delete_kubectl deployment prometheus-kube-state-metrics metrics


echo "Stopping the prometheus statefulsets in metrics namespace"
delete_kubectl statefulset alertmanager-prometheus-kube-prometheus-alertmanager metrics
delete_kubectl statefulset prometheus-prometheus-kube-prometheus-prometheus metrics


echo "Stopping the prometheus daemonsets in metrics namespace"
delete_kubectl daemonset prometheus-prometheus-node-exporter metrics


echo "Stopping the prometheus custom resources in metrics namespace"
delete_kubectl prometheus prometheus-kube-prometheus-prometheus metrics


echo "Stopping the prometheusrules custom resources in metrics namespace"
delete_kubectl prometheusrule prometheus-kube-prometheus-alertmanager.rules metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-config-reloaders metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-etcd metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-general.rules metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-k8s.rules metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-kube-apiserver-availability.rules metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-kube-apiserver-burnrate.rules metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-kube-apiserver-histogram.rules metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-kube-apiserver-slos metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-kube-prometheus-general.rules metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-kube-prometheus-node-recording.rules metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-kube-scheduler.rules metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-kube-state-metrics metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-kubelet.rules metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-kubernetes-apps metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-kubernetes-resources metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-kubernetes-storage metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-kubernetes-system metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-kubernetes-system-apiserver metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-kubernetes-system-controller-manager metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-kubernetes-system-kube-proxy metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-kubernetes-system-kubelet metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-kubernetes-system-scheduler metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-node-exporter metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-node-exporter.rules metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-node-network metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-node.rules metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-prometheus metrics
delete_kubectl prometheusrule prometheus-kube-prometheus-prometheus-operator metrics


echo "Stopping the grafana services in metrics namespace"
delete_kubectl deployment grafana metrics
delete_kubectl service grafana metrics


echo "Stopping the prometheus clusterroles"
delete_kubectl clusterrole prometheus-grafana-clusterrole
delete_kubectl clusterrole prometheus-kube-prometheus-operator
delete_kubectl clusterrole prometheus-kube-prometheus-prometheus
delete_kubectl clusterrole prometheus-kube-state-metrics


echo "Stopping the prometheus clusterrolebindings"
delete_kubectl clusterrolebinding prometheus-grafana-clusterrolebinding
delete_kubectl clusterrolebinding prometheus-kube-prometheus-operator
delete_kubectl clusterrolebinding prometheus-kube-prometheus-prometheus
delete_kubectl clusterrolebinding prometheus-kube-state-metrics


echo "Stopping the prometheus mutatingwebhookconfiguration"
delete_kubectl mutatingwebhookconfiguration prometheus-kube-prometheus-admission


echo "Stopping the prometheus validatingwebhookconfiguration"
delete_kubectl validatingwebhookconfiguration prometheus-kube-prometheus-admission


echo "Delete the namespace metrics"
delete_kubectl namespace metrics

