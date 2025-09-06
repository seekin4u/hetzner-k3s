variable "kubeconfig_path" {
  type        = string
  description = "Path to the kubeconfig from hetzner-k3s"
}

resource "kubernetes_namespace" "apps" {
  metadata { name = "apps" }
}

# resource "helm_release" "ingress_nginx" {
#   name       = "ingress-nginx"
#   namespace  = kubernetes_namespace.apps.metadata[0].name
#   repository = "https://kubernetes.github.io/ingress-nginx"
#   chart      = "ingress-nginx"
#   create_namespace = true
#   values = [
#     yamlencode({
#       controller = {
#         replicaCount = 1
#       }
#     })
#   ]
# }

# resource "helm_release" "kube_prometheus_stack" {
#   name             = "monitoring"
#   namespace        = "monitoring"
#   create_namespace = true

#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart      = "kube-prometheus-stack"

#   values = [
#     yamlencode({
#       prometheus = {
#         prometheusSpec = {
#           maximumStartupDurationSeconds = 300
#         }
#       }
#     })
#   ]
# }

resource "helm_release" "preview_sweeper" {
  name             = "namespace-preview-sweeper"
  repository       = "oci://ghcr.io/seekin4u/helm"
  chart            = "namespace-preview-sweeper"
  version          = "0.2.0"
  namespace        = "namespace-preview-sweeper"
  create_namespace = true

  values = [
    yamlencode({
      replicaCount   = 1
      serviceMonitor = { enabled = true } #false without monitoring
      leaderElection = { enabled = false }
      sweepEvery = "30m"
      ttl        = "1h"
    })
  ]
}
