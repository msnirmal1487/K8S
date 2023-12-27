apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: two-contain
  name: two-contain-pod
spec:
  containers:
   - command:
       - sh 
       - -c
       - echo hello; sleep 3600
     image: busybox
     name: contain-1
     resources: {}
   - command:
       - sh 
       - -c
       - echo hello; sleep 3600
     image: busybox
     name: contain-2
     resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Never
status: {}

k logs two-contain-pod -c contain-2
k logs two-contain-pod -c contain-1
k exec -it two-contain-pod -c contain-2 -- ls

