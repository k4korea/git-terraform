


/*resource "kubernetes_namespace" "kuberhealthy_ns" {

  metadata {
    annotations = {
      name = "kuberhealthy"
    }
    name = "kuberhealthy"
  }
}
*/


resource "helm_release" "kuberhealthy" {

  //depends_on = [kubernetes_namespace.kuberhealthy_ns]

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




resource "helm_release" "kuberhealthy-checks" {

  depends_on = [
    helm_release.kuberhealthy,
    //kubernetes_namespace.kuberhealthy_ns
  ]

  name      = "kuberhealthy-checks"
  namespace = "kuberhealthy"
  chart     = "kuberhealthy-checks"

  repository = "./helm/charts"

  set {
    name    = "filemeta_service.endpoint"
    #value   = "http://${kubernetes_service.filemeta_internal.status.0.load_balancer.0.ingress.0.hostname}:10080"
    value   = "http://bit-nginx.default.svc.cluster.local:8080"
  }

}
