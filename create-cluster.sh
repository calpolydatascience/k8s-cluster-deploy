#!/bin/bash

export NAME=beta.k8s.local
export KOPS_STATE_STORE=s3://clusters.k8s.thedwightway.com

# Create Cluster
kops create cluster \
  --zones us-west-2a \
  --node-count=2 \
  --node-size=t2.medium \
  --master-size=t2.micro \
  --ssh-public-key ./keys/kops_rsa.pub \
  --topology private \
  --networking weave \
  ${NAME} \
  --yes 