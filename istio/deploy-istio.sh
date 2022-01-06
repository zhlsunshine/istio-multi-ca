#!/bin/bash

export KUBECONFIG=/etc/kubernetes/admin.conf

istioctl install -f istio-certs.yaml -y
