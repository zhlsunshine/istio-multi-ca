#!/bin/bash

export KUBECONFIG=/etc/kubernetes/admin.conf

set -x
export SLEEP_POD_BAR=$(kubectl get pod -n bar -l app=sleep -o jsonpath={.items..metadata.name})
export HTTPBIN_POD_BAR=$(kubectl get pod -n bar -l app=httpbin -o jsonpath={.items..metadata.name})

istioctl proxy-config rootca-compare $SLEEP_POD_BAR.bar $HTTPBIN_POD_BAR.bar

export SLEEP_POD_FOO=$(kubectl get pod -n foo -l app=sleep -o jsonpath={.items..metadata.name})
export HTTPBIN_POD_FOO=$(kubectl get pod -n foo -l app=httpbin -o jsonpath={.items..metadata.name})

istioctl proxy-config rootca-compare $SLEEP_POD_FOO.foo $HTTPBIN_POD_FOO.foo
