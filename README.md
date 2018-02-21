## Please note this project is just a spike to play a bit around with concourse, a simple node app on AWS and k8s.

It might not follow all security regulations, please use it on your own risk.

### Concourse: 

`fly -t test set-pipeline --load-vars-from credentials.yml -p smoke -c pipeline.yml`


### AWS & k8s

#### create a bucket
``aws s3api create-bucket \
    --bucket kops-k8s-de-state-store \
    --region eu-central-1 \
	--create-bucket-configuration LocationConstraint=eu-central-1``

`aws s3api put-bucket-versioning --bucket kops-k8s-de-state-store --versioning-configuration Status=Enabled`

#### creating cluster with public topology

`export NAME=myfirstprivatecluster.kops-k8s.de`
`export KOPS_STATE_STORE=s3://kops-k8s-de-state-store`

``kops create cluster \
    --zones us-west-2a \
	--ssh-public-key ~/.ssh/kops-k8s.pub \
	--alsologtostderr \
	--log_dir ~/projects/kops/logs \
    ${NAME}``

#### create cluster with private topology, bastion and no public ip
`kops create cluster --node-count 3 --zones eu-central-1a,eu-central-1b,eu-central-1c --master-zones eu-central-1a --topology private --networking weave --node-size t2.medium --master-size t2.large --associate-public-ip=false --bastion=true
--authorization RBAC --ssh-public-key ~/.ssh/id_rsa.pub ${NAME}`

`kops update cluster --yes ${NAME}`

#### install tiller and init helm
``helm init
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
helm install stable/concourse`

#### access concourse locally
`export POD_NAME=$(kubectl get pods --namespace default -l "app=knobby-tiger-web" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward --namespace default $POD_NAME 8080:8080`

#### access k8s dashboard locally

``kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
kubectl create -f dashboard-admin.yaml //you can get this yaml file in fun-with-concourse repo
kubectl proxy``

#### create service account for concourse to access kubernetes from pipeline
``kubectl create serviceaccount concourse
kubectl get serviceaccounts concourse -o yaml``

#### create role and role binding to give concourse user the specific rights to deploy pods.
``kubectl create -f deployer-role.yaml
kubectl create -f deployer-role-binding.yaml``

#### after deployment, you can access the app by port forwarding like a superstar:
`kubectl port-forward pod-name 3000:3000`

HURRAAYYYYYYYYYYY!