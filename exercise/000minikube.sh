# https://minikube.sigs.k8s.io/docs/start/
# https://minikube.sigs.k8s.io/docs/tutorials/multi_node/
brew install minikube

minikube start
# -p : assign profile name to the cluster
minikube start --nodes 2 -p multinode-demo
minikube status -p multinode-demo
minikube profile # shows the current active profile
minikube profile list #lists the active profile
minikube profile <profile-name> # set profile <profile-name> as active
minikube pause / unpause / stop / delete --all

minikube addons list

minikube addons enable metrics-server

minikube ssh #ssh into the control plane server in the active profile
minikube ssh -n <node-name> #ssh into the specific node

# https://minikube.sigs.k8s.io/docs/handbook/accessing/
minikube service <service-name> --url #runs as a process, creating a tunnel to the cluster. The command exposes the service directly to any program running on the host operating system.


