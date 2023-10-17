How to start minikube:
minikube start --profile kafkaminikube --cpus 6 --memory 14980 --driver docker --no-vtx-check
minikube dashboard --profile=kafkaminikube --url true

How to get contexts:
kubectl config get-contexts

How to remove contexts:
kubectl config unset contexts.minikube

How to start kafka-cluster:
kubectl apply -f 00-zookeeper-service.dev.yaml
kubectl apply -f 01-zookeeper-deployment.dev.yaml
kubectl apply -f 02-kafka-service.dev.yaml
kubectl apply -f 03-kafka-deployment.dev.yaml

How to check if Kafka is running:
kubectl get deployment
kubectl get services
kubectl get pods
kubectl get all

How to check nodes:
kubectl get nodes -o wide

DNS resolution:
kubectl run -i --tty --rm debug --image=busybox --restart Never -- nslookup kafka-service.leaf-image-management-system.svc.cluster.local

How to open the port:
kubectl port-forward kafka-89cc56899-lqn74 9093 (pod name) OR
kubectl port-forward deployment/kafka-broker 9093:9093 -n leaf-image-management-system (deployment name) OR
kubectl port-forward service/kafka-service 9093:9093 -n leaf-image-management-system (service name)

To check if Kafka is running:
kubectl delete pod debug
kubectl run -i --tty --rm debug --image=busybox --restart Never -- sh
telnet kafka-service.leaf-image-management-system.svc.cluster.local 9092
exit

How to test:
echo "My Message" | kcat -P -b 127.0.0.1:9093 -c 1 -t some-topic
kcat -C -b 127.0.0.1:9093 -t some-topic

How to delete kafka-cluster:
kubectl delete service kafka-service
kubectl delete deployment kafka-broker
kubectl delete service zookeeper
kubectl delete deployment zookeeper
kubectl delete namespace kafka
