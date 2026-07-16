terraform {
  required_version = ">= 0.14.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.47"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      var.cluster_name
    ]
  }
}

resource "kubernetes_service_v1" "LoadBalancer" {
  metadata {
    name = "load-balancer-go-api"
  }

  spec {
    selector = {
      nome = "go"
    }

    port {
      port        = 8000
      target_port = 8000
    }

    type = "LoadBalancer"
  }
}
