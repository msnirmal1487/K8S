k get apiservices

cat pod.yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: cpu-demo
  name: cpu-demo
  namespace: cpu-example
spec:
  containers:
  - args:
    - -cpus
    - "2"
    image: vish/stress
    name: cpu-demo
    resources:
      limits:
        cpu: "1"
        memory: "150Mi"
      requests:
        cpu: "0.5" # 0.5, 500m, 500milliCPU are equivalent. precision can be as low as 0.1
        memory: "123Mi" # 128974848, 129e6, 129M, 123Mi are all equivalent. possible sufixes: E, P, T, G, M K, Ei, Pi, Ti, Gi, Mi, Ki
  dnsPolicy: ClusterFirst
  restartPolicy: Never
status: {}


kubectl top pod cpu-demo --namespace=cpu-example # THough we have passed 2 CPUs in arg, because of th elimit the CPU is trhottled to less than 1
# IF CPU limit not specified, 
    # Container has no upper bound on CPU it can use. it can use up all available on node
    # container running in a Namespace has default limit, the container is assigned the default limit.
# if you specify a CPU limit but no CPU request, k8S automatically assigns a request that matches limit
# if you specify a Memory limit but no Memory request, k8S automatically assigns a request that matches limit

# IF Memory Limit is not specified
    # Container has no upper bound on memory it uses. it could consume all memory on Node where it is runing, which could cause Node to invoke OOM Killer
        # container with no rosource limit has greater chance killed by OOM killer.
    # Container runs in a namespace with default memory limit, the container is automatically assigned the default limit
    
# resource limit/request are associated with containers. It is useful to think of a pod as having a request/limit
# for pod it is the sum of all containers in the pod.


# PODis scheduled on a node only if the node has enough resource to satisfy pod's request

