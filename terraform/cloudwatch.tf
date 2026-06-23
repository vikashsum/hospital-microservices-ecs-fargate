resource "aws_cloudwatch_log_group" "patient" {
  name              = "/ecs/patient-service"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "doctor" {
  name              = "/ecs/doctor-service"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "appointment" {
  name              = "/ecs/appointment-service"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "portal" {
  name              = "/ecs/patient-portal"
  retention_in_days = 30
}