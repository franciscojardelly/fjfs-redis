locals {
  common_tags = merge(var.tags, {
    Project     = var.project
    Environment = var.environment
  })
}

resource "aws_elasticache_subnet_group" "this" {
  name        = "${var.project}-${var.environment}-redis"
  description = "Subnet group for the ${var.project} ${var.environment} ElastiCache Redis cluster."
  subnet_ids  = var.subnet_ids

  tags = local.common_tags
}

resource "aws_elasticache_replication_group" "this" {
  replication_group_id = "${var.project}-${var.environment}-redis"
  description          = "Redis OSS 7 replication group (cluster mode disabled) for ${var.project} ${var.environment}."

  # Engine
  engine         = "redis"
  engine_version = var.engine_version

  # Topology — cluster mode disabled, single shard with optional read replicas
  cluster_mode               = "disabled"
  num_cache_clusters         = var.num_cache_clusters
  automatic_failover_enabled = var.automatic_failover_enabled
  multi_az_enabled           = var.multi_az_enabled
  node_type                  = var.node_type
  port                       = var.port

  # Network
  subnet_group_name  = aws_elasticache_subnet_group.this.name
  security_group_ids = [aws_security_group.this.id]

  # Encryption — transit required (TLS-only), at-rest AES-256, Redis AUTH token
  transit_encryption_enabled = true
  transit_encryption_mode    = "required"
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  auth_token                 = random_password.auth_token.result
  auth_token_update_strategy = "ROTATE"

  # Maintenance & backups
  auto_minor_version_upgrade = true
  maintenance_window         = var.maintenance_window
  snapshot_retention_limit   = var.snapshot_retention_limit
  snapshot_window            = var.snapshot_window

  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.redis_slow_log.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "slow-log"
  }

  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.redis_engine_log.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "engine-log"
  }

  tags = local.common_tags

  depends_on = [aws_secretsmanager_secret_version.auth_token]
}
