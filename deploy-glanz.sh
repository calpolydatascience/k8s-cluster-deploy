#!/bin/bash

# Install jupyterhub
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update
helm install jupyterhub/jupyterhub \
  --version=v0.6 \
  --name=glanz \
  --namespace=glanz \
  -f config-glanz.yaml

# TODO: Set Up Automatic DNS provisioning to loadbalancer
# $ kubectl -n test describe svc proxy-public | grep "LoadBalancer Ingress" | cut -d " " -f 7-
# a1a778d26230e11e8b7980213e23469b-413637981.us-west-2.elb.amazonaws.com
# https://docs.aws.amazon.com/cli/latest/reference/route53/change-resource-record-sets.html