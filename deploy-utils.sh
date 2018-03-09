#!/bin/bash

# Create tiller service account, cluster-side package manager
kubectl --namespace kube-system create serviceaccount tiller
helm init --service-account tiller

# Create Services
## Kubernetes Dashboard
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

## Heapster (Resource Usage Monitoring)
# https://github.com/kubernetes/heapster/tree/master/deploy/kube-config/influxdb
# kubectl create -f [All the yaml files in above]