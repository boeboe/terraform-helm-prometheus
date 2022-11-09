# terraform-helm-prometheus

![Terraform Version](https://img.shields.io/badge/terraform-≥_1.0.0-blueviolet)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/boeboe/terraform-helm-prometheus?label=registry)](https://registry.terraform.io/modules/boeboe/prometheus/helm)
[![GitHub issues](https://img.shields.io/github/issues/boeboe/terraform-helm-prometheus)](https://github.com/boeboe/terraform-helm-prometheus/issues)
[![Open Source Helpers](https://www.codetriage.com/boeboe/terraform-helm-prometheus/badges/users.svg)](https://www.codetriage.com/boeboe/terraform-helm-prometheus)
[![MIT Licensed](https://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

This terraform module will deploy [prometheus](https://prometheus.io) on any kubernetes cluster, using the community [helm chart](https://artifacthub.io/packages/helm/prometheus-community/prometheus).

| Helm Chart | Repo | Default Values |
|------------|------|--------|
| prometheus-community | [repo](https://artifacthub.io/packages/helm/prometheus-community/prometheus) | [values](https://artifacthub.io/packages/helm/prometheus-community/prometheus?modal=values) |


## Usage

``` hcl
provider "kubernetes" {
  config_path    = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
  }
}

module "prometheus" {
  source  = "boeboe/prometheus/helm"
  version = "0.0.1"

  prometheus_helm_version = "15.18.0"

  prometheus_settings = {
    "server.image.tag"                               = "v2.39.0"
    "alertmanager.image.tag"                         = "v0.23.0"
    "server.service.type"                            = "LoadBalancer"
    "server.podAnnotations.custom\\.annotation\\.io" = "test"
    "server.podAnnotations.environment"              = "test"
  }

}

output "prometheus_helm_metadata" {
  description = "block status of the prometheus prometheus helm release"
  value = module.prometheus.prometheus_helm_metadata[0]
}
```

Check the [examples](examples) for more details.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| prometheus_helm_version | prometheus helm chart version | string | - | true |
| prometheus_helm_namespace | prometheus helm namespace | string | "prometheus" | false |
| prometheus_helm_repo | prometheus helm repository | string | "https://prometheus-community.github.io/helm-charts" | false |
| prometheus_settings | prometheus settings | map | {} | false |

> **INFO:** in order to overwrite specific versions of the `server`, `alertmanager`, `nodeExporter` or `pushgateway` containers used, override the correct `tag` parameters in the helm chart [default values](https://artifacthub.io/packages/helm/prometheus-community/prometheus?modal=values)

## Outputs

| Name | Description | Type |
|------|-------------|------|
| prometheus_helm_metadata | block status of the prometheus helm release | list |


Example output:

``` hcl
prometheus_helm_metadata = {
  "app_version" = "2.39.1"
  "chart" = "prometheus"
  "name" = "prometheus"
  "namespace" = "prometheus"
  "revision" = 1
  "values" = "{\"alertmanager\":{\"image\":{\"tag\":\"v0.23.0\"}},\"server\":{\"image\":{\"tag\":\"v2.39.0\"},\"podAnnotations\":{\"custom.annotation.io\":\"test\",\"environment\":\"test\"},\"service\":{\"type\":\"LoadBalancer\"}}}"
  "version" = "15.18.0"
}
```

## More information

TBC

## License

terraform-helm-prometheus is released under the **MIT License**. See the bundled [LICENSE](LICENSE) file for details.
