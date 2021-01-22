




resource "helm_release" "kuberhealthy" {
  repository = "https://comcast.github.io/kuberhealthy/helm-repos"
  chart      = "kuberhealthy"
  version    = "2.2.0" # helm chart version kuberhealthy/kuberhealthy (App v2.2.0)

  namespace = "kuberhealthy"
  name      = "kuberhealthy"

  values = [
    file("./values/monitoring/kuberhealthy.yaml")
  ]

  set {
    name  = "checkReaper.image.tag"
    value = "v1.4.0"
  }

  wait             = false

#  depends_on = [
#    helm_release.prometheus_operator,
#    kubernetes_namespace.kuberhealthy,
#  ]
}



resource "helm_release" "prometheus-pushgateway" {
  #repository = "https://prometheus-community.github.io/helm-charts"
  repository = "./helm/charts/"
  chart     = "prometheus-pushgateway"
  version    = "1.5.1"
  
  namespace = "push3"
  name      = "pushgateway"
    
  
  wait = false    
  recreate_pods = true

  values = [
    file("./helm/charts/prometheus-pushgateway/work.yaml")
  ]
  # "${file("helm/charts/prometheus-pushgateway/values.yaml")}"
  # file("helm/charts/prometheus-pushgateway/values.yaml")
}