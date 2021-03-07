

#resource "helm_release" "mongodb-sharded" {
#  name      = "mongodb-sharded"
#  chart     = "mongodb-sharded"
#  repository = "https://charts.bitnami.com/bitnami"
#  timeout = 600
#}

# 됨
/*
resource "helm_release" "nginx-ingress3" {
 name       = "bitnaminginx3"
 repository = "https://charts.bitnami.com/bitnami"
 chart      = "nginx"
 version    = "8.3.0"
 wait = false        // 이걸 해줘야 되나.
 timeout = 900

}
*/

/*
resource "helm_release" "grafana-bitnami" {
  name       = "grafana2"
  #namespace = "grafana-bitnami"
  repository = "https://charts.bitnami.com/bitnami" 
  chart      = "grafana"  
  version    = "3.4.1"
  
  wait = false
}
*/

/*
resource "helm_release" "prometheus" {
  #depends_on = [kubernetes_namespace.prometheus_ns]
  name      = "stack"
  namespace = "prometheus"
  recreate_pods = true

  
  #chart     = "prometheus-operator"
  #repository = "https://charts.helm.sh/stable"

  chart       = "kube-prometheus-stack"
  repository  = "https://prometheus-community.github.io/helm-charts"
  version     = "13.12.0"


#  repository = "https://kubernetes-charts.storage.googleapis.com"
  wait = false
  timeout = 9000

  values = [
   # "${file("helm/values/default-affinity-node.yaml")}",
   # "${file("helm/values/prometheus-operator-values.yaml")}"
   # "${file("./values/prometheus-operator-values.yaml")}"
   
                      
  ]

}
*/

resource "helm_release" "metric-server" {
  #repository = "https://prometheus-community.github.io/helm-charts"
  #repository = "./helm/charts/"
  repository = "https://charts.bitnami.com/bitnami"
  chart     = "metrics-server"

  version    = "5.5.1"
  
  namespace = "kube-system"
  name      = "metric-server"
    
  
  wait = false    
  recreate_pods = true


  values = [
    file("./values/metric-server.yaml")
  ]
  # "${file("helm/charts/prometheus-pushgateway/values.yaml")}"
  # file("helm/charts/prometheus-pushgateway/values.yaml")
  

#  set {
#    name    = "extraArgs"
#    #value   = var.prometheus_config[local.env][local.aws_region].replicas
#    value   = "- --kubelet-insecure-tls " #- --kubelet-preferred-address-types=InternalIP # 추가된 옵션"
#  }

 
}



provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

