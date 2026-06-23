########################################
# ECS Cluster
########################################

resource "aws_ecs_cluster" "hospital" {
  name = "hospital-microservices-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "hospital-cluster"
  }
}

########################################
# Capacity Providers
########################################

resource "aws_ecs_cluster_capacity_providers" "hospital" {
  cluster_name = aws_ecs_cluster.hospital.name

  capacity_providers = [
    "FARGATE",
    "FARGATE_SPOT"
  ]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 1
  }
}