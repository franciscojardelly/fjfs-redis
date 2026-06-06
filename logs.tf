resource "aws_cloudwatch_log_group" "redis_slow_log" {
  name              = "/${var.project}/${var.environment}/redis/slow-log"
  retention_in_days = var.log_retention_days

  tags = local.common_tags
}

resource "aws_cloudwatch_log_group" "redis_engine_log" {
  name              = "/${var.project}/${var.environment}/redis/engine-log"
  retention_in_days = var.log_retention_days

  tags = local.common_tags
}