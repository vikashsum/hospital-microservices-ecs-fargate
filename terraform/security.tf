#############################################
# ALB Security Group
#############################################

resource "aws_security_group" "alb" {

  name        = "${var.project_name}-alb-sg"
  description = "Security Group for Application Load Balancer"
  vpc_id      = aws_vpc.main.id

  ingress {

    description = "HTTP"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}

#############################################
# ECS Tasks Security Group
#############################################

resource "aws_security_group" "ecs" {

  name        = "${var.project_name}-ecs-sg"
  description = "Security Group for ECS Tasks"
  vpc_id      = aws_vpc.main.id

  ingress {

    description = "Patient Service"

    from_port = 3001
    to_port   = 3001
    protocol  = "tcp"

    security_groups = [
      aws_security_group.alb.id
    ]
  }

  ingress {

    description = "Appointment Service"

    from_port = 3002
    to_port   = 3002
    protocol  = "tcp"

    security_groups = [
      aws_security_group.alb.id
    ]
  }

  ingress {

    description = "Doctor Service"

    from_port = 3003
    to_port   = 3003
    protocol  = "tcp"

    security_groups = [
      aws_security_group.alb.id
    ]
  }

  ingress {

    description = "Patient Portal"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    security_groups = [
      aws_security_group.alb.id
    ]
  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "${var.project_name}-ecs-sg"
  }
}