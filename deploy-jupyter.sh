#!/bin/bash

helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update
helm install jupyterhub/jupyterhub \
  --version=v0.6 \
  --name=test \
  --namespace=test \
  -f config.yaml