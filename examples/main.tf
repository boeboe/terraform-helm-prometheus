locals {
  kubeconfig_path = "~/.kube/config"

  prometheus_helm_version = "15.18.0"
  prometheus_settings = {
    "server.image.tag"                               = "v2.39.0"
    "alertmanager.image.tag"                         = "v0.23.0"
    "server.service.type"                            = "LoadBalancer"
    "server.podAnnotations.custom\\.annotation\\.io" = "test"
    "server.podAnnotations.environment"              = "test"
  }
}

provider "kubernetes" {
  config_path = local.kubeconfig_path
}

provider "helm" {
  kubernetes {
    config_path = local.kubeconfig_path
  }
}

module "prometheus" {
  source = "./.."

  prometheus_helm_version = local.prometheus_helm_version
  prometheus_settings     = local.prometheus_settings
}

output "prometheus_helm_metadata" {
  description = "block status of the prometheus helm release"
  value       = module.prometheus.prometheus_helm_metadata[0]
}

data "kubernetes_service" "prometheus" {
  metadata {
    name = "prometheus-server"
    namespace = "prometheus"
  }

  depends_on = [
    module.prometheus
  ]
}

output "prometheus_loadbalancer_ip" {
  description = "external loadbalancer ip address of prometheus"
  value = data.kubernetes_service.prometheus.status[0].load_balancer[0].ingress[0].ip
}
