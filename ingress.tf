


resource "helm_release" "ingress" {

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "3.25.0" # helm chart version kuberhealthy/kuberhealthy (App v2.2.0)

  namespace = "nginx"
  name      = "ingress"

  values = [
    file("./values/ingress.yaml")
  ]

  timeout = 100
}  
