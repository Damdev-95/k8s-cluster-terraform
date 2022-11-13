# k8s-terraform



* List the contents of the terraform files 

![image](https://user-images.githubusercontent.com/71001536/201485457-2d2c7966-dd32-495b-bbde-20ca274cee86.png)


* Initialize terraform on the directory to doenload required providers

`terraform init`

![image](https://user-images.githubusercontent.com/71001536/201486591-0425184d-39a6-448a-8ab0-2135a73729c3.png)


* Validate the terraform file using :

` terraform plan `

![image](https://user-images.githubusercontent.com/71001536/201486561-a89b6837-4eaf-4d7f-a09b-00525da790ef.png)


![image](https://user-images.githubusercontent.com/71001536/201486498-bfc1c69a-2471-40bd-972e-5a97b6c00f92.png)

* Apply the terraform configuraton file 

`terraform apply --auto-approve`

![image](https://user-images.githubusercontent.com/71001536/201489323-a0aa9335-df43-4cb9-bc0c-e63f3a41b502.png)


![image](https://user-images.githubusercontent.com/71001536/201489766-5903a5b3-4d0f-4d86-afdc-774d032507ce.png)

* Copy the output of the terraform configuration to the  `~/.kube/config`

* Installing aws-iam-authenticator
This enables using AWS IAM credentials to authenticate to a Kubernetes cluster 

```
curl -Lo aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.5.9/aws-iam-authenticator_0.5.9_linux_amd64
chmod +x ./aws-iam-authenticator
mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
```

* Communicate with Kuberbetes cluster  using `kubectl get all `

![image](https://user-images.githubusercontent.com/71001536/201511347-0b94734a-5d23-4937-aa9b-9e2305e1b04e.png)

* Get the pods in the cluster using 'kubectl get pods --all-namespaces'

![image](https://user-images.githubusercontent.com/71001536/201511439-ca332277-8e27-412d-a724-64633e878a0b.png)

* Deploy the manifest for the pods deployment 

`kubectl apply -f manifests/deployment.yaml`

![image](https://user-images.githubusercontent.com/71001536/201511860-4c441d9a-e3dd-4117-b0ad-390a0dd5c5a0.png)

* Validate the deployment using `kubectl get pods`

![image](https://user-images.githubusercontent.com/71001536/201511930-526d28dd-2224-4fa2-8ba1-c2e42553c9b0.png)

* Testing the deployment using the port forward 

`kubectl port-forward hello-kubernetes-6bf86759db-7jf7j 8080:8080`

![image](https://user-images.githubusercontent.com/71001536/201512080-c3041251-00a5-407f-bfa1-9af2f28c0fd9.png)

*  ALB Ingress Controller can be installed with Helm 
* Install Helm package
```
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ ./get_helm.sh
```

![image](https://user-images.githubusercontent.com/71001536/201512846-f9bf14a7-da44-4c51-9519-4b742d6f0faa.png)

* Install the collection of YAML files necessary to run the ALB Ingress Controller. Add the following repository

` helm repo add incubator https://charts.helm.sh/incubator`

* Install the ALB Ingress Controller in my cluster

```
helm install ingress incubator/aws-alb-ingress-controller \
  --set autoDiscoverAwsRegion=true \
  --set autoDiscoverAwsVpcID=true \
  --set clusterName=terraform-eks
```

![image](https://user-images.githubusercontent.com/71001536/201513262-6fa01543-1609-4715-8f46-6cc9f60ab7f5.png)

* Deploy the service loadbalancer on the cluster `kubectl apply -f manifest/loadbalancer.yaml`

![image](https://user-images.githubusercontent.com/71001536/201532391-13c0feea-837c-41a9-b5d8-be86a52c6b1c.png)

![image](https://user-images.githubusercontent.com/71001536/201532428-e2b3ebd9-2513-4205-9a89-bbd0707b602b.png)


* Deploy the ingress.yaml for the service

```
wget https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.9/docs/examples/alb-ingress-controller.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.9/docs/examples/rbac-role.yaml
```
## the cluster name and vpc id is change in the alb-ingress-controller.yaml

![image](https://user-images.githubusercontent.com/71001536/201527040-63a66c82-7a54-4c65-8e75-e975dc3ef44f.png)


![image](https://user-images.githubusercontent.com/71001536/201528085-272a19cf-f04b-46ed-84fb-faa4dd689d43.png)

![image](https://user-images.githubusercontent.com/71001536/201528137-a0e139af-adb6-429e-9cfc-89f8813b882e.png)












