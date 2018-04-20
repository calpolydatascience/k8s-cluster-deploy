# k8s-cluster-deploy

## Set Up

```bash
# Install kops on OS X
$ brew update && brew install kops

# Create S3 bucket to store config
$ aws s3 mb s3://clusters.k8s.calpolydatascience.org

# Set NAME and KOPS_STATE_STORE
# Public was: k8s.thedwightway.com
$ export NAME=calpolydatascience.k8s.local
$ export KOPS_STATE_STORE=s3://clusters.k8s.calpolydatascience.org
```
 
## Create Cluster

```bash
# kops create cluster --zones=us-west-1c k8s.thedwightway.com
$ kops create cluster \
    --zones us-west-2a \
    --node-count=2 \
    --node-size=t2.medium \
    --master-size=t2.medium \
    ${NAME}

# Customize/view the cluster specs
kops edit cluster ${NAME}

# Build the cluster for real
kops update cluster ${NAME} --yes

# Optional Deployment Method via CloudFormation
# Writes tempate to ./out
kops update cluster ${NAME} --target=cloudformation

```

## Set Up Helm

```bash
# Install helm, on OS X
$ brew install kubernetes-helm

# Create tiller service account, cluster-side package manager
$ kubectl --namespace kube-system create serviceaccount tiller
$ helm init --service-account tiller
```

## Deploy JupyterHub from Helm Chart
See `config.yaml`

```bash
$ helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
$ helm repo update
$ helm install jupyterhub/jupyterhub \
    --version=v0.6 \
    --name=<YOUR-RELEASE-NAME> \
    --namespace=<YOUR-NAMESPACE> \
    -f config.yaml
```
```bash
# Example
$ helm install jupyterhub/jupyterhub \
    --version=v0.6 \
    --name=alpha \
    --namespace=alpha \
    -f config.yaml

$ kubectl -n alpha get pod
NAME                     READY     STATUS    RESTARTS   AGE
hub-945946ccc-vg77l      1/1       Running   1          1m
proxy-77fc8fdf79-rggvg   2/2       Running   0          1m

$ kubectl -n alpha get svc
NAME           TYPE           CLUSTER-IP       EXTERNAL-IP        PORT(S)                      AGE
hub            ClusterIP      100.65.176.102   <none>             8081/TCP                     2m
proxy-api      ClusterIP      100.71.252.191   <none>             8001/TCP                     2m
proxy-http     ClusterIP      100.64.150.111   <none>             8000/TCP                     2m
proxy-public   LoadBalancer   100.66.142.110   a73e49ae81e4d...   80:32174/TCP,443:31291/TCP   2m
```

## Making changes
```bash
$ helm upgrade alpha jupyterhub/jupyterhub --version=v0.6 -f config.yaml
```

## To Do:  
- [x] Configure `GitHibOAuth` via `config.yaml`
- [x] Create `kops` user and policies in AWS IAM
- [ ] This: `aws s3api put-bucket-versioning --bucket prefix-example-com-state-store  --versioning-configuration Status=Enabled` 
- [x] AWS EFS storage BS: https://github.com/kubernetes-incubator/external-storage/tree/master/aws/efs
- [ ] Secure Helm:
    ```
    kubectl --namespace=kube-system patch deployment tiller-deploy --type=json --patch='[{"op": "add", "path": "/spec/template/spec/containers/0/command", "value": ["/tiller", "--listen=localhost:44134"]}]'
    ```
- [ ] Fix the RBAC stuff
- [ ] Load test based on DATA301 course work
- [ ] Document `pip install --user [package]`, so user can persist packages. Maybe set as the default?

## Sources:
 - https://zero-to-jupyterhub.readthedocs.io/en/latest/ 
 - https://kubernetes.io/docs/getting-started-guides/kops/
 - https://github.com/kubernetes/kops/blob/master/docs/aws.md
