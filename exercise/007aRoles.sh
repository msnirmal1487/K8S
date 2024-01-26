# describe the kube-apiserver-pod to get details about the cluster

k describe pod kube-apiserver-minikube -n kube-system
kubectl exec -it kube-apiserver-controlplane -n kube-system -- kube-apiserver -h | grep 'enable-admission-plugins'
ps -ef | grep kube-apiserver| grep admission-plugins # run from inside master node

# creates a proxy to api server and runs in background
k proxy 8001 &
[1] 5604
# Get more details about the APIs (live versions available, prefered version.) to get storage version need to log int etcd and check.
curl 127.0.0.1:8001/apis/authorization.k8s.io  


k auth can-i get pods --as dev-user 
k auth can-i --list --as dev-user 
k api-resources --namespaced=true --no-headers | wc -l
k api-resources --namespaced=false --no-headers | wc -l


kube manifests files are in

cd /etc/kubernetes/manifests/
# Install kubectl convert plugin
https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-convert-plugin
k convert -f ingress-old.yaml | k create -f - # convert old yaml and create resource.