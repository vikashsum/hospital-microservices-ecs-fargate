#############################################
# RDS Security Group
#############################################

resource "aws_security_group" "rds" {

  name        = "${var.project_name}-rds-sg"
  description = "Security Group for PostgreSQL"
  vpc_id      = aws_vpc.main.id

  ingress {

    description = "Allow PostgreSQL from ECS"

    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"

    security_groups = [
      aws_security_group.ecs.id
    ]
  }

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-rds-sg"
  }
}

#############################################
# DB Subnet Group
#############################################

resource "aws_db_subnet_group" "main" {

  name = "${var.project_name}-db-subnet-group"

  subnet_ids = [
    aws_subnet.private[0].id,
    aws_subnet.private[1].id
  ]

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

#############################################
# PostgreSQL RDS Instance
#############################################

resource "aws_db_instance" "postgres" {

  identifier = "hospital-postgres"

  engine         = "postgres"
  engine_version = "17.5"

  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "hospital_patient_db"
  username = "postgres"
  password = "Password123!"

  port = 5432

  publicly_accessible = false

  multi_az = false

  db_subnet_group_name = aws_db_subnet_group.main.name

  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]

  skip_final_snapshot = true

  deletion_protection = false

  tags = {
    Name = "hospital-postgres"
  }
}