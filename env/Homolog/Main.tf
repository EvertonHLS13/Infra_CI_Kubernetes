module "prod" {

  source = "../../infra"

  cluster_name = "homolog2"

  providers = {
    aws = aws
  }

}


output "IP_db" {

  value = module.prod.IP

}
