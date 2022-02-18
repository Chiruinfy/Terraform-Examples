provider "aws" {
    access_key = var.accesskey
    secret_key = var.secretkey
    region = var.region
}



resource "aws_security_group" "postgres-sg" {

    name        = "psg-sg"
  description = "Complete PostgreSQL example security group"
  vpc_id      = aws_vpc.myvpc.id

  # ingress
  ingress {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL access from within VPC"
      cidr_blocks = ["192.168.0.0/16"]
    }

}




resource "aws_db_instance" "RDS" {

    engine               = "postgres"
  engine_version       = "14.1"
  instance_class       = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 100



  db_name  = "completePostgresql"
  username = "complete_postgresql"
  password             = "Test@123456"
  port     = 5432

  multi_az               = true
  db_subnet_group_name   = "db subnet group for rds"
  vpc_security_group_ids = [aws_security_group.postgres-sg.id]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  

  monitoring_interval                   = 60
  
  

  
}
  
