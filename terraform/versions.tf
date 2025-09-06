terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.38"
    }
    helm = {
      source = "hashicorp/helm"
      version = "3.0.2"
    }
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

# provider "helm" {
#   kubernetes = {
#     host                   = var.cluster_endpoint
#     cluster_ca_certificate = base64decode(var.cluster_ca_cert)
#     exec = {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
#       command     = "aws"
#     }
#   }
# }