#!/bin/bash

helm upgrade $1 jupyterhub/jupyterhub \
  --version=v0.7-e995f63 \
  -f deployments/config-$1.yaml

