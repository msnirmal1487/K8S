apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: liveliness-exec
  name: liveliness-exec
spec:
  containers:
  - args:
    - /bin/sh
    - -c
    - touch /tmp/healthy; sleep 30; rm -f /tmp/healthy; sleep 600
    image: registry.k8s.io/busybox
    name: liveliness-exec
    resources: {}
    livenessProbe:
      exec:
        command:
          - cat
          - /tmp/healthy
      initialDelaySeconds: 5 # waits for 5 seconds before checking first liveness probe test
      periodSeconds: 5 # makes liveness tests every 5 seconds
  dnsPolicy: ClusterFirst
  restartPolicy: Never
status: {}

--

livenessProbe:
      httpGet:
        path: /healthz
        port: 8080
        httpHeaders:
          - name: Custom-Header
            value: Awesome
      initialDelaySeconds: 3
      periodSeconds: 3
---
      livenessProbe:
      grpc:
        port: 2379
----
startupProbe:
  httpGet:
    path: /healthz
    port: liveness-port
  failureThreshold: 30 # the probe will be checked 30 times. hence in total the probe will be checked for (5 mins 300 seconds) 30 times every 10 seconds
  periodSeconds: 10



k explain pod.spec.containers.livenessProbe # To get details about a parameter

k get event -o json | jq -r '.items[] | select(.message | contains("failed")).involvedObject | .namespace + "/" + .name' 