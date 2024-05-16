resource "aws_security_group" "petclinic-rds-sg" {
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = module.vpc.private_subnets_cidr_blocks
  }

  tags = {
    Name = "petclinic-rds-sg",
	  petclinic = ""
  }
}

module "db" {
  source = "terraform-aws-modules/rds/aws"
  version = "6.5.5"
  identifier = "petclinic-db"

  engine            = "mysql"
  engine_version    = "8.0.35"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "petclinicdb"
  username = "petclinicuser"
  password = "petclinicpassword"
  manage_master_user_password = false
  port     = "3306"

  vpc_security_group_ids = ["${aws_security_group.petclinic-rds-sg.id}"]

  tags = {
    Name = "petclinic-db",
	  petclinic = ""
  }

  skip_final_snapshot = true

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = module.vpc.private_subnets

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]
}
