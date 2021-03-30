

resource "helm_release" "thanos2" {

  //depends_on = [kubernetes_namespace.kuberhealthy_ns]

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "thanos"
  version    = "3.13.2" # helm chart version kuberhealthy/kuberhealthy (App v2.2.0)

  namespace = "monitoring"
  name      = "thanos"

  values = [
    file("./values/thanos-monitoring.yaml")
  ]


  wait             = false

#  depends_on = [
#    helm_release.prometheus_operator,
#    kubernetes_namespace.kuberhealthy,
#  ]
}


