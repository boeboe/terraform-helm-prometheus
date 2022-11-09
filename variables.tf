variable "prometheus_helm_version" {
  description = "prometheus helm chart version"
  type        = string
}

variable "prometheus_helm_namespace" {
  description = "prometheus helm namespace"
  type        = string
  default     = "prometheus"
}

variable "prometheus_helm_repo" {
  description = "prometheus helm repository"
  type        = string
  default     = "https://prometheus-community.github.io/helm-charts"
}


variable "prometheus_settings" {
  description = "prometheus settings"
  type        = map(any)
  default     = {}
}
