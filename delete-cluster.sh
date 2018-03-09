#!/bin/bash

helm delete test --purge
kops delete cluster beta.k8s.local --yes
