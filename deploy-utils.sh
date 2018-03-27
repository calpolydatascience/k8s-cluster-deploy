#!/bin/bash

# Create tiller service account, cluster-side package manager
kubectl --namespace kube-system create serviceaccount tiller
helm init --service-account tiller

# Install Kubernetes Dashboard
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

# Install Storage Class
kubectl create -f manifest.yaml

# TODO: Install Heapster (Resource Usage Monitoring)
# https://github.com/kubernetes/heapster/tree/master/deploy/kube-config/influxdb
# kubectl create -f [All the yaml files in above]
# kubectl create -f https://github.com/kubernetes/heapster/tree/master/deploy/kube-config/influxdb/influxdb.yaml
# kubectl create -f https://github.com/kubernetes/heapster/tree/master/deploy/kube-config/influxdb/grafana.yaml
# kubectl create -f https://github.com/kubernetes/heapster/tree/master/deploy/kube-config/influxdb/heapster.yaml

# Create EFS Mount Targets
# Server: fs-8e79f327.efs.us-west-2.amazonaws.com