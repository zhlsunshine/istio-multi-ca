#!/bin/bash

export KUBECONFIG=/etc/kubernetes/admin.conf

set -x
export SLEEP_POD_BAR=$(kubectl get pod -n bar -l app=sleep -o jsonpath={.items..metadata.name})

kubectl exec -it $SLEEP_POD_BAR -n bar -c sleep curl http://httpbin.foo:8000/html

