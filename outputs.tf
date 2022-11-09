output "prometheus_helm_metadata" {
  description = "block status of the prometheus helm release"
  value       = helm_release.prometheus.metadata
}
