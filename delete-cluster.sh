#!/bin/bash

#helm delete test --purge
kops delete cluster --name calpolydatascience.k8s.local --yes
