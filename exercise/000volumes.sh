# ephemeral volumes have lifetime of a pod
# persistent volumes exist beyond lifetime of a pod

# all volumes are preserved across container restart.

# volume === directory. (with / without data) accessible to pods
# how directory comes to be, medium that backs it, contents determined by volume type

# To use a volume
#   1) specify volumes to provide for teh pod in .spec.volumes
#   2) where to mount volumes into containers in .spec.containers[*].volumeMount

