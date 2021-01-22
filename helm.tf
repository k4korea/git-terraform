

#resource "helm_release" "mongodb-sharded" {
#  name      = "mongodb-sharded"
#  chart     = "mongodb-sharded"
#  repository = "https://charts.bitnami.com/bitnami"
#  timeout = 600
#}

# 됨

resource "helm_release" "nginx_ingress" {
 name       = "bitnaminginx2"
 repository = "https://charts.bitnami.com/bitnami"
 chart      = "nginx"
 version    = "8.3.0"
 wait = false        // 이걸 해줘야 되나.
 timeout = 900
}

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

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

