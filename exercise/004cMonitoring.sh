minikube addons list
# to enable metrics server in minikube environment, use 
minikube addons enable metrice-server

# for others follow steps in 
# https://github.com/kubernetes-sigs/metrics-server

kubectl top node --sort-by='memory' --no-headers | head -1 
k top pod