#!/bin/bash

# Install cluster-autoscaler
helm repo update
helm install stable/cluster-autoscaler \
  --name cluster-autoscaler \
  --set awsRegion=us-west-2 \
  --set "autoscalingGroups[0].name=largenodes.calpolydatascience.k8s.local,autoscalingGroups[0].maxSize=3,autoscalingGroups[0].minSize=1"
