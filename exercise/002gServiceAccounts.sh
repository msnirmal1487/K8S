k get pod n -o jsonpath='{.spec.serviceAccountName}{"\n"}' # Default service account is assigned if no Service account is specified at creation
# app running inside POD can access the K8S API using automatically mounted service account details
# in the path `/var/run/secrets/kubernetes.io/serviceaccount/token`

#     Opt out of kubelet automatically mounting SA API credentials 
apiVersion: v1
kind: ServiceAccount
metadata:
  name: build-robot
automountServiceAccountToken: false 
or 
.spec.automountServiceAccountToken: false # Opt out of mounting credentials for a particular pod
# if both are present, the PODs value has presedence

k get serviceaccounts
k create sa build-robot $d $o > sa.yaml
k create token build-robot # to create a time limited API token for the Service acount
KUBECTL_NODE_BIUND_TOKENS=true k create token build-robot --bound-object-kind Node --bound-object-name minikube --bound-object-uid cfd03a6d56144c049f108e1c2a2c4ad3

# to create an API token for a service account, create a new secret with special annotation kubernetes.io/service-account.name
k create secret generic build-robot-secret --type kubernetes.io/service-account-token $d $o . sa_sec.yaml
# edit to add the annotation

k get sa -A

k create sa myuser $d $o

# seting Service account in  pod creation mounts a new secret as a volume 

