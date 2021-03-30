/*
module "prometheus_security_group" {
  source = "./modules/external_service_security_group"
  name = "prometheus-external"
  cluster_name     = local.cluster_name
  node_security_group = data.terraform_remote_state.cluster.outputs.node_security_group
  https_endpoint_restricts = var.https_endpoint_restricts
  extra_endpoint_restricts = var.prometheus_endpoint_restricts
  vpc_id = data.aws_vpc.my_vpc.id
}
*/
/*
module "prometheus_endpoint" {
  source = "./modules/public_domain"
  root_domain_name = local.external_dns_base_domain
  domain_name      = "${local.cluster_name}.prometheus"
  alias            = kubernetes_service.kubernetes-prometheus.status.0.load_balancer.0.ingress.0.hostname
  assume_role      = var.external_domain_info[local.env]["assume_role"]
}
*/

/*

resource "kubernetes_namespace" "prometheus_ns" {
  metadata {
    annotations = {
      name = "prometheus"
    }
    labels = {
      role = "prometheus"
    }
    name = "prometheus"
  }
*/


/*
resource "helm_release" "prometheus" {
  #depends_on = [kubernetes_namespace.prometheus_ns]
  namespace = "prometheus"

  name      = "stack"  
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
    "${file("./values/prometheus-operator-values.yaml")}"                      
  ]

    # storageSpec:
    #   volumeClaimTemplate:
    #     spec:
    #       storageClassName: csi-hostpath-sc
  

  # set {
  #   name    = "prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.storageClassName"
  #   value   = "csi-hostpath-sc"
  # }gudrlagggggfgrla

  set {
    name    = "prometheus.prometheusSpec.replicas"
    #value   = var.prometheus_config[local.env][local.aws_region].replicas
    value   = 1
  }
  set {
    name    = "prometheus.prometheusSpec.resources.requests.cpu"
    #value   = var.prometheus_config[local.env][local.aws_region].resources.requests.cpu
    value   = "1000m"
  }
  set {
    name    = "prometheus.prometheusSpec.resources.requests.memory"
    #value   = var.prometheus_config[local.env][local.aws_region].resources.requests.memory
    value   = "1Gi"
  }
  set {
    name    = "prometheus.prometheusSpec.resources.limits.cpu"
    #value   = var.prometheus_config[local.env][local.aws_region].resources.limits.cpu
    value   = "1000m"
  }
  set {
    name    = "prometheus.prometheusSpec.resources.limits.memory"
    #value   = var.prometheus_config[local.env][local.aws_region].resources.limits.memory
    value   = "1Gi"
  }
  set {
    name    = "prometheusOperator.enabled"
    value   = true
  }
  
  # set {
  #   name    = "prometheusOperator.admissionWebhooks.enabled"
  #   value   = false
  # }
  # set {
  #   name    = "prometheusOperator.tlsProxy.enabled"
  #   value   = false
  # }
  
  set {
    name    = "grafana.enabled"
    value   = false
  }

}

*/

/*
resource "kubernetes_service" "kubernetes-prometheus" {
  metadata {
    name = "prometheus"
    namespace = "prometheus"
    
    # annotations = {
    #   "service.beta.kubernetes.io/aws-load-balancer-ssl-ports" = "443"
    #   "service.beta.kubernetes.io/aws-load-balancer-ssl-cert" = "${module.prometheus_endpoint.acm_arn}"
    #   "service.beta.kubernetes.io/aws-load-balancer-backend-protocol" = "tcp"
    #   "service.beta.kubernetes.io/aws-load-balancer-ssl-negotiation-policy" = "${local.external_lb_ssl_policy}"
    #   "service.beta.kubernetes.io/aws-load-balancer-security-groups" = "${module.prometheus_security_group.https_endpoint_id}"
    #   "service.beta.kubernetes.io/aws-load-balancer-additional-resource-tags" = "Name=${local.cluster_name}.prometheus,class1=Monitoring,class0=Operation,developer=justine.bang"
    # }
    
  }
  spec {
    selector = {
      "app" = "prometheus"
    }
    port {
      port        = 443 
      target_port = 9090
      protocol = "TCP"
    }
    type = "NodePort"
  }
}
*/