########################################
# Cloud Map Private DNS Namespace
########################################

resource "aws_service_discovery_private_dns_namespace" "hospital" {
  name = "hospital.local"

  vpc = aws_vpc.main.id

  description = "Private namespace for Hospital Microservices"
}

########################################
# Patient Service
########################################

resource "aws_service_discovery_service" "patient" {

  name = "patient-service"

  dns_config {

    namespace_id = aws_service_discovery_private_dns_namespace.hospital.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

########################################
# Doctor Service
########################################

resource "aws_service_discovery_service" "doctor" {

  name = "doctor-service"

  dns_config {

    namespace_id = aws_service_discovery_private_dns_namespace.hospital.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

########################################
# Appointment Service
########################################

resource "aws_service_discovery_service" "appointment" {

  name = "appointment-service"

  dns_config {

    namespace_id = aws_service_discovery_private_dns_namespace.hospital.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

########################################
# Patient Portal
########################################

resource "aws_service_discovery_service" "portal" {

  name = "patient-portal"

  dns_config {

    namespace_id = aws_service_discovery_private_dns_namespace.hospital.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}