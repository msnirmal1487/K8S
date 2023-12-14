# These commands are copied from https://labs.play-with-k8s.com/ welcome terminal.
 1. Initializes cluster master node:

 kubeadm init --apiserver-advertise-address $(hostname -i) --pod-network-cidr 10.5.0.0/16

# OUTPUT from command 1 (CHECK THE USER. usually it is root. GO TO alternatively. part)

# #### COPY the kubeadm command to add new nodes to the master
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf
# run step 2 
You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

2. Initialize cluster networking:

 kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.0.8:6443 --token <<SOME TOKEN>> \
        --discovery-token-ca-cert-hash <<some Hash>>
 ## After kubeadm iit command is run copy the token and discovery token hash. 
 
 ##if missed get token using 
    kubeadm token list

## print the discovery token hash using  (need to install openssl and sha256sum). get the output of the command use in format "sha256:<<SHASUM value>>"
openssl x509 -in /etc/kubernetes/pki/ca.crt -noout -pubkey | openssl rsa -pubin -outform DER 2>/dev/null | sha256sum | cut -d' ' -f1

 ### you can generate a new token and get the hash using (the whole command to join)
    kubeadm token create --print-join-command



 3. (Optional) Create an nginx deployment:

 kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/nginx-app.yaml


                          The PWK team.