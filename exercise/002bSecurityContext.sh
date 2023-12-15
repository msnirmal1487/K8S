# Security context for a POD (add SecurityContext to spec)
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: sec-ctx-demo
  name: sec-ctx-demo
spec:
  securityContext:
    runAsUser: 1000 # for any containers in the pod, al process run with user id 1000
    runAsGroup: 3000 # primary group id for all process in containers. if omited, primary g id will be root(0) 
    # all files created will be owned by user 1000 and group 3000 (0 if runAsGroup skipped). 
    fsGroup: 2000 # mentioning this, all proceses of the container are also a part of supplementary group 2000
  volumes:
    - name: sec-ctx-vol
      emptyDir: {} # volume type that we can use to create files inside container.
  containers:
  - command:
    - sh
    - -c
    - sleep 1h
    image: busybox:1.28
    name: sec-ctx-demo
    resources: {}
    volumeMounts: 
     - name: sec-ctx-vol
       mountPath: /data/demo 
  dnsPolicy: ClusterFirst
  restartPolicy: Never
status: {}

# `id` used to get the uid, gid and group memberships of current user

# K8s recursively change owhership and permissions for the contents of each vol to fsgroup specified in SecurityContext when the volume is mounted
    # for large voles, this might slow down pod startup
    #  fsChangeGroupPolicy helps to fix it

securityContext:
    runAsUser: 1000 
    runAsGroup: 3000 
    fsGroup: 2000 
    fsChangeGroupPolicy: "OnRootMismatch" # change permissions and ownership if the expected on vol does not match root 
                                          # other option "Always"

# fsChangeGroupPolicy - has no impact on Ephimeral vols secret, configMap, emptyDir

# Security context for a Container (9)add securityContext to container)
    # applied only to individual containers
    # override the settings at POD level
    # settings do not affect POD volumes.

apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: sec-ctx-demo
  name: sec-ctx-demo1
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
  volumes:
    - name: sec-ctx-vol
      emptyDir: {}
  containers:
  - command:
    - sh
    - -c
    - sleep 1h
    image: busybox:1.28
    name: sec-ctx-demo
    securityContext:
      runAsUser: 2000
      allowPrivilegeEscalation: false
    resources: {}
    volumeMounts:
     - name: sec-ctx-vol
       mountPath: /data/demo
  dnsPolicy: ClusterFirst
  restartPolicy: Never


##Change the LINUX Capabilities for a container
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: security-context-demo-4
  name: security-context-demo-4
spec:
  containers:
  - image: gcr.io/google-samples/node-hello:1.0
    name: security-context-demo-4
    securityContext:
      capabilities:
        add: ["NET_ADMIN", "SYS_TIME"]
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Never
status: {}