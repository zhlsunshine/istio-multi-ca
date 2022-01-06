#!/bin/bash

export KUBECONFIG=/etc/kubernetes/admin.conf

cd /home/zhlsunshine-1/go/src/istio

kubectl create ns bar
kubectl apply -f <(istioctl kube-inject -f samples/httpbin/httpbin.yaml) -n bar
kubectl apply -f <(istioctl kube-inject -f samples/sleep/sleep.yaml) -n bar

sleep 5s

kubectl get pods -n bar -o wide
cd -
