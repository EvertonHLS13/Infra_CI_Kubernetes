terraform {

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

  }

}


provider "aws" {

  region = "us-east-2"

}


module "homolog" {

  source = "../../infra"

  cluster_name = "homolog2"

}


output "IP_db" {

  value = module.homolog.IP

}
