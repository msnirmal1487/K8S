apiVersion: v1
data:
  .secret-file: dmFsdWUtMg0KDQo= # echo -n dmFsdWUtMg0KDQo= |base64 --decode || to encode : echo -n val | base64
kind: Secret
metadata:
  creationTimestamp: null
  name: dotfile-secret
---
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: secret-dotfiles-pod
  name: secret-dotfiles-pod
spec:
  volumes:
    - name: secret-volume
      secret:
        secretName: dotfile-secret
  containers:
  - command:
    - ls
    - -la
    - /etc/secret-volume
    image: registry.k8s.io/busybox
    name: secret-dotfiles-pod
    resources: {}
    volumeMounts:
      - name: secret-volume
        readOnly: true
        mountPath: "/etc/secret-volume"
  dnsPolicy: ClusterFirst
  restartPolicy: Never

#   Secrets Built-In types
    # Opaque, kubernetes.io/service-account-token, kubernetes.io/dockercfg, kubernetes.io/dockerconfigjson
    # kubernetes.io/basic-auth, kubernetes.io/ssh-auth, kubernetes.io/tls, bootstrap.kubernetes.io/token


# we can define our own secret type by assigning non empty string as type (if using empty String the secret becomes Opaque type)
# ifusing built-in types, must meet all requirements defined for that type
# if defining a type for pubic us, follow the convention "domain-name/secret-type-name"

# OPAQUE secret
    # default type (no type to be mentioned in manifest)
    kubectl create secret generic
    # 
# kubernetes.io/service-account-token
    # store token credential that identifies Service account.
    # legacy mechanism, provide long lived ServiceAccount credentials to PODs

    echo -n 'my-app'|base64
    echo -n '39528$vdg7Jb'|base64

    # to read secret's value
    k get secret mysecret2 -o jsonpath='{.data.username}{"\n"}'
    k get secret mysecret2 -o jsonpath='{.data.username}{"\n"}' | base64 --decode

    k create secret generic my-secret $ns --type="kubernetes.io/ssh-auth" --from-file=ssh-privatekey=id_rsa $do > sc.yaml
k apply -f sc.yaml
