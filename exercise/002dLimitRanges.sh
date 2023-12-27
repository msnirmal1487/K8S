# the ResourceQuota, contraint consumption adn creation of cluster resources within specified namespace. but a single object can use up all the resourcers and monopolize.

# LimitRange is the policy to constrain the resource allocation that can specied for each object kind
    # enforce max and min compute resources usage per pod / container in NS
    # enforce min and max storage request per persistentVolumeCliam in NS
    # Enforce ratio b/w request & Limit for a resource in NS
    # set default req/limit for resources to be injects to containers

# LimitRange is enforced in NS when there is a LimitRange object in NS
#LimitRange is checked only on POD creation and not applied on running pods.

# LimitRange admission controller, 
    # aplies default request and limit if no compute resource requirements are set. 
    # tracks usage to ensure it does not violate the limits
    # if 2 or more limitRange objects are present, it is not determininstic which will be default value. 
    # LimitRange should have both requests and limits. otherwise, pod creation will be rejected
    # if the default value set by LimitRange is less than the request value set in container spec, the container will not be scheduled

k create quota mem-cpu-demo --hard='requests.cpu=1,limits.cpu=2,requests.memory=1Gi,limits.memory=2Gi' $d $o