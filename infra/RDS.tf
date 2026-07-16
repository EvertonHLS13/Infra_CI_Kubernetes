resource "aws_db_instance" "default" {


  identifier = "api-go-dev"


  allocated_storage = 20



  engine = "postgres"



  instance_class = "db.t3.micro"



  db_name = "api"



  username = "postgres"



  password = "rootroot"



  publicly_accessible = false



  skip_final_snapshot = true



  deletion_protection = false



  db_subnet_group_name = module.vpc.database_subnet_group_name



  vpc_security_group_ids = [

    aws_security_group.db.id

  ]


}



output "IP_db" {

  value = aws_db_instance.default.address

}
