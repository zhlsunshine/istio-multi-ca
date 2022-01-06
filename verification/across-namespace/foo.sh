#!/bin/bash

export KUBECONFIG=/etc/kubernetes/admin.conf

set -x
export SLEEP_POD_FOO=$(kubectl get pod -n foo -l app=sleep -o jsonpath={.items..metadata.name})

kubectl exec -it $SLEEP_POD_FOO -n foo -c sleep curl http://httpbin.bar:8000/html
