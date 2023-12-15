# yum <package name> # to install appps in play with K8S environment
# create an alias to kubectl
alias k=kubectl
alias 'kd=kubectl --dry-run=client -o=yaml'

export do='--dry-run=client -o=yaml'
# k create ns myns $do # usage

# to get the linux release details
cat /etc/*release*
ls /etc/*release*

# yum, apt-get # possibel pakage managers


k options # to get the list of global command-line options (applies to all commands).
k version --client -o=yaml # get kubectl client version
k version -o=yaml # get kubectl client and server version 
# using --client and --client=true is identical
# not specifying the flag takes it default value (false in this case ||ar to --client=false)
apt-get update
apt-get install -y man #install manuals
apt-get install -y tcpdump #install tcpdump
apt-get install -y lsof # install lsof (is a command for LiSting Open Files)
apt-get install -y procps # install procps (used for ps command) is a set of command line and full-screen utilities that provide information out of the pseudo-filesystem most commonly located at /proc
apt-get install -y curl 

# to get/open a shell to the pod. we can run the shell commands till we give (ctrl + d) / exit to exit out of the shell. 
k exec --stdin --tty <pod-name> -- /bin/bash
k exec -i -t <pod-name> -- /bin/bash
k exec -i -t <pod-name> --container <container name> -- /bin/bash #if pod has more than one container
k exec -i -t <pod-name> -c <container name> -- /bin/bash #if pod has more than one container
# to run individual commands 
k exec shell-demo -- env  #(list environment variables)
kubectl exec shell-demo -- ps aux
kubectl exec shell-demo -- ls /
kubectl exec shell-demo -- cat /proc/1/mounts

# to use the kubectl client to connect to multiple clusters/namespaces/users create contexts and switch between contexts
k config --kube-config=<file name> #the context details are written to and read from this file
# if u appect the <file name> to $KUBECONFIG (export KUBECONFIG="${KUBECONFIG};<file-path1>;<file-path-2>") we can skip passing the 
#   --kubeconfig flag.
k config view  # to view the available contexts and location, authorization for API server
k config view --mninify # to view only the current context

k auth --help # Inspect authorizations allowed.

# create a proxy server (in background) that we can use to access API server via curl/wget
k proxy -p=8080 & 
# curl http://localhost:8080/api/  # API access by REST

k get pod <pod name> --template='{{.spec.containers}}{{"\n"}}' # GO Template to print container array 
K get pod <pod name> --template='{{(index .spec.containers 0)}}{{"\n"}}' # GO Template to print first element of container array

k get pod nginx -o jsonpath='{.spec.containers[].image}{"\n"}' #JSONPATh template
k get pod nginx --template='{{(index .spec.containers 0).image}}{{"\n"}}' # Corresponding GO Template

# Forward local port (port on the machine where kubectl client is executed) to a port on pod {[LOCAL_PORT:]REMOTE_PORT}
k port-forward mongo-7d96cb4cf-cl47r 28015:27017 & # (not mentioning local port system assigns a higher number port arandomly)
# connect to mongo shell in pod from client on port 28015
mongosh --port 28015

k run 
k run busybox --image=busybox --command --restart=Never -it --rm -- env
k logs <pod name> # Get the logs with starting the pod

k set # to edit resources
k set image pod/<pod-name> # to edit the POD

kd run b1 --image=busybox --command -- echo 'hello world' # overrides the ENTRYPOINT command and its arguments
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: b1
  name: b1
spec:
  containers:
  - command:
    - echo
    - hello world
    image: busybox
    name: b1
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
kd run b1 --image=busybox -- echo 'hello world' # overrides the parameters to command in ENTRYPOINT 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: b1
  name: b1
spec:
  containers:
  - args:
    - echo
    - hello world
    image: busybox
    name: b1
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
