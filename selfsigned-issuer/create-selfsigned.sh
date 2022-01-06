#!/bin/bash

export KUBECONFIG=/etc/kubernetes/admin.conf

kubectl apply -f selfsigned-for-bar.yaml

kubectl apply -f selfsigned-for-foo.yaml

kubectl apply -f selfsigned-for-istio.yaml
