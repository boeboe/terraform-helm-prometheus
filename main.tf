locals {
  prometheus_helm_version   = var.prometheus_helm_version
  prometheus_helm_namespace = var.prometheus_helm_namespace
  prometheus_helm_repo      = var.prometheus_helm_repo
  prometheus_settings       = var.prometheus_settings
}

resource "helm_release" "prometheus" {

  name             = "prometheus"
  repository       = local.prometheus_helm_repo
  chart            = "prometheus"
  version          = local.prometheus_helm_version
  create_namespace = true
  namespace        = local.prometheus_helm_namespace

  dynamic "set" {
    for_each = local.prometheus_settings
    content {
      name  = set.key
      value = set.value
    }
  }
}
