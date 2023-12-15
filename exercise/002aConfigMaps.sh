alias k=kubectl
export do='--dry-run=client -o=yaml'

## From Files (file name becomes key stored in data and contents become the key's value)
k create configmap game-config --from-file=configure-pod-container/configmap/
# OR
k create configmap game-config --from-file=configure-pod-container/configmap/game.properties --from-file=configure-pod-container/configmap/ui.properties
#reads the values from file and generates the yaml with values from file in data node
k create configmap game-config --from-file=configure-pod-container/configmap/ $do 

# apiVersion: v1
# data:
#   game.properties: |-
#     enemies=aliens
#     lives=3
#     enemies.cheat=true
#     enemies.cheat.level=noGoodRotten
#     secret.code.passphrase=UUDDLRLRBABAS
#     secret.code.allowed=true
#     secret.code.lives=30
#   ui.properties: |
#     color.good=purple
#     color.bad=yellow
#     allow.textmode=true
#     how.nice.to.look=fairlyNice
# kind: ConfigMap
# metadata:
#   creationTimestamp: null
#   name: game-config

## using from-env-file create the config values as env varuable without seperating them by filenames
k create configmap game-config-env-file --from-env-file=configure-pod-container/configmap/ui-env-file.properties $do
# apiVersion: v1
# data:
#   color: purple
#   how: fairlyNice
#   textmode: "true"
# kind: ConfigMap
# metadata:
#   creationTimestamp: "2023-12-14T18:23:14Z"
#   name: game-config-env-file
#   namespace: default
#   resourceVersion: "9698"
#   uid: f18c004e-df01-4030-bf1b-2804859b84a0

## using from literal
k create configmap special-config --from-literal=special.how=very --from-literal=special-type=charm $do
# apiVersion: v1
# data:
#   special-type: charm
#   special.how: very
# kind: ConfigMap
# metadata:
#   creationTimestamp: null
#   name: special-config

k get configmap game-config 
k describe configmap game-config 

## Configmap generator
# Create a kustomization.yaml file with ConfigMapGenerator
cat <<EOF >./kustomization.yaml
configMapGenerator:
- name: game-config-4
  options:
    labels:
      game-config: config-4
  files:
  - configure-pod-container/configmap/game.properties
EOF

k apply -k . # makes the current directory as a kustomization directory

# configMapGenerator ????



# in the spec.contaniner[]. 
# define below to use individual confimap keys
env:
  - name: SPECIAL_LEVEL_KEY
    valueFrom: 
      configMapKeyRef:
        name: special-config
        key: special.how

# define below to use entire confimap keys
envFrom:
  - configMapRef:
      name: special-config

# the config map defined env variables can be used in command and args of container using he syntax $(VAR_NAME)

# mount the config map as a volume in pod and access it inside containers

apiVersion: v1
kind: Pod
metadata:
  name: dapi-test-pod
spec:
  containers:
    - name: test-container
      image: registry.k8s.io/busybox
      command: [ "/bin/sh", "-c", "ls /etc/config/" ]
      volumeMounts:
      - name: config-volume
        mountPath: /etc/config
  volumes:
    - name: config-volume
      configMap:
        # Provide the name of the ConfigMap containing the files you want
        # to add to the container
        name: special-config
  restartPolicy: Never

#   using option: true makes the configmap optional. if the configMap does not exist or if the configMap exists and the key is not present then the configuration for which it supplie value wil be empty
#  if you reference a configMap notcreated na ddo not mark it as optional, the pod will not start
#  config maps reside in namespace and pods can refer to configmaps tht are  in its own namespace
#  static pods cannot use configmaps\
# if u use envFrom, configmap keys that are considered invalid will be skipped

