locals {
  app_name           = var.app_name
  name               = "${local.app_name}-${var.environment}"
  port               = 80
  ecs_log_group_name = "/aws/ecs/${local.name}"
  database_name      = var.app_name
  tags = {
    Environment = var.environment
    Project     = local.app_name
  }
}
