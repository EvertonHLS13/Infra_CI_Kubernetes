terraform {

  required_version = ">= 1.5.0"


  required_providers {

    aws = {

      source  = "hashicorp/aws"
      version = ">= 5.0"

    }


    kubernetes = {

      source = "hashicorp/kubernetes"
      version = ">= 2.20"

    }

  }

}



provider "aws" {

  region = "us-east-2"

}



data "aws_eks_cluster" "cluster" {

  name = var.cluster_name

}



data "aws_eks_cluster_auth" "cluster" {

  name = var.cluster_name

}



provider "kubernetes" {


  host = data.aws_eks_cluster.cluster.endpoint


  cluster_ca_certificate = base64decode(
    data.aws_eks_cluster.cluster.certificate_authority[0].data
  )


  token = data.aws_eks_cluster_auth.cluster.token

}



resource "kubernetes_service_v1" "LoadBalancer" {


  depends_on = [
    module.eks
  ]


  metadata {

    name = "load-balancer-go-api"

  }


  spec {


    selector = {

      nome = "go"

    }


    port {

      port = 8000

      target_port = 8000

    }


    type = "LoadBalancer"


  }

}
