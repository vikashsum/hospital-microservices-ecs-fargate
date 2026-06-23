resource "aws_ecs_service" "patient" {
  name            = "patient-service"
  cluster         = aws_ecs_cluster.hospital.id
  task_definition = aws_ecs_task_definition.patient.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets = aws_subnet.private[*].id

    security_groups = [
      aws_security_group.ecs.id
    ]

    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.patient.arn
    container_name   = "patient-service"
    container_port   = 3001
  }

  service_registries {
    registry_arn = aws_service_discovery_service.patient.arn
  }

  depends_on = [
    aws_lb_listener.http
  ]
}
resource "aws_ecs_service" "appointment" {
  name            = "appointment-service"
  cluster         = aws_ecs_cluster.hospital.id
  task_definition = aws_ecs_task_definition.appointment.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets = aws_subnet.private[*].id

    security_groups = [
      aws_security_group.ecs.id
    ]

    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.appointment.arn
    container_name   = "appointment-service"
    container_port   = 3002
  }

  service_registries {
    registry_arn = aws_service_discovery_service.appointment.arn
  }

  depends_on = [
    aws_lb_listener.http
  ]
}
resource "aws_ecs_service" "doctor" {
  name            = "doctor-service"
  cluster         = aws_ecs_cluster.hospital.id
  task_definition = aws_ecs_task_definition.doctor.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets = aws_subnet.private[*].id

    security_groups = [
      aws_security_group.ecs.id
    ]

    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.doctor.arn
    container_name   = "doctor-service"
    container_port   = 3003
  }

  service_registries {
    registry_arn = aws_service_discovery_service.doctor.arn
  }

  depends_on = [
    aws_lb_listener.http
  ]
}
resource "aws_ecs_service" "portal" {
  name            = "patient-portal"
  cluster         = aws_ecs_cluster.hospital.id
  task_definition = aws_ecs_task_definition.portal.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets = aws_subnet.private[*].id

    security_groups = [
      aws_security_group.ecs.id
    ]

    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.portal.arn
    container_name   = "patient-portal"
    container_port   = 80
  }

  service_registries {
    registry_arn = aws_service_discovery_service.portal.arn
  }

  depends_on = [
    aws_lb_listener.http
  ]
}
