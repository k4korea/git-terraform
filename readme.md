c:\user\.kube\config

cp /etc/kubernetes/admin.conf   c:\user\.kube\config

Helm will figure out where to install Tiller by reading your Kubernetes configuration file (usually $HOME/.kube/config). This is the same file that kubectl uses.


kubectl get node
helm ls -A
terraform plan


$ kubectl config current-context
my-cluster


export KUBECONFIG=c:\user\.kube\config