#!/bin/bash

export NAME=calpolydatascience.k8s.local
export KOPS_STATE_STORE=s3://clusters.k8s.calpolydatascience.org

# Create Cluster
kops create cluster \
  --zones us-west-2a \
  --node-count=1 \
  --node-size=r4.large \
  --master-size=t2.micro \
  --ssh-public-key ./keys/kops_rsa.pub \
  --topology private \
  --networking weave \
  ${NAME} \
  --yes 