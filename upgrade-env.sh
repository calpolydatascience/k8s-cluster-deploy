#!/bin/bash

helm upgrade $1 jupyterhub/jupyterhub \
  --version=v0.6 \
  -f deployments/config-$1.yaml

