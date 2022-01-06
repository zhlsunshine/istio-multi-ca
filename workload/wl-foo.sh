#!/bin/bash

export KUBECONFIG=/etc/kubernetes/admin.conf

cd /home/zhlsunshine-1/go/src/istio

kubectl create ns foo
kubectl apply -f <(istioctl kube-inject -f samples/httpbin/httpbin.yaml) -n foo
kubectl apply -f <(istioctl kube-inject -f samples/sleep/sleep.yaml) -n foo

sleep 5s

kubectl get pods -n foo -o wide
cd -
